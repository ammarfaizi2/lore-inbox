Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268012AbTBRSXH>; Tue, 18 Feb 2003 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbTBRSVv>; Tue, 18 Feb 2003 13:21:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53257 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268003AbTBRSUX>; Tue, 18 Feb 2003 13:20:23 -0500
Subject: PATCH: ide-dma, fix bogus inc of waiting_for_dma
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:30:45 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCVx-0006DS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-dma.c linux-2.5.61-ac2/drivers/ide/ide-dma.c
--- linux-2.5.61/drivers/ide/ide-dma.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-dma.c	2003-02-18 18:06:17.000000000 +0000
@@ -822,7 +785,6 @@
 	if (!drive->waiting_for_dma)
 		printk(KERN_WARNING "%s: (%s) called while not waiting\n",
 			drive->name, __FUNCTION__);
-	drive->waiting_for_dma++;
 	return 0;
 }
 
