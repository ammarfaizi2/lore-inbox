Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbRETEHH>; Sun, 20 May 2001 00:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261408AbRETEG6>; Sun, 20 May 2001 00:06:58 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:59662 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261407AbRETEGj>; Sun, 20 May 2001 00:06:39 -0400
Date: Sun, 20 May 2001 12:06:44 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] ide-pci.c for 2.4.5-pre4
Message-ID: <Pine.LNX.4.33.0105201205200.7794-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's an error in ide-pci.c that prevented it from compiling 2.4.5-pre4.

Try this.


Thanks,
Jeff
[ jchua@fedex.com ]



--- drivers/ide/ide-pci.c	Sun May 20 11:56:48 2001
+++ drivers/ide/ide-pci.c.new	Sun May 20 11:56:45 2001
@@ -708,7 +708,7 @@
 				/*
  	 			 * Set up BM-DMA capability (PnP BIOS should have done this)
  	 			 */
-		    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)
+		    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530))
 					hwif->autodma = 0;	/* default DMA off if we had to configure it here */
 				(void) pci_write_config_word(dev, PCI_COMMAND, pcicmd | PCI_COMMAND_MASTER);
 				if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {

