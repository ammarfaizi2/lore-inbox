Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUGTSs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUGTSs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUGTSmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:42:49 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:37931 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266173AbUGTSj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:57 -0400
Date: Tue, 20 Jul 2004 20:39:55 +0200
Message-Id: <200407201839.i6KIdt5h015565@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] JFFS2 compression dependency
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JFFS2: Advanced compression options for JFFS2 should depend on JFFS2

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/fs/Kconfig	2004-07-18 15:55:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/fs/Kconfig	2004-07-18 22:34:50.000000000 +0200
@@ -1151,6 +1151,7 @@
 
 config JFFS2_COMPRESSION_OPTIONS
 	bool "Advanced compression options for JFFS2"
+	depends on JFFS2_FS
 	default n
 	help
 	  Enabling this option allows you to explicitly choose which

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
