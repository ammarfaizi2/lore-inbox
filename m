Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbTBRSFJ>; Tue, 18 Feb 2003 13:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267971AbTBRSCw>; Tue, 18 Feb 2003 13:02:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28937 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267966AbTBRSAB>; Tue, 18 Feb 2003 13:00:01 -0500
Subject: PATCH: ide-tape no longer needs this ifdef
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:10:20 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCCC-00068o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now handled at runtime

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-tape.c linux-2.5.61-ac2/drivers/ide/ide-tape.c
--- linux-2.5.61/drivers/ide/ide-tape.c	2003-02-10 18:38:17.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-tape.c	2003-02-18 18:06:17.000000000 +0000
@@ -6221,11 +6221,7 @@
 	.version		= IDETAPE_VERSION,
 	.media			= ide_tape,
 	.busy			= 1,
-#ifdef CONFIG_IDEDMA_ONLYDISK
-	.supports_dma		= 0,
-#else
 	.supports_dma		= 1,
-#endif
 	.supports_dsc_overlap 	= 1,
 	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
