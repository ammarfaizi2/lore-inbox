Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264853AbUGSX0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264853AbUGSX0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 19:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGSX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 19:26:36 -0400
Received: from smtp09.auna.com ([62.81.186.19]:55762 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S264701AbUGSX00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 19:26:26 -0400
Date: Tue, 20 Jul 2004 01:26:24 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc2
Message-ID: <20040719232624.GA6118@werewolf.able.es>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org> (from torvalds@osdl.org on Sun, Jul 18, 2004 at 07:41:59 +0200)
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.07.18, Linus Torvalds wrote:
>=20
> MTD updates, i2c updates and some USB updates, and a lot of small stuff
> (sparse cleanups and fixes from Al etc).
>=20
> 		Linus
>=20
> Summary of changes from v2.6.8-rc1 to v2.6.8-rc2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

Please, could you include this ? It allows to build aic driver with db4:

--- linux-2.6.0-test11/drivers/scsi/aic7xxx/aicasm/Makefile.orig	2003-12-02=
 23:52:29.000000000 +0100
+++ linux-2.6.0-test11/drivers/scsi/aic7xxx/aicasm/Makefile	2003-12-03 00:0=
1:04.000000000 +0100
@@ -34,10 +34,14 @@
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG) $(LIBS)
=20
 aicdb.h:
-	@if [ -e "/usr/include/db3/db_185.h" ]; then		\
+	@if [ -e "/usr/include/db4/db_185.h" ]; then		\
+		echo "#include <db4/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db2/db_185.h" ]; then		\
 		echo "#include <db2/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db1/db_185.h" ]; then		\
+		echo "#include <db1/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db/db_185.h" ]; then		\
 		echo "#include <db/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db_185.h" ]; then		\


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Alpha 1) for i586
Linux 2.6.8-rc1-jam1 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-1mdk)) #1

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA/FigRlIHNEGnKMMRAiDmAJ94WQTtd0pkk7ResMo+tj0+GaWYNgCbB0wO
vvE5zHNLsMmWZ1rWtOjCZ94=
=5w6F
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
