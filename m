Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbULGAv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbULGAv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbULGAv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:51:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19212 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261724AbULGAtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:49:41 -0500
Date: Tue, 7 Dec 2004 01:49:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de, discuss@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] x86_64 traps.c: remove an unused function
Message-ID: <20041207004937.GU7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused function.

It's not compilation tested but grep showed it's unused and I'd already 
send a similar patch for i386.


diffstat output:
 arch/x86_64/kernel/traps.c |    9 ---------
 1 files changed, 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/traps.c.old	2004-12-07 01:47:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/traps.c	2004-12-07 01:47:25.000000000 +0100
@@ -408,15 +408,6 @@
 	do_exit(SIGSEGV);
 }
 
-static inline unsigned long get_cr2(void)
-{
-	unsigned long address;
-
-	/* get the address */
-	__asm__("movq %%cr2,%0":"=r" (address));
-	return address;
-}
-
 static void do_trap(int trapnr, int signr, char *str, 
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {

