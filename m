Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbTBRSIz>; Tue, 18 Feb 2003 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267920AbTBRSIZ>; Tue, 18 Feb 2003 13:08:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267892AbTBRSGc>; Tue, 18 Feb 2003 13:06:32 -0500
Subject: PATCH: add pio_speed
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:16:54 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCIZ-0006Ar-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need this. Its in the core as the core eventually needs to
be doing the tracking here

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/ide.h linux-2.5.61-ac2/include/linux/ide.h
--- linux-2.5.61/include/linux/ide.h	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/include/linux/ide.h	2003-02-18 18:02:56.000000000 +0000
@@ -770,6 +760,7 @@
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	suspend_reset;	/* drive suspend mode flag, soft-reset recovers */
         u8	init_speed;	/* transfer rate set at boot */
+        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
         u8	current_speed;	/* current transfer rate set */
         u8	dn;		/* now wide spread use */
         u8	wcache;		/* status of write cache */
