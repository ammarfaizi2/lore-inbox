Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312255AbSDPKtF>; Tue, 16 Apr 2002 06:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSDPKtE>; Tue, 16 Apr 2002 06:49:04 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:28428 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S312255AbSDPKtD>;
	Tue, 16 Apr 2002 06:49:03 -0400
Date: Tue, 16 Apr 2002 14:53:29 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/epic100.c: missing __devinit
Message-ID: <20020416105329.GA3418@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patch adds missing __devinit modifier for read_eeprom() function.
Patch against 2.5.8. Compiles, but untested.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-epic-devinit
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/net/epic100.c linux/=
drivers/net/epic100.c
--- linux.vanilla/drivers/net/epic100.c	Sun Apr 14 23:30:39 2002
+++ linux/drivers/net/epic100.c	Sun Apr 14 23:20:08 2002
@@ -582,7 +582,7 @@
 #define EE_READ256_CMD	(6 << 8)
 #define EE_ERASE_CMD	(7 << 6)
=20
-static int read_eeprom(long ioaddr, int location)
+static int __devinit read_eeprom(long ioaddr, int location)
 {
 	int i;
 	int retval =3D 0;

--pf9I7BMVVzbSWLtt--

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8vAKpBm4rlNOo3YgRAiriAJ49wrruRA9c0izbkk1HwX+DpTQNhQCgjbMB
M6xnOvw7wgftQwx8y8AMIN4=
=A3yg
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
