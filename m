Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSKRRZi>; Mon, 18 Nov 2002 12:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKRRZi>; Mon, 18 Nov 2002 12:25:38 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:35714 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263544AbSKRRZh>;
	Mon, 18 Nov 2002 12:25:37 -0500
Date: Mon, 18 Nov 2002 18:32:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] interrupt.h needs <asm/system.h>
Message-ID: <Pine.GSO.4.21.0211181831090.11448-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<asm/system.h> is needed for smp_mb(). Apparently this definition is pulled in
some other way on ia32.

--- linux-2.5.48/include/linux/interrupt.h	Mon Nov 18 10:04:00 2002
+++ linux-m68k-2.5.48/include/linux/interrupt.h	Mon Nov 18 15:35:14 2002
@@ -8,6 +8,7 @@
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>
 #include <asm/softirq.h>
+#include <asm/system.h>
 
 struct irqaction {
 	void (*handler)(int, void *, struct pt_regs *);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

