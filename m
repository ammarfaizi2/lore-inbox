Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTASGh3>; Sun, 19 Jan 2003 01:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTASGh3>; Sun, 19 Jan 2003 01:37:29 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:55170 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265480AbTASGhZ>; Sun, 19 Jan 2003 01:37:25 -0500
Date: Sun, 19 Jan 2003 15:46:17 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 sub-arch (12/29) ac-update
Message-ID: <20030119064617.GK2965@yuzuki.cinet.co.jp>
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119051043.GA2662@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.59 (12/29).

Updates arch/i386/kernel/i8259.c in 2.5.50-ac1.

diff -Nru linux-2.5.50-ac1/arch/i386/kernel/i8259.c linux98-2.5.54/arch/i386/kernel/i8259.c
--- linux-2.5.50-ac1/arch/i386/kernel/i8259.c	2003-01-04 10:47:57.000000000 +0900
+++ linux98-2.5.54/arch/i386/kernel/i8259.c	2003-01-04 13:23:33.000000000 +0900
@@ -331,7 +331,7 @@
 static void math_error_irq(int cpl, void *dev_id, struct pt_regs *regs)
 {
 	extern void math_error(void *);
-#ifndef CONFIG_PC9800
+#ifndef CONFIG_X86_PC9800
 	outb(0,0xF0);
 #endif
 	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
