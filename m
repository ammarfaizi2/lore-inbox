Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUBWUvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUBWUvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:51:35 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:57254 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261903AbUBWUvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:51:32 -0500
Subject: Re: [linux 2.6.3] [gcc 3.3.3] compile errors
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: MALET JL <malet.jean-luc@laposte.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <403A2ADB.9040002@laposte.net>
References: <403911B3.10601@laposte.net>
	 <20040223074221.5f711665.rddunlap@osdl.org>  <403A2ADB.9040002@laposte.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zvR304Iw2c/9sp5yalRe"
Message-Id: <1077569540.19268.13.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 22:52:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zvR304Iw2c/9sp5yalRe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-23 at 18:31, MALET JL wrote:
> Randy.Dunlap a =C3=A9crit :
>=20
> >On Sun, 22 Feb 2004 21:31:47 +0100 mjl <malet.jean-luc@laposte.net> wrot=
e:
> >
> >| hello please cc me since I'm not a member
> >| all my builds fails with this error
> >|=20
> >| In file included from ../include/swab.h:20,
> >|                  from ../include/misc.h:12,
> >|                  from io.c:21:
> >| /usr/include/linux/byteorder/swab.h:133: error: syntax error before "_=
_u16"
> >| /usr/include/linux/byteorder/swab.h:146: error: syntax error before "_=
_u32"
> >
> >You are using userspace headers for building the kernel.
> >Maybe you have a symbolic link from linux/include/asm to the
> >userspace headers.  If so, Don't Do That.
> >In any case, don't use userspace headers to build the kernel.
> > =20
> >
> the problem is that this is a part of compile log from a userspace=20
> program....... I builded the kernel right but can't compile some=20
> userspace programs (such as Mplayer, linux-utils.....)
> the configuration I use :
> copy from /usr/src/linux/include/asm to /usr/include/asm
> copy from /usr/src/linux/include/asm-generic to /usr/include/asm-generic
> copy from /usr/src/linux/include/linux to /usr/include/linux
>=20
> is this wrong ? I've done this all the time (since 2.4.2 kernel) without=20
> problem..... if i'm wrong please correct my behaviour
>=20

Just edit offending files and take out the '__attribute_const__'s - I am
guessing you tried to compile cdrtools ... =3D)

> >
> >| make[1]: *** [io.o] Error 1
> >| make[1]: Leaving directory `/usr/src/sorcery/reiserfsprogs-3.6.13/lib'
> >| make: *** [all-recursive] Error 1
> >|=20
> >|=20
> >| I looked into the source and  the line is
> >|=20
> >|=20
> >| static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
> >| {
> >|=20
> >|=20
> >| which don't looks bad ......
> >
> >
> >
> >--
> >~Randy
> > =20
> >
--=20
Martin Schlemmer

--=-zvR304Iw2c/9sp5yalRe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAOmgEqburzKaJYLYRAsjSAJ0aLL4RWs1sNxGsJ0UndNeTB0g8fgCgjzW6
RnRk5gw98ErmmUPqa1fwQPc=
=b4Wp
-----END PGP SIGNATURE-----

--=-zvR304Iw2c/9sp5yalRe--

