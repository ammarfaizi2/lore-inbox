Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWFZNoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWFZNoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWFZNoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:44:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37863 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030194AbWFZNo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:44:28 -0400
Subject: PATCH: Set err_stops_fifo for newer Promise as well
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 15:00:32 +0100
Message-Id: <1151330432.27147.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/pdc202xx_new.c linux-2.6.17/drivers/ide/pci/pdc202xx_new.c
--- linux.vanilla-2.6.17/drivers/ide/pci/pdc202xx_new.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/pdc202xx_new.c	2006-06-26 13:46:54.264264696 +0100
@@ -337,6 +337,8 @@
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
+	
+	hwif->err_stops_fifo = 1;
 
 	hwif->ide_dma_check = &pdcnew_config_drive_xfer_rate;
 	hwif->ide_dma_lostirq = &pdcnew_ide_dma_lostirq;

