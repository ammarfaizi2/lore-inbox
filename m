Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTLGVGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTLGVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:02:47 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:53319 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264557AbTLGVAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:00:35 -0500
Date: Sun, 7 Dec 2003 21:51:28 +0100
Message-Id: <200312072051.hB7KpSZ8000765@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 139] Mac extern
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac: Use common header files instead of explicit extern declaration

--- linux-2.4.23/arch/m68k/mac/mac_ksyms.c	2003-11-12 16:47:03.000000000 +0100
+++ linux-m68k-2.4.23/arch/m68k/mac/mac_ksyms.c	2003-10-23 16:41:23.000000000 +0200
@@ -1,9 +1,7 @@
 #include <linux/module.h>
-#include <asm/ptrace.h>
-#include <asm/traps.h>
-
-/* Says whether we're using A/UX interrupts or not */
-extern int via_alt_mapping;
+#include <linux/types.h>
+#include <asm/mac_via.h>
+#include <asm/macintosh.h>
 
 EXPORT_SYMBOL(via_alt_mapping);
 EXPORT_SYMBOL(macintosh_config);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
