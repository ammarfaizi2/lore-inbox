Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVAPCTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVAPCTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVAPCEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:04:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27662 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262393AbVAPCBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:01:53 -0500
Date: Sun, 16 Jan 2005 03:01:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch i386 traps.c: make a function static (fwd)
Message-ID: <20050116020150.GL4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 12 Dec 2004 03:11:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch i386 traps.c: make a function static

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

