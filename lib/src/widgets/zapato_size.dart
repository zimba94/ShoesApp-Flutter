import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/models/zapato_model.dart';
import 'package:shoes_app/src/pages/zapato_desc_page.dart';

class ZapatoSizePreview extends StatelessWidget {
  final bool fullscreen;
  const ZapatoSizePreview({Key key, this.fullscreen = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!this.fullscreen) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ZapatoDescPage()));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: fullscreen ? 5 : 30, vertical: fullscreen ? 5 : 0),
        child: Container(
            width: double.infinity,
            height: fullscreen ? 400 : 430,
            decoration: BoxDecoration(
                color: Color(0xffFFCF53),
                borderRadius: (!fullscreen)
                    ? BorderRadius.circular(50)
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
            child: Column(
              children: [
                _ZapatoConSombra(),
                if (!this.fullscreen) _ZapatoTallas()
              ],
            )),
      ),
    );
  }
}

class _ZapatoConSombra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final zapatoModel = Provider.of<ZapatoModel>(context);
    return Padding(
      padding: EdgeInsets.all(50),
      child: Stack(
        children: [
          Positioned(bottom: 20, right: 0, child: _ZapatoSombra()),
          Image(image: AssetImage(zapatoModel.assetImage))
        ],
      ),
    );
  }
}

class _ZapatoSombra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.6,
      child: Container(
        width: 230,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [BoxShadow(color: Color(0xffEAA14E), blurRadius: 40)]),
      ),
    );
  }
}

class _ZapatoTallas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _TallaZapatoCaja(7),
          _TallaZapatoCaja(7.5),
          _TallaZapatoCaja(8),
          _TallaZapatoCaja(8.5),
          _TallaZapatoCaja(9),
          _TallaZapatoCaja(9.5)
        ],
      ),
    );
  }
}

class _TallaZapatoCaja extends StatelessWidget {
  final double numero;
  const _TallaZapatoCaja(this.numero);

  @override
  Widget build(BuildContext context) {
    final zapatoModel = Provider.of<ZapatoModel>(context);

    return GestureDetector(
      onTap: () {
        final zapatoModel = Provider.of<ZapatoModel>(context, listen: false);
        zapatoModel.talla = this.numero;
      },
      child: Container(
        alignment: Alignment.center,
        child: Text('${numero.toString().replaceAll('.0', '')}',
            style: TextStyle(
                color: (this.numero == zapatoModel.talla)
                    ? Colors.white
                    : Color(0xffF1A23A),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: (this.numero == zapatoModel.talla)
                ? Colors.deepOrange
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: (this.numero == zapatoModel.talla)
                ? [
                    BoxShadow(
                        color: Color(0xffF1A23A),
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]
                : []),
      ),
    );
  }
}
