Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267532AbUHXOgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267532AbUHXOgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267873AbUHXOgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:36:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12942 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267532AbUHXOgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:36:10 -0400
Message-Id: <200408241435.i7OEZq0g029157@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 - #ifdef cleanups in drivers/net
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-930641481P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 10:35:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-930641481P
Content-Type: text/plain; charset=us-ascii

Here's the last of them for 2.6.9-rc1 - two more #if/#ifdef cleanups.

Signed-off-by: valdis.kletnieks@vt.edu

--- linux-2.6.9-rc1/drivers/net/amd8111e.c.ifdef	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.9-rc1/drivers/net/amd8111e.c	2004-08-24 10:29:53.000000000 -0400
@@ -719,7 +719,7 @@ static int amd8111e_tx(struct net_device
 	return 0;
 }
 
-#if CONFIG_AMD8111E_NAPI 
+#ifdef CONFIG_AMD8111E_NAPI 
 /* This function handles the driver receive operation in polling mode */
 static int amd8111e_rx_poll(struct net_device *dev, int * budget)
 {
--- linux-2.6.9-rc1/drivers/net/via-velocity.h.ifdef	2004-08-24 08:43:44.000000000 -0400
+++ linux-2.6.9-rc1/drivers/net/via-velocity.h	2004-08-24 10:32:54.651164315 -0400
@@ -1740,7 +1740,7 @@ struct velocity_info {
 	struct net_device *dev;
 	struct net_device_stats stats;
 
-#if CONFIG_PM
+#ifdef CONFIG_PM
 	u32 pci_state[16];
 #endif
 



--==_Exmh_-930641481P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBK1JHcC3lWbTT17ARAoCzAJ91ehMO3nTO7IdqihaXyDpMZCSCNgCgplwM
a6cQCGN3CsbtOZfAoyG8wdw=
=BFl3
-----END PGP SIGNATURE-----

--==_Exmh_-930641481P--
