Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTH2Owg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTH2Ous
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:50:48 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:10580 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261291AbTH2Ouj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:50:39 -0400
Date: Fri, 29 Aug 2003 16:49:45 +0200
Message-Id: <200308291449.h7TEnj0Y005833@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, asj@lanmedia.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lmc_proto.c includes <asm/smp.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lmc_proto.c includes <asm/smp.h>, causing build failures on UMP-only
architectures

--- linux-2.4.23-pre1/drivers/net/wan/lmc/lmc_proto.c	Wed Mar  7 10:29:48 2001
+++ linux-m68k-2.4.23-pre1/drivers/net/wan/lmc/lmc_proto.c	Sun Jun  8 10:39:03 2003
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
