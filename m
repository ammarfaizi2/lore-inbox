Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268007AbTBRSUR>; Tue, 18 Feb 2003 13:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbTBRSTB>; Tue, 18 Feb 2003 13:19:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51721 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268000AbTBRSSj>; Tue, 18 Feb 2003 13:18:39 -0500
Subject: PATCH: add a reminder for vdma on non disk
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:28:21 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCTd-0006C7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-cd.c linux-2.5.61-ac2/drivers/ide/ide-cd.c
--- linux-2.5.61/drivers/ide/ide-cd.c	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-cd.c	2003-02-18 18:06:17.000000000 +0000
@@ -846,6 +846,7 @@
 	}
 
 	/* Set up the controller registers. */
+	/* FIXME: for Virtual DMA we must check harder */
 	HWIF(drive)->OUTB(info->dma, IDE_FEATURE_REG);
 	HWIF(drive)->OUTB(0, IDE_IREASON_REG);
 	HWIF(drive)->OUTB(0, IDE_SECTOR_REG);
