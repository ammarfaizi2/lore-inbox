Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSDPKUX>; Tue, 16 Apr 2002 06:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSDPKUW>; Tue, 16 Apr 2002 06:20:22 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:59659 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S293457AbSDPKUU>;
	Tue, 16 Apr 2002 06:20:20 -0400
Date: Tue, 16 Apr 2002 14:24:42 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] drivers/net/dl2k.c: missing __devinit's
Message-ID: <20020416102442.GA284@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patch adds missing __devinit modifiers for read_eeprom() and=20
parse_eeprom() functions. Patch against 2.5.8. Compiles, but untested.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dl2k-devinit
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/net/dl2k.c linux/dri=
vers/net/dl2k.c
--- linux.vanilla/drivers/net/dl2k.c	Sun Apr 14 23:30:38 2002
+++ linux/drivers/net/dl2k.c	Sun Apr 14 23:57:54 2002
@@ -327,7 +327,7 @@
 	return 0;
 }
=20
-int
+static int __devinit
 parse_eeprom (struct net_device *dev)
 {
 	int i, j;
@@ -1275,7 +1275,7 @@
 #define EEP_READ 0x0200
 #define EEP_BUSY 0x8000
 /* Read the EEPROM word */
-int
+static int __devinit
 read_eeprom (long ioaddr, int eep_addr)
 {
 	int i =3D 1000;

--LZvS9be/3tNcYl/X--

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8u/vqBm4rlNOo3YgRApk7AJwJLV2xQIIAKpGBZxz3EssHkyYheQCfbeu/
QIMYsUmop+D/W+/FaBxMyh0=
=eze9
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
