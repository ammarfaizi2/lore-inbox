Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268002AbTBRSS5>; Tue, 18 Feb 2003 13:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbTBRSRq>; Tue, 18 Feb 2003 13:17:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267998AbTBRSRj>; Tue, 18 Feb 2003 13:17:39 -0500
Subject: PATCH: copy idesync
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:28:01 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCTJ-0006Bx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to copy the new io op. Actually we need to shoot the entire mess
in this function and make the drivers always set it but not today.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide.c linux-2.5.61-ac2/drivers/ide/ide.c
--- linux-2.5.61/drivers/ide/ide.c	2003-02-10 18:38:15.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide.c	2003-02-18 18:06:17.000000000 +0000
@@ -775,6 +775,7 @@
 	hwif->iops			= old_hwif.iops;
 #else
 	hwif->OUTB		= old_hwif.OUTB;
+	hwif->OUTBSYNC		= old_hwif.OUTBSYNC;
 	hwif->OUTW		= old_hwif.OUTW;
 	hwif->OUTL		= old_hwif.OUTL;
 	hwif->OUTSW		= old_hwif.OUTSW;
