Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTBLNoq>; Wed, 12 Feb 2003 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTBLNoq>; Wed, 12 Feb 2003 08:44:46 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:35200 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267208AbTBLNoo>; Wed, 12 Feb 2003 08:44:44 -0500
Date: Wed, 12 Feb 2003 22:53:26 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (17/34) i8259-update
Message-ID: <20030212135326.GR1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (17/34).

Updates arch/i386/kernel/i8259.c in 2.5.50-ac1.

- Osamu Tomita

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
