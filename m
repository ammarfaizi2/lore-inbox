Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbULAVh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbULAVh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbULAVh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:37:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261247AbULAVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:37:20 -0500
Date: Wed, 1 Dec 2004 22:37:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 cpuid.c: make two functions static
Message-ID: <20041201213715.GR2650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global functions static.


diffstat output:
 arch/i386/kernel/cpuid.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/cpuid.c.old	2004-12-01 07:52:28.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/cpuid.c	2004-12-01 07:52:41.000000000 +0100
@@ -189,7 +189,7 @@
 	.notifier_call = cpuid_class_cpu_callback,
 };
 
-int __init cpuid_init(void)
+static int __init cpuid_init(void)
 {
 	int i, err = 0;
 	i = 0;
@@ -227,7 +227,7 @@
 	return err;
 }
 
-void __exit cpuid_exit(void)
+static void __exit cpuid_exit(void)
 {
 	int cpu = 0;
 

