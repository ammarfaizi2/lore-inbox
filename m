Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTFIK10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFIK1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:27:25 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:53595 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262066AbTFIK1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:27:23 -0400
Date: Mon, 9 Jun 2003 12:37:51 +0200
Message-Id: <200306091037.h59Abpox012149@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] sch_ingress.c includes <asm/smp.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sch_ingress.c includes <asm/smp.h>, causing build failures on UMP-only
architectures

--- linux-2.4.x/net/sched/sch_ingress.c	Tue Aug 13 08:56:22 2002
+++ linux-m68k-2.4.x/net/sched/sch_ingress.c	Wed Jun  4 10:57:00 2003
@@ -18,7 +18,7 @@
 #include <net/pkt_sched.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
-#include <asm/smp.h>
+#include <linux/smp.h>
 #include <linux/kmod.h>
 #include <linux/stat.h>
 #include <linux/interrupt.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
