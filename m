Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTFIK2e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFIK12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:27:28 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:6971 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S262488AbTFIK1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:27:24 -0400
Date: Mon, 9 Jun 2003 12:37:52 +0200
Message-Id: <200306091037.h59AbqtN012155@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
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
