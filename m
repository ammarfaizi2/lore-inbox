Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFOTC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTFOTAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:00:37 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:41294 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262714AbTFOS74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:59:56 -0400
Date: Sun, 15 Jun 2003 21:10:35 +0200
Message-Id: <200306151910.h5FJAZqC008628@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, asj@lanmedia.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lmc_proto.c includes <asm/smp.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lmc_proto.c includes <asm/smp.h>, causing build failures on UMP-only
architectures

--- linux-2.4.x/drivers/net/wan/lmc/lmc_proto.c	Wed Mar  7 10:29:48 2001
+++ linux-m68k-2.4.x/drivers/net/wan/lmc/lmc_proto.c	Sun Jun  8 10:39:03 2003
@@ -31,7 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <asm/segment.h>
-#include <asm/smp.h>
+#include <linux/smp.h>
 
 #include <linux/in.h>
 #include <linux/if_arp.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
