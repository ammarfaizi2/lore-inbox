Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSEYVON>; Sat, 25 May 2002 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSEYVON>; Sat, 25 May 2002 17:14:13 -0400
Received: from ppp-217-133-216-97.dialup.tiscali.it ([217.133.216.97]:33200
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S315375AbSEYVOM>; Sat, 25 May 2002 17:14:12 -0400
Subject: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
	-march=pentium{-mmx,3,4}
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-QZv9z27s94DCBow+65XG"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 May 2002 23:01:14 +0200
Message-Id: <1022360474.21238.5.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QZv9z27s94DCBow+65XG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This trival patch adds support for GCC 3.1 -march=3Dpentium{-mmx,3,4}
option and applies to both 2.4 and 2.5.

--- linux-vanilla/arch/i386/Makefile	Wed Apr 10 14:37:33 2002
+++ linux/arch/i386/Makefile	Sat May 25 22:53:08 2002
@@ -43,7 +43,7 @@
 endif
=20
 ifdef CONFIG_M586MMX
-CFLAGS +=3D -march=3Di586
+CFLAGS +=3D $(shell if $(CC) -march=3Dpentium-mmx -S -o /dev/null -xc /dev=
/null >/dev/null 2>&1; then echo "-march=3Dpentium-mmx"; else echo "-march=
=3Di586"; fi)
 endif
=20
 ifdef CONFIG_M686
@@ -51,11 +51,11 @@
 endif
=20
 ifdef CONFIG_MPENTIUMIII
-CFLAGS +=3D -march=3Di686
+CFLAGS +=3D $(shell if $(CC) -march=3Dpentium3 -S -o /dev/null -xc /dev/nu=
ll >/dev/null 2>&1; then echo "-march=3Dpentium3"; else echo "-march=3Di686=
"; fi)
 endif
=20
 ifdef CONFIG_MPENTIUM4
-CFLAGS +=3D -march=3Di686
+CFLAGS +=3D $(shell if $(CC) -march=3Dpentium4 -S -o /dev/null -xc /dev/nu=
ll >/dev/null 2>&1; then echo "-march=3Dpentium4"; else echo "-march=3Di686=
"; fi)
 endif
=20
 ifdef CONFIG_MK6


--=-QZv9z27s94DCBow+65XG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA87/uZdjkty3ft5+cRAjifAKCVXxhOaGkwcJyh/vCMDSCsg4h4uACgmaLi
YsaSQ4QYzCvcMwY+ISUb8dI=
=e2VT
-----END PGP SIGNATURE-----

--=-QZv9z27s94DCBow+65XG--
