Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272524AbTGZOlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272518AbTGZOhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:37:23 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:44319 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S272521AbTGZOcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:45 -0400
Date: Sat, 26 Jul 2003 16:51:53 +0200
Message-Id: <200307261451.h6QEpr4i002412@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sun-3 SCSI warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3 SCSI: Kill a warning about a nonmatching prototype after recent SCSI
proc_info() changes.

--- linux-2.6.x/drivers/scsi/sun3_NCR5380.c	Sun Jun 15 09:38:41 2003
+++ linux-m68k-2.6.x/drivers/scsi/sun3_NCR5380.c	Mon Jun 23 13:04:29 2003
@@ -754,8 +754,8 @@
 static
 char *lprint_Scsi_Cmnd (Scsi_Cmnd *cmd, char *pos, char *buffer, int length);
 
-static int NCR5380_proc_info (struct Scsi_Host *instance, char *buffer, char **start, off_t offset,
-			      int length, int inout)
+int NCR5380_proc_info (struct Scsi_Host *instance, char *buffer, char **start,
+		       off_t offset, int length, int inout)
 {
     char *pos = buffer;
     struct NCR5380_hostdata *hostdata;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
