Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVAaXoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVAaXoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVAaXoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:44:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4102 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261461AbVAaXmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:33 -0500
Date: Tue, 1 Feb 2005 00:42:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/mach-default/topology.c: make cpu_devices static
Message-ID: <20050131234228.GS21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/mach-default/topology.c |    2 +-
 include/asm-i386/cpu.h            |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

This patch was already sent on:
- 16 Jan 2005

--- linux-2.6.11-rc1-mm1-full/include/asm-i386/cpu.h.old	2005-01-16 05:41:55.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/cpu.h	2005-01-16 05:42:09.000000000 +0100
@@ -12,7 +12,6 @@
 struct i386_cpu {
 	struct cpu cpu;
 };
-extern struct i386_cpu cpu_devices[NR_CPUS];
 extern int arch_register_cpu(int num);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void arch_unregister_cpu(int);
--- linux-2.6.11-rc1-mm1-full/arch/i386/mach-default/topology.c.old	2005-01-16 05:42:18.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/mach-default/topology.c	2005-01-16 05:42:43.000000000 +0100
@@ -30,7 +30,7 @@
 #include <linux/nodemask.h>
 #include <asm/cpu.h>
 
-struct i386_cpu cpu_devices[NR_CPUS];
+static struct i386_cpu cpu_devices[NR_CPUS];
 
 int arch_register_cpu(int num){
 	struct node *parent = NULL;


