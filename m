Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUBTMtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUBTMrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:25 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:8785 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261181AbUBTMqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:53 -0500
Date: Fri, 20 Feb 2004 13:46:38 +0100
Message-Id: <200402201246.i1KCkcBl004187@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 393] Sun-3 console fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3: Use dummycon if CONFIG_DUMMY_CONSOLE is defined only (from Sam Creasey)

--- linux-2.6.3/arch/m68k/sun3/config.c	2003-09-04 13:47:40.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/sun3/config.c	2004-01-15 13:57:41.000000000 +0100
@@ -160,7 +160,7 @@
 	mach_hwclk           =  sun3_hwclk;
 	mach_halt	     =  sun3_halt;
 	mach_get_hardware_list = sun3_get_hardware_list;
-#if !defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_DUMMY_CONSOLE)
+#if defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp 	     = &dummy_con;
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
