Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272515AbTGZOmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272514AbTGZOfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:46 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:43573 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272515AbTGZOcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:41 -0400
Date: Sat, 26 Jul 2003 16:51:49 +0200
Message-Id: <200307261451.h6QEpnEh002376@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] wd33c93 compile fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wd33c93 SCSI: Fix compilation after breakage in 2.5.71

--- linux-2.6.x/drivers/scsi/wd33c93.c	Sun Jun 15 09:38:41 2003
+++ linux-m68k-2.6.x/drivers/scsi/wd33c93.c	Sun Jun 15 11:33:48 2003
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
