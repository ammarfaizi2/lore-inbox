Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUJCU6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUJCU6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUJCU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:58:23 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:36744 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S268153AbUJCU6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:58:19 -0400
Date: Sun, 3 Oct 2004 22:58:15 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] - s390, sclp compile fix
Message-ID: <20041003205815.GA8450@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch makes s390 sclp driver buildable again.

Bastian

--=20
Where there's no emotion, there's no motive for violence.
		-- Spock, "Dagger of the Mind", stardate 2715.1

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: quoted-printable

diff -ur linux-2.6.9-rc3.orig/drivers/s390/char/sclp_tty.c linux-2.6.9-rc3/=
drivers/s390/char/sclp_tty.c
--- linux-2.6.9-rc3.orig/drivers/s390/char/sclp_tty.c	2004-10-03 20:37:30.0=
00000000 +0000
+++ linux-2.6.9-rc3/drivers/s390/char/sclp_tty.c	2004-10-03 18:16:39.000000=
000 +0000
@@ -277,7 +277,7 @@
 	wake_up(&sclp_tty_waitq);
 	/* check if the tty needs a wake up call */
 	if (sclp_tty !=3D NULL) {
-		tty_wakeup(tty);
+		tty_wakeup(sclp_tty);
 	}
 }
=20
diff -ur linux-2.6.9-rc3.orig/drivers/s390/char/sclp_vt220.c linux-2.6.9-rc=
3/drivers/s390/char/sclp_vt220.c
--- linux-2.6.9-rc3.orig/drivers/s390/char/sclp_vt220.c	2004-10-03 20:37:30=
=2E000000000 +0000
+++ linux-2.6.9-rc3/drivers/s390/char/sclp_vt220.c	2004-10-03 18:17:52.0000=
00000 +0000
@@ -139,7 +139,7 @@
 	wake_up(&sclp_vt220_waitq);
 	/* Check if the tty needs a wake up call */
 	if (sclp_vt220_tty !=3D NULL) {
-		tty_wakeup(tty);
+		tty_wakeup(sclp_vt220_tty);
 	}
 }
=20

--gKMricLos+KVdGMg--

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iEYEARECAAYFAkFgZ+cACgkQnw66O/MvCNFG8QCfS0Oft33CD37APCvzq9lfxsqI
fkUAn2SBuHb7UjzESTFb75WLv4iNAQef
=aDoi
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
