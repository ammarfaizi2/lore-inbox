Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbULFAn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbULFAn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULFAnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:43:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25611 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261447AbULFAln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:41:43 -0500
Date: Mon, 6 Dec 2004 01:41:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, discuss@x86-64.org, matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org
Subject: [2.6 patch] i386/x86_64/parisc process.c: make hlt_counter static
Message-ID: <20041206004139.GL2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global variable static.


diffstat output:
 arch/i386/kernel/process.c   |    2 +-
 arch/parisc/kernel/process.c |    2 +-
 arch/x86_64/kernel/process.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c.old	2004-12-06 01:25:27.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c	2004-12-06 01:25:38.000000000 +0100
@@ -60,7 +60,7 @@
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
-int hlt_counter;
+static int hlt_counter;
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
--- linux-2.6.10-rc2-mm4-full/arch/parisc/kernel/process.c.old	2004-12-06 01:25:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/parisc/kernel/process.c	2004-12-06 01:26:01.000000000 +0100
@@ -54,7 +54,7 @@
 #include <asm/uaccess.h>
 #include <asm/unwind.h>
 
-int hlt_counter;
+static int hlt_counter;
 
 /*
  * Power off function, if any
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c.old	2004-12-06 01:26:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c	2004-12-06 01:26:28.000000000 +0100
@@ -53,7 +53,7 @@
 
 unsigned long kernel_thread_flags = CLONE_VM | CLONE_UNTRACED;
 
-atomic_t hlt_counter = ATOMIC_INIT(0);
+static atomic_t hlt_counter = ATOMIC_INIT(0);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);

