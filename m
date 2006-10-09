Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWJIU1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWJIU1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWJIU1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:27:44 -0400
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:42936 "EHLO
	hoboe2bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964815AbWJIU1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:27:43 -0400
Date: Mon, 9 Oct 2006 22:27:42 +0200
Message-Id: <200610092027.k99KRgw3031527@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 567] m68k/MVME167: SERIAL167 is no longer broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- SERIAL167 is no longer broken
- Removed some unused variables from the driver to fix compiler warnings

Signed-Off-By: Kars de Jong <jongk@linux-m68k.org>
Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/Kconfig        |    2 +-
 drivers/char/serial167.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux/arch/m68k/Kconfig	2005/08/29 14:16:21	1.1.1.28
+++ linux/arch/m68k/Kconfig	2005/10/11 18:56:37	1.30
@@ -613,7 +613,7 @@ config MVME147_SCC
 
 config SERIAL167
 	bool "CD2401 support for MVME166/7 serial ports"
-	depends on MVME16x && BROKEN
+	depends on MVME16x
 	help
 	  This is the driver for the serial ports on the Motorola MVME166,
 	  167, and 172 boards.  Everyone using one of these boards should say
--- linux/drivers/char/serial167.c	2004/12/29 23:46:03	1.1.1.17
+++ linux/drivers/char/serial167.c	2005/10/11 18:56:37	1.10
@@ -1450,7 +1450,6 @@ cy_tiocmget(struct tty_struct *tty, stru
   volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
   unsigned long flags;
   unsigned char status;
-  unsigned int result;
 
     channel = info->line;
 
@@ -1474,7 +1473,6 @@ cy_tiocmset(struct tty_struct *tty, stru
   int channel;
   volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
   unsigned long flags;
-  unsigned int arg;
 	  
     channel = info->line;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
