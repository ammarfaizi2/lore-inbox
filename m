Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSE0BPY>; Sun, 26 May 2002 21:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316480AbSE0BPX>; Sun, 26 May 2002 21:15:23 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:18451 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316477AbSE0BPX>;
	Sun, 26 May 2002 21:15:23 -0400
Date: Sun, 26 May 2002 21:06:08 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.18 : drivers/pci/pool.c minor printk fix
Message-ID: <Pine.LNX.4.33.0205262058570.18267-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  The following patch addresses a compile warning. printk saw the "," as 
an argument, which it shouldn't.
Regards,
Frank

--- drivers/pci/pool.c.old	Thu May  9 19:01:28 2002
+++ drivers/pci/pool.c	Sun May 26 20:55:42 2002
@@ -309,7 +309,7 @@
 		return;
 	}
 	if (page->bitmap [map] & (1UL << block)) {
-		printk (KERN_ERR "pci_pool_free %s/%s, dma %x already free\n",
+		printk (KERN_ERR "pci_pool_free %s/%s dma %x already free\n",
 			pool->dev ? pool->dev->slot_name : NULL,
 			pool->name, dma);
 		return;

