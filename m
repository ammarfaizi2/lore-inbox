Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130260AbRBZPKk>; Mon, 26 Feb 2001 10:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130255AbRBZPJw>; Mon, 26 Feb 2001 10:09:52 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:40454 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130263AbRBZPHQ>; Mon, 26 Feb 2001 10:07:16 -0500
Date: Mon, 26 Feb 2001 18:06:32 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/serial.c unchecked ioremap() calls
Message-ID: <20010226180632.A13876@orbita1.ru>
In-Reply-To: <20010223105359.A20170@orbita1.ru> <20010223064543.C12444@conectiva.com.br> <3A967081.5CDF5797@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A967081.5CDF5797@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Feb 23, 2001 at 09:15:29AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2001 at 09:15:29AM -0500, Jeff Garzik wrote:
> Arnaldo Carvalho de Melo wrote:
> >=20
> > Em Fri, Feb 23, 2001 at 10:53:59AM +0300, Andrey Panin escreveu:
> > >
> > > Hi all,
> > >
> > > 16x50 serial driver doesn't check ioremap() return value.
> > > Atached patch should fix this it.
> >=20
> > humm, have not checked, but it seems as if you don't release the previo=
us
> > successful mappings on failure. Wipe out this message if I was too quic=
k to
> > answer and this is not true. 8)
>=20
> Also, the proper return from a failed ioremap is -ENOMEM, so I think
> Andrey's serial.c patch should modify some functions to return a failure
> code...
>=20

All these ioremap() failures are not fatal,=20
just fail to init one PCI/ISAPNP device or one serial port.
IMHO a warning message will be enough for them :)

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6mnD4Bm4rlNOo3YgRAqeUAJwPiKrPeU3rO1V/DSw3brUHKWeBrQCfcxR5
WAuOYOlHgMyxF/MpydSJJ+Y=
=pjwN
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
