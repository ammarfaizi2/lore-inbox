Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266303AbSKGCt7>; Wed, 6 Nov 2002 21:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266304AbSKGCt7>; Wed, 6 Nov 2002 21:49:59 -0500
Received: from dp.samba.org ([66.70.73.150]:10428 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266303AbSKGCt6>;
	Wed, 6 Nov 2002 21:49:58 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.54799.955377.260781@argo.ozlabs.ibm.com>
Date: Thu, 7 Nov 2002 13:55:11 +1100
To: Jens Axboe <axboe@suse.de>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] Fix typo in sl82c105.c driver
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a minor typo in sl82c105.c which stops it from
compiling.

Jens and/or Linus, please apply.

Paul.

diff -urN linux-2.5/drivers/ide/pci/sl82c105.c pmac-2.5/drivers/ide/pci/sl82c105.c
--- linux-2.5/drivers/ide/pci/sl82c105.c	2002-10-12 14:40:28.000000000 +1000
+++ pmac-2.5/drivers/ide/pci/sl82c105.c	2002-10-30 12:32:48.000000000 +1100
@@ -284,7 +284,7 @@
 
 static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &slc82c105_chipsets[id->driver_data];
+	ide_pci_device_t *d = &sl82c105_chipsets[id->driver_data];
 	if (dev->device != d->device)
 		BUG();
 	ide_setup_pci_device(dev, d);
