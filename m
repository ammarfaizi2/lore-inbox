Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSKGUDh>; Thu, 7 Nov 2002 15:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSKGUDh>; Thu, 7 Nov 2002 15:03:37 -0500
Received: from 3512-780200-242.dialup.surnet.ru ([212.57.170.242]:9744 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S261568AbSKGUDg>;
	Thu, 7 Nov 2002 15:03:36 -0500
Date: Fri, 8 Nov 2002 01:06:48 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] ide.c - just a typo?
Message-ID: <20021108010648.B674@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this looks like just a typo...


--- drivers/ide/ide.c.orig	Fri Nov  8 01:01:58 2002
+++ drivers/ide/ide.c	Fri Nov  8 01:03:03 2002
@@ -3213,8 +3213,9 @@ int ide_register_subdriver (ide_drive_t 
 	spin_unlock(&drives_lock);
 	if (drive->autotune != 2) {
 		/* DMA timings and setup moved to ide-probe.c */
-		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
+//		if (!driver->supports_dma && HWIF(drive)->ide_dma_off_quietly)
 //			HWIF(drive)->ide_dma_off_quietly(drive);
+		if (!driver->supports_dma && HWIF(drive)->ide_dma_off)
 			HWIF(drive)->ide_dma_off(drive);
 		drive->dsc_overlap = (drive->next != drive && driver->supports_dsc_overlap);
 		drive->nice1 = 1;
