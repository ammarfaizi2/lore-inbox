Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUGIOGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUGIOGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUGIOGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:06:40 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:11209 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S264677AbUGIOGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:06:36 -0400
Date: Fri, 9 Jul 2004 16:06:30 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-ID: <20040709140630.GA27350@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew

The attached patch marks IPv6 support for QETH broken, it is known to
need an extra patch to compile which was submitted one year ago but
never accepted.

Bastian

--=20
The heart is not a logical organ.
		-- Dr. Janet Wallace, "The Deadly Years", stardate 3479.4

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: quoted-printable

diff -urN kernel-source-2.6.7.orig/drivers/s390/net/Kconfig kernel-source-2=
=2E6.7/drivers/s390/net/Kconfig
--- kernel-source-2.6.7.orig/drivers/s390/net/Kconfig	2004-06-16 05:19:53.0=
00000000 +0000
+++ kernel-source-2.6.7/drivers/s390/net/Kconfig	2004-07-09 13:47:13.000000=
000 +0000
@@ -71,7 +71,7 @@
=20
 config QETH_IPV6
 	bool "IPv6 support for gigabit ethernet"
-	depends on (QETH =3D IPV6) || (QETH && IPV6 =3D 'y')
+	depends on ((QETH =3D IPV6) || (QETH && IPV6 =3D 'y')) && BROKEN
 	help
 	  If CONFIG_QETH is switched on, this option will include IPv6
 	  support in the qeth device driver.

--7JfCtLOvnd9MIVvH--

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkDupmYACgkQnw66O/MvCNEhhwCfXYgl8rLyTWgwBVY/BNq//qkl
0FMAnAwUZHpLdk83k5hDlDt97/OWbKw9
=ksx8
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
