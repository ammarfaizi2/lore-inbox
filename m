Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTAEOrG>; Sun, 5 Jan 2003 09:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTAEOrG>; Sun, 5 Jan 2003 09:47:06 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:19433 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264822AbTAEOrF>;
	Sun, 5 Jan 2003 09:47:05 -0500
Date: Sun, 5 Jan 2003 15:55:34 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: [PATCH] duplicate extern char _stext
Message-ID: <Pine.GSO.4.21.0301051553420.10519-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill duplicate extern char _stext (already declared globally 14 lines before)

--- linux-2.5.54/include/asm-i386/hw_irq.h.orig	Thu Jan  2 12:55:06 2003
+++ linux-2.5.54/include/asm-i386/hw_irq.h	Thu Jan  2 15:16:02 2003
@@ -76,7 +76,6 @@
 {
 	unsigned long eip;
 	extern unsigned long prof_cpu_mask;
-	extern char _stext;
 #ifdef CONFIG_PROFILING
 	extern void x86_profile_hook(struct pt_regs *);
  

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

