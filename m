Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSBIH1D>; Sat, 9 Feb 2002 02:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288565AbSBIH0u>; Sat, 9 Feb 2002 02:26:50 -0500
Received: from mailout.informatik.tu-muenchen.de ([131.159.0.5]:17653 "EHLO
	mailout.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S288557AbSBIH0e>; Sat, 9 Feb 2002 02:26:34 -0500
Subject: read()/write() vs. ptr dereference question
From: Daniel Stodden <stodden@in.tum.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-hLjaGY05eF3JXyyTxNnT"
X-Mailer: Evolution/1.0.2 
Date: 09 Feb 2002 08:26:22 +0100
Message-Id: <1013239582.725.43.camel@bitch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hLjaGY05eF3JXyyTxNnT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


hi.

as correctly pointed out throughout the relevant literature, accessing
I/O memory through lame pointer dereferences is not portable and on
linux use of read()/write() instead is highly recommended.

i've come across an application where some piece of code expects some
piece of memory (RAM) returned from some other piece of code and the
latter one might actually benefit from pointing at something not memory
but rather something located in PCI memory space instead.=20

i'm currently mostly concerned about intel and ppc and obviously it will
be okay there. otoh, sparc may be of future interest. i don't know too
much about sparc but according to the headers sparc64 definitely won't
work.
(right here? or would it work and io.h uses just a better alternative?)

my main question regarding portability is: is there some kind of macro
anywhere, like #if __IO_AND_PHYS_LOOK_THE_SAME, which i just haven't
found yet or do i need to explicitly check for any arch in question?

[or: should such a macro exist? might somehow clean up the headers a
little...]

thanx,
daniel

--=20
___________________________________________________________________________
 mailto:stodden@in.tum.de



--=-hLjaGY05eF3JXyyTxNnT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8ZM8dSPSplX5M5nQRAqU9AJ4tBsIDrd4BjYbPkxUohft+fxNdTQCfVS4f
LE0PM9oAtdUnMjoX1YL+x9c=
=OLaI
-----END PGP SIGNATURE-----

--=-hLjaGY05eF3JXyyTxNnT--
