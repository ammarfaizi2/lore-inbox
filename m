Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSGLN1B>; Fri, 12 Jul 2002 09:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSGLN1B>; Fri, 12 Jul 2002 09:27:01 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:11271 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S316339AbSGLN07>;
	Fri, 12 Jul 2002 09:26:59 -0400
Date: Fri, 12 Jul 2002 17:27:49 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing static in lib/vsprinf.c
Message-ID: <20020712132749.GA312@pazke.ipt>
Mail-Followup-To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

attached patch adds missing static modifiers for small_digits[] and=20
large_digits[] arrays in the number() function from lib/vsprintf.c

Patch against 2.5.25, should apply to 2.4.x.
Please consider applying.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-vsprintf
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/lib/vsprintf.c linux/lib/vsp=
rintf.c
--- linux.vanilla/lib/vsprintf.c	Thu Jun 20 12:55:58 2002
+++ linux/lib/vsprintf.c	Fri Jul 12 13:25:11 2002
@@ -131,8 +131,8 @@
 {
 	char c,sign,tmp[66];
 	const char *digits;
-	const char small_digits[] =3D "0123456789abcdefghijklmnopqrstuvwxyz";
-	const char large_digits[] =3D "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
+	static const char small_digits[] =3D "0123456789abcdefghijklmnopqrstuvwxy=
z";
+	static const char large_digits[] =3D "0123456789ABCDEFGHIJKLMNOPQRSTUVWXY=
Z";
 	int i;
=20
 	digits =3D (type & LARGE) ? large_digits : small_digits;

--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9LtlVBm4rlNOo3YgRAq+mAKCEEMfeYqb5AmBE4Pyq2CNU8Fy7VQCghjoC
63FIxTeJOc3E3rCFpA/E7co=
=lsIK
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
