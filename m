Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbUKTCiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUKTCiG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbUKTChs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:37:48 -0500
Received: from baikonur.stro.at ([213.239.196.228]:11439 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263056AbUKTC3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:29:54 -0500
Subject: [patch 7/8]  scsi/zalon: Added KERN macro to printk()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, am@misk.net
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:29:45 +0100
Message-ID: <E1CVL0U-0000cI-9u@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I have added a KERN macro to a printk() function as requested in the Kernel
Janitor's TODO list.

Signed-off-by: Andrew McGregor <am@misk.net>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/drivers/scsi/zalon.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/scsi/zalon.c~printk-drivers-scsi-zalon drivers/scsi/zalon.c
--- linux-2.6.10-rc2-bk4/drivers/scsi/zalon.c~printk-drivers-scsi-zalon	2004-11-20 03:05:13.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/scsi/zalon.c	2004-11-20 03:05:13.000000000 +0100
@@ -109,7 +109,7 @@ zalon_probe(struct parisc_device *dev)
 	*/
 	irq = gsc_alloc_irq(&gsc_irq);
 
-	printk("%s: Zalon vers field is 0x%x, IRQ %d\n", __FUNCTION__,
+       printk(KERN_INFO "%s: Zalon vers field is 0x%x, IRQ %d\n", __FUNCTION__,
 		zalon_vers, irq);
 
 	__raw_writel(gsc_irq.txn_addr | gsc_irq.txn_data, dev->hpa + IO_MODULE_EIM);
_
