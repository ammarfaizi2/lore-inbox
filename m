Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUEJTuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUEJTuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUEJTuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:50:18 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:30758 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261421AbUEJTtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:49:14 -0400
Date: Mon, 10 May 2004 21:45:45 +0200
Message-Id: <200405101945.i4AJjjAp029376@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 446] Sun3x dummycon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun3x: Like most other platforms, Sun3x needs conswitchp set if
CONFIG_DUMMY_CONSOLE is defined (from Sam Creasey)

--- linux-2.6.6/arch/m68k/sun3x/config.c	2004-04-30 11:39:52.000000000 +0200
+++ linux-m68k-2.6.6/arch/m68k/sun3x/config.c	2004-04-30 11:42:04.000000000 +0200
@@ -70,6 +70,10 @@
 	mach_get_model       = sun3_get_model;
 	mach_get_hardware_list = sun3x_get_hardware_list;
 
+#if defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp	     = &dummy_con;
+#endif
+
 	sun3_intreg = (unsigned char *)SUN3X_INTREG;
 
 	/* only the serial console is known to work anyway... */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
