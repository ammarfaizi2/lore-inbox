Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTEKKcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTEKKY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:24:27 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:14419 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261247AbTEKKVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:40 -0400
Date: Sun, 11 May 2003 12:31:06 +0200
Message-Id: <200305111031.h4BAV61D019730@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] hosts.c missing config.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI: hosts.c uses CONFIG_*, hence it needs to include <linux/config.h>

--- linux-2.5.x/drivers/scsi/hosts.c	Sun Apr 20 12:28:47 2003
+++ linux-m68k-2.5.x/drivers/scsi/hosts.c	Sun Apr 20 12:51:54 2003
@@ -27,6 +27,7 @@
  *  hosts currently present in the system.
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/blk.h>
 #include <linux/kernel.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
