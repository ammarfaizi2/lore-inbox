Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbRETICg>; Sun, 20 May 2001 04:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbRETIC0>; Sun, 20 May 2001 04:02:26 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:23049 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261480AbRETICJ>; Sun, 20 May 2001 04:02:09 -0400
Date: Sun, 20 May 2001 19:58:01 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.rutgers.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.5-pre4: ide-pci.c missing parenthesis
Message-ID: <20010520195800.A5174@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing parenthesis from 2.4.5-pre4:



  --cw


--- linux-2.4.5-pre4/drivers/ide/ide-pci.c~	Sun May 20 19:44:41 2001
+++ linux-2.4.5-pre4/drivers/ide/ide-pci.c	Sun May 20 19:53:10 2001
@@ -708,7 +708,7 @@
 				/*
  	 			 * Set up BM-DMA capability (PnP BIOS should have done this)
  	 			 */
-		    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530)
+		    		if (!IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530))
 					hwif->autodma = 0;	/* default DMA off if we had to configure it here */
 				(void) pci_write_config_word(dev, PCI_COMMAND, pcicmd | PCI_COMMAND_MASTER);
 				if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {



