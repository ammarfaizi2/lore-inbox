Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263255AbUJ2BSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbUJ2BSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUJ2Aeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:34:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:775 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263276AbUJ2A2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:28:54 -0400
Date: Fri, 29 Oct 2004 02:28:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 traps.c: remove an unused function
Message-ID: <20041029002821.GC29142@stusta.de>
References: <20041028232326.GJ3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028232326.GJ3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from arch/i386/kernel/traps.c


diffstat output:
 arch/i386/kernel/traps.c |    9 ---------
 1 files changed, 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/arch/i386/kernel/traps.c.old	2004-10-28 22:32:02.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/arch/i386/kernel/traps.c	2004-10-28 22:32:13.000000000 +0200
@@ -400,15 +400,6 @@
 		die(str, regs, err);
 }
 
-static inline unsigned long get_cr2(void)
-{
-	unsigned long address;
-
-	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
-	return address;
-}
-
 static inline void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
