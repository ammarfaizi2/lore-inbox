Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTFOScb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFOS3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:29:38 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:64332 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262584AbTFOS2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:28:02 -0400
Date: Sun, 15 Jun 2003 20:38:41 +0200
Message-Id: <200306151838.h5FIcfhi008322@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] wd33c93 compile fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wd33c93 SCSI: Fix compilation after breakage in 2.5.71

--- linux-2.5.x/drivers/scsi/wd33c93.c	Sun Jun 15 09:38:41 2003
+++ linux-m68k-2.5.x/drivers/scsi/wd33c93.c	Sun Jun 15 11:33:48 2003
@@ -1920,7 +1920,7 @@
 
 	char *bp;
 	char tbuf[128];
-	struct Scsi_Host *instance;
+	struct WD33C93_hostdata *hd;
 	Scsi_Cmnd *cmd;
 	int x, i;
 	static int stop = 0;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
