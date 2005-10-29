Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVJ2OKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVJ2OKv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVJ2OKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:10:50 -0400
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:445 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S1751152AbVJ2OKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:10:50 -0400
Date: Sat, 29 Oct 2005 16:10:46 +0200
From: Michal Srajer <michal@mat.uni.torun.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/etherdevice.h, kernel 2.6.14
Message-ID: <20051029141046.GA17715@ultra60.mat.uni.torun.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Description: Very small optimization patch for include/linux/etherdevice.h in 2.6.14 kernel.

Patch:
---------------cut-here---------------
--- linux-2.6.14/include/linux/etherdevice.h    2005-10-28 00:02:08.000000000 +0000
+++ linux/include/linux/etherdevice.h   2005-10-29 14:57:20.000000000 +0000
@@ -53,7 +53,7 @@
  */
 static inline int is_zero_ether_addr(const u8 *addr)
 {
-       return !(addr[0] | addr[1] | addr[2] | addr[3] | addr[4] | addr[5]);
+       return !(addr[0] || addr[1] || addr[2] || addr[3] || addr[4] || addr[5]);
 }

 /**
---------------cut-here---------------

Michal Srajer
michal@post.pl, michal@mat.uni.torun.pl


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (SunOS)

iD8DBQFDY4LkglPy9O/yglURAoNRAJ4vh0rTVdhW8fRNwivGlYg2Sop/TACg4hmh
VH1Br7i9HJaXPSM2c5yp/g4=
=K0p1
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
