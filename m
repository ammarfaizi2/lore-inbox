Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTBOTXF>; Sat, 15 Feb 2003 14:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbTBOTV7>; Sat, 15 Feb 2003 14:21:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264956AbTBOTUv>; Sat, 15 Feb 2003 14:20:51 -0500
Subject: PATCH: header update for arcnet updates (again to match 2.4)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:31:04 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k81g-0007KU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/com20020.h linux-2.5.61-ac1/include/linux/com20020.h
--- linux-2.5.61/include/linux/com20020.h	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.61-ac1/include/linux/com20020.h	2003-02-14 23:32:27.000000000 +0000
@@ -32,7 +32,7 @@
 void com20020_remove(struct net_device *dev);
 
 /* The number of low I/O ports used by the card. */
-#define ARCNET_TOTAL_SIZE 9
+#define ARCNET_TOTAL_SIZE 8
 
 /* various register addresses */
 #define _INTMASK  (ioaddr+0)	/* writable */
@@ -59,6 +59,8 @@
 
 /* in SETUP register */
 #define PROMISCset	0x10	/* enable RCV_ALL */
+#define P1MODE		0x80    /* enable P1-MODE for Backplane */
+#define SLOWARB		0x01    /* enable Slow Arbitration for >=5Mbps */
 
 /* COM2002x */
 #define SUB_TENTATIVE	0	/* tentative node ID */
