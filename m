Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWEOTGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWEOTGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWEOTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:06:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:41399 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932457AbWEOTGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:06:47 -0400
X-Authenticated: #2425915
Date: Mon, 15 May 2006 21:06:41 +0200
From: Sven Schuster <schuster.sven@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] fix erroneous strcmp in modpost.c
Message-ID: <20060515190639.GA1357@zion.homelinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


Hi Andrew,

attached patch fixes an erroneous strcmp in modpost.c which let the
build of some external modules (madwifi, vloopback) on 2.6.17-rc4-mm1
fail. Additionally a small codingstyle one-liner :-)

kind regards,

Sven

Signed-off-by: Sven Schuster <schuster.sven@gmx.de>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="modpost-fix-strcmp.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.17-rc4-mm1/scripts/mod/modpost.c.orig	2006-05-15 20:49:14.000=
000000 +0200
+++ linux-2.6.17-rc4-mm1/scripts/mod/modpost.c	2006-05-15 20:49:30.00000000=
0 +0200
@@ -1194,9 +1194,9 @@ static void read_dump(const char *fname,
 					*d !=3D '\0')
 			goto fail;
=20
-		if ((strcmp(export, "EXPORT_SYMBOL_GPL")))
+		if (strcmp(export, "EXPORT_SYMBOL_GPL") =3D=3D 0)
 			export_type =3D 1;
-		else if(strcmp(export, "EXPORT_SYMBOL") =3D=3D 0)
+		else if (strcmp(export, "EXPORT_SYMBOL") =3D=3D 0)
 			export_type =3D 0;
 		else
 			goto fail;

--/9DWx/yDrRhgMJTb--

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEaNE/o4FAdB2PneQRAoVMAJ9JOIL++o9ONcVfFMiZsOUckRDEMQCfR0wo
Epj87tT8z9Uj2JzPA/Kn5vQ=
=KggD
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
