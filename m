Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263858AbUECXfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbUECXfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUECXfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:35:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11661 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263858AbUECXfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:35:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove bogus drivers/ide/pci/cmd640.h
Date: Tue, 4 May 2004 01:33:37 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405040133.37413.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CMD640 doesn't use generic IDE PCI code (it even doesn't include this header).

 linux-2.6.6-rc3-bk2/drivers/ide/pci/cmd640.h |   32 ---------------------------
 1 files changed, 32 deletions(-)

diff -puN -L drivers/ide/pci/cmd640.h drivers/ide/pci/cmd640.h~ide_cmd640 /dev/null
--- linux-2.6.6-rc3-bk2/drivers/ide/pci/cmd640.h
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,32 +0,0 @@
-#ifndef CMD640_H
-#define CMD640_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define IDE_IGNORE      ((void *)-1)
-
-static ide_pci_device_t cmd640_chipsets[] __initdata = {
-	{
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_CMD_640,
-		.name		= "CMD640",
-		.init_setup	= NULL,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
-		.init_hwif	= IDE_IGNORE,
-		.init_dma	= NULL,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		.bootable	= ON_BOARD,
-		.extra		= 0
-	},{
-		.vendor		= 0,
-		.device		= 0,
-		.bootable	= EOL,
-	}
-}
-
-#endif /* CMD640_H */

_

