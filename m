Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263705AbTCUS3N>; Fri, 21 Mar 2003 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263346AbTCUS2d>; Fri, 21 Mar 2003 13:28:33 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57475
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263756AbTCUS1B>; Fri, 21 Mar 2003 13:27:01 -0500
Date: Fri, 21 Mar 2003 19:42:16 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211942.h2LJgGqP025905@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Add ne2k-cbus to Space.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/Space.c linux-2.5.65-ac2/drivers/net/Space.c
--- linux-2.5.65/drivers/net/Space.c	2003-02-15 03:39:31.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/Space.c	2003-03-20 18:30:12.000000000 +0000
@@ -233,7 +229,7 @@
 #ifdef CONFIG_E2100		/* Cabletron E21xx series. */
 	{e2100_probe, 0},
 #endif
-#ifdef CONFIG_NE2000		/* ISA (use ne2k-pci for PCI cards) */
+#if defined(CONFIG_NE2000) || defined(CONFIG_NE2K_CBUS)	/* ISA & PC-9800 CBUS (use ne2k-pci for PCI cards) */
 	{ne_probe, 0},
 #endif
 #ifdef CONFIG_LANCE		/* ISA/VLB (use pcnet32 for PCI cards) */
