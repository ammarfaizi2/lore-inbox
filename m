Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSDPLQL>; Tue, 16 Apr 2002 07:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSDPLQK>; Tue, 16 Apr 2002 07:16:10 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:25101 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S312354AbSDPLQJ>;
	Tue, 16 Apr 2002 07:16:09 -0400
Date: Tue, 16 Apr 2002 15:20:36 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] drivers/net/sis900.c: misiing __devinit
Message-ID: <20020416112036.GC3418@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: multipart/mixed; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patch adds missing __devinit modifier for read_eeprom() function.=20
Patch against 2.5.8. Compiles, but untested.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sis900-devinit
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/net/sis900.c linux/d=
rivers/net/sis900.c
--- linux.vanilla/drivers/net/sis900.c	Wed Mar 13 21:43:32 2002
+++ linux/drivers/net/sis900.c	Sun Apr 14 23:52:57 2002
@@ -656,7 +656,7 @@
  *	Note that location is in word (16 bits) unit
  */
=20
-static u16 read_eeprom(long ioaddr, int location)
+static u16 __devinit read_eeprom(long ioaddr, int location)
 {
 	int i;
 	u16 retval =3D 0;

--Il7n/DHsA0sMLmDu--

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8vAkEBm4rlNOo3YgRAsMbAJwOzQMzpD0e7HnrjBQkj47xaZDmFQCeJ2rN
IYV22lkwKnD7iF5LKwz62J8=
=h0Wr
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
