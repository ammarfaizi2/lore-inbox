Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272501AbTGZOmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272500AbTGZOeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:34:03 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:605 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272501AbTGZOc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:29 -0400
Date: Sat, 26 Jul 2003 16:51:37 +0200
Message-Id: <200307261451.h6QEpbbN002286@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Apollo compile fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apollo: Kill initialization of obsolete mach_floppy_init and unnecessary
mach_floppy_setup function pointers

--- linux-2.6.x/arch/m68k/apollo/config.c	Sun Mar  2 21:16:22 2003
+++ linux-m68k-2.6.x/arch/m68k/apollo/config.c	Wed Jun  4 11:07:12 2003
@@ -183,10 +183,6 @@
 	mach_hwclk           = dn_dummy_hwclk; /* */
 	mach_set_clock_mmss  = dn_dummy_set_clock_mmss; /* */
 	mach_process_int     = dn_process_int;
-#ifdef CONFIG_BLK_DEV_FD
-	mach_floppy_init     = dn_dummy_floppy_init;
-	mach_floppy_setup    = dn_dummy_floppy_setup;
-#endif
 	mach_reset	     = dn_dummy_reset;  /* */
 #ifdef CONFIG_DUMMY_CONSOLE
         conswitchp           = &dummy_con;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
