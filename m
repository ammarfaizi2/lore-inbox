Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272505AbTGZOlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272507AbTGZOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:35:11 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:35133 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S272510AbTGZOcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:36 -0400
Date: Sat, 26 Jul 2003 16:51:39 +0200
Message-Id: <200307261451.h6QEpdoj002310@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>, asj@lanmedia.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lmc_proto.c includes <asm/smp.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lmc_proto.c includes <asm/smp.h>, causing build failures on UMP-only
architectures

--- linux-2.6.x/drivers/net/wan/lmc/lmc_proto.c	Tue Dec 10 13:41:24 2002
+++ linux-m68k-2.6.x/drivers/net/wan/lmc/lmc_proto.c	Sun Jun  8 10:39:42 2003
@@ -44,7 +44,7 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#include <asm/smp.h>
+#include <linux/smp.h>
 
 #include "lmc_ver.h"
 #include "lmc.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
