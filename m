Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUBTMta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUBTMrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:45 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:2364 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261186AbUBTMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:56 -0500
Date: Fri, 20 Feb 2004 13:46:41 +0100
Message-Id: <200402201246.i1KCkf5u004217@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 398] Atari Pamsnet warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari Pamsnet Ethernet: Kill warning

--- linux-2.6.3/drivers/net/atari_pamsnet.c	2003-07-29 18:18:57.000000000 +0200
+++ linux-m68k-2.6.3/drivers/net/atari_pamsnet.c	2003-11-24 13:36:07.000000000 +0100
@@ -488,7 +488,7 @@
 	    !acsi_wait_for_IRQ(TIMEOUTDMA) ||
 	    get_status())
 		goto bad;
-	ret = phys_to_virt(&(((DMAHWADDR *)buffer)->hwaddr));
+	ret = phys_to_virt((unsigned long)&(((DMAHWADDR *)buffer)->hwaddr));
 	dma_cache_maintenance((unsigned long)buffer, 512, 0);
 bad:
 	return (ret);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
