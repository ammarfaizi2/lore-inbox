Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTFOS1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTFOS1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:27:51 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:34659 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262577AbTFOS0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:26:09 -0400
Date: Sun, 15 Jun 2003 20:36:47 +0200
Message-Id: <200306151836.h5FIalqd008237@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>, asj@lanmedia.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lmc_proto.c includes <asm/smp.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lmc_proto.c includes <asm/smp.h>, causing build failures on UMP-only
architectures

--- linux-2.5.x/drivers/net/wan/lmc/lmc_proto.c	Tue Dec 10 13:41:24 2002
+++ linux-m68k-2.5.x/drivers/net/wan/lmc/lmc_proto.c	Sun Jun  8 10:39:42 2003
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
