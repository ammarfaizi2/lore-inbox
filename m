Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUGTAFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUGTAFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 20:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUGTAFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 20:05:49 -0400
Received: from smtp06.auna.com ([62.81.186.16]:47346 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264931AbUGTAFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 20:05:46 -0400
Date: Tue, 20 Jul 2004 02:05:45 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm1
Message-ID: <20040720000545.GC4680@werewolf.able.es>
References: <20040713182559.7534e46d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org> (from akpm@osdl.org on Wed, Jul 14, 2004 at 03:25:59 +0200)
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.07.14, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2=
.6.8-rc1-mm1/
>=20

This allows to build aic with db4, could you apply, please:

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

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA/GHZRlIHNEGnKMMRArEfAJwKiM0T6xJ3p2DONu+4FuLvxVcmbgCfWFT3
WZPfkKVW8wSTFBNzwNn1ggM=
=HTp9
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
