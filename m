Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSKYJmM>; Mon, 25 Nov 2002 04:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSKYJmL>; Mon, 25 Nov 2002 04:42:11 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:55051 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262789AbSKYJmK>;
	Mon, 25 Nov 2002 04:42:10 -0500
Date: Mon, 25 Nov 2002 12:48:28 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Pavel Jan?k <Pavel@Janik.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
Message-ID: <20021125094828.GA6016@pazke.ipt>
Mail-Followup-To: Pavel Jan?k <Pavel@Janik.cz>,
	linux-kernel@vger.kernel.org
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt> <m3fztrcinh.fsf@Janik.cz> <20021124114307.A25408@flint.arm.linux.org.uk> <m3vg2naupr.fsf@Janik.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <m3vg2naupr.fsf@Janik.cz>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

patch looks good, but here is yet another thing to test.
We need to know base baudrate of this card. I failed to find=20
HT6552 datasheet on Holtek site, so we need another experiment.

You can test it this way:

1) connect one port of this card with normal serial port or any=20
   serial device with known baudrate;
2) test data transfer, if it fails try to set lower speed on PCI card's por=
t.
3) if you found needed speed, calculate base baudrate
 <base baudrate> =3D (<speed of normal port> / <speed of PCI card port>) * =
115200

Good luck.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE94fHsBm4rlNOo3YgRAj0sAJ99Ao9vAuG7vOtqxXya3reNTkW5ZgCfUEp5
/2Vpg/4rqk9lqBKpk2FT9JM=
=CztE
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
