Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUHXSdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUHXSdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUHXSdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:33:38 -0400
Received: from ftpbox.mot.com ([129.188.136.101]:43920 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S268175AbUHXSdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:33:36 -0400
Date: Tue, 24 Aug 2004 13:33:31 -0500 (CDT)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org, <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: [PATCH][netdrv gianfar] fix printk output
Message-ID: <Pine.LNX.4.44.0408241329260.22219-100000@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Fix usage of printk on the output of mac address.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2004-08-24 13:28:18 -05:00
+++ b/drivers/net/gianfar.c	2004-08-24 13:28:18 -05:00
@@ -307,8 +307,8 @@
 	/* Print out the device info */
 	printk(KERN_INFO DEVICE_NAME, dev->name);
 	for (idx = 0; idx < 6; idx++)
-		printk(KERN_INFO "%2.2x%c", dev->dev_addr[idx], idx == 5 ? ' ' : ':');
-	printk(KERN_INFO "\n");
+		printk("%2.2x%c", dev->dev_addr[idx], idx == 5 ? ' ' : ':');
+	printk("\n");
 
 	/* Even more device info helps when determining which kernel */
 	/* provided which set of benchmarks.  Since this is global for all */

