Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbTBRSXI>; Tue, 18 Feb 2003 13:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbTBRSVq>; Tue, 18 Feb 2003 13:21:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53769 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267997AbTBRSVI>; Tue, 18 Feb 2003 13:21:08 -0500
Subject: PATCH: update ide-floppy for new style onlydisk
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:31:31 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCWh-0006Dd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-floppy.c linux-2.5.61-ac2/drivers/ide/ide-floppy.c
--- linux-2.5.61/drivers/ide/ide-floppy.c	2003-02-10 18:38:38.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-floppy.c	2003-02-18 18:06:17.000000000 +0000
@@ -1857,11 +1854,7 @@
 	.version		= IDEFLOPPY_VERSION,
 	.media			= ide_floppy,
 	.busy			= 0,
-#ifdef CONFIG_IDEDMA_ONLYDISK
-	.supports_dma		= 0,
-#else
 	.supports_dma		= 1,
-#endif
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
