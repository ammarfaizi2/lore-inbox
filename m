Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTFOQPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTFOQPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:15:30 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:22473 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262340AbTFOQPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:15:21 -0400
Date: Sun, 15 Jun 2003 18:29:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch/i386/kernel/traps.c warning
Message-ID: <Pine.GSO.4.21.0306151828100.14609-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill warning about unused variable (untested)

--- linux-2.5.71/arch/i386/kernel/traps.c.orig	Tue May 27 19:02:31 2003
+++ linux-2.5.71/arch/i386/kernel/traps.c	Wed Jun 11 10:22:22 2003
@@ -94,7 +94,6 @@
 
 void show_trace(unsigned long * stack)
 {
-	int i;
 	unsigned long addr;
 
 	if (!stack)
@@ -104,7 +103,6 @@
 #ifdef CONFIG_KALLSYMS
 	printk("\n");
 #endif
-	i = 1;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

