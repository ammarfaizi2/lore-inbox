Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSFXCpS>; Sun, 23 Jun 2002 22:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317260AbSFXCpR>; Sun, 23 Jun 2002 22:45:17 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:2826 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317258AbSFXCpQ>;
	Sun, 23 Jun 2002 22:45:16 -0400
Date: Sun, 23 Jun 2002 22:36:32 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/net/rrunner.c 
Message-ID: <Pine.LNX.4.44.0206232234380.922-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch provides the 32-bit DMA check for the rrunner driver. Please 
review.
Regards,
Frank

--- drivers/net/rrunner.c.old	Sun May 26 14:37:33 2002
+++ drivers/net/rrunner.c	Sun Jun 23 22:21:54 2002
@@ -159,6 +159,11 @@
 		if (pdev == opdev)
 			return 0;
 
+		if(pci_set_dma_mask(pdev, 0xffffffff))
+		{
+			printk(KERN_WARNING "rrunner : No suitable DMA available.\n");
+		}
+
 		/*
 		 * So we found our HIPPI ... time to tell the system.
 		 */

