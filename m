Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVAOXY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVAOXY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVAOXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:24:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53254 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262360AbVAOXYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:24:54 -0500
Date: Sun, 16 Jan 2005 00:24:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64 process.c: make hlt_counter static
Message-ID: <20050115232451.GC4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global variable static.


diffstat output:
 arch/i386/kernel/process.c   |    2 +-
 arch/x86_64/kernel/process.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c.old	2004-12-06 01:25:27.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c	2004-12-06 01:25:38.000000000 +0100
@@ -60,7 +60,7 @@
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
-int hlt_counter;
+static int hlt_counter;
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c.old	2004-12-06 01:26:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c	2004-12-06 01:26:28.000000000 +0100
@@ -53,7 +53,7 @@
 
 unsigned long kernel_thread_flags = CLONE_VM | CLONE_UNTRACED;
 
-atomic_t hlt_counter = ATOMIC_INIT(0);
+static atomic_t hlt_counter = ATOMIC_INIT(0);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);

