Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272521AbTGZOoc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272551AbTGZOmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:42:54 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:3418 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S272521AbTGZOhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:37:48 -0400
Date: Sat, 26 Jul 2003 16:52:00 +0200
Message-Id: <200307261452.h6QEq08C002490@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k dma-mapping
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix SCSI breakage introduced in 2.5.74 by not including
<asm-generic/dma-mapping.h>, unless PCI is available.

--- linux-2.6.x/include/asm-m68k/dma-mapping.h	Tue Dec 24 10:08:58 2002
+++ linux-m68k-2.6.x/include/asm-m68k/dma-mapping.h	Tue Jul 22 19:07:38 2003
@@ -1 +1,10 @@
+#ifndef _M68K_DMA_MAPPING_H
+#define _M68K_DMA_MAPPING_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+#endif
+
+#endif  /* _M68K_DMA_MAPPING_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
