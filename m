Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTFOS31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFOS30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:29:26 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:43341 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262598AbTFOS2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:28:09 -0400
Date: Sun, 15 Jun 2003 20:38:40 +0200
Message-Id: <200306151838.h5FIcefR008316@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] NCR53C9x compile fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x SCSI: Fix compilation after breakage in 2.5.71

--- linux-2.5.x/drivers/scsi/NCR53C9x.c	Sun Jun 15 10:04:26 2003
+++ linux-m68k-2.5.x/drivers/scsi/NCR53C9x.c	Sun Jun 15 11:49:32 2003
@@ -893,7 +893,7 @@
 int esp_proc_info(struct Scsi_Host *shost, char *buffer, char **start, off_t offset, int length,
 		  int inout)
 {
-	struct NCR_ESP *esp = (struct NCR_ESP *) SCpnt->device->host->hostdata;
+	struct NCR_ESP *esp = (struct NCR_ESP *)shost->hostdata;
 
 	if(inout)
 		return -EINVAL; /* not yet */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
