Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbULLCMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbULLCMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 21:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbULLCMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 21:12:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35333 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262048AbULLCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 21:11:17 -0500
Date: Sun, 12 Dec 2004 03:11:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch i386 traps.c: make a function static
Message-ID: <20041212021108.GP22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/traps.c.old	2004-12-11 23:51:43.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/traps.c	2004-12-11 23:51:50.000000000 +0100
@@ -898,7 +898,7 @@
 	math_error((void __user *)regs->eip);
 }
 
-void simd_math_error(void __user *eip)
+static void simd_math_error(void __user *eip)
 {
 	struct task_struct * task;
 	siginfo_t info;

