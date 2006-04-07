Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWDGLJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWDGLJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWDGLJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:09:51 -0400
Received: from mail.renesas.com ([202.234.163.13]:24211 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S964777AbWDGLJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:09:50 -0400
Date: Fri, 07 Apr 2006 20:09:45 +0900 (JST)
Message-Id: <20060407.200945.1045963530.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.17-rc1-mm1] m32r: Remove symbols exported twice
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multi-exported symbols from arch/m32r/kernel/m32r_ksyms.c.

WARNING: vmlinux: 'enable_irq' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'disable_irq' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'disable_irq_nosync' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'synchronize_irq' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strstr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memscan' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memcmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memmove' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strnlen' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncat' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcat' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncpy' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcpy' exported twice. Previous export was in vmlinux

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/m32r_ksyms.c |   24 ------------------------
 1 file changed, 24 deletions(-)

Index: linux-2.6.17-rc1-mm1/arch/m32r/kernel/m32r_ksyms.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/kernel/m32r_ksyms.c	2006-04-07 14:59:13.000000000 +0900
+++ linux-2.6.17-rc1-mm1/arch/m32r/kernel/m32r_ksyms.c	2006-04-07 15:43:19.235344160 +0900
@@ -23,9 +23,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(__down);
 EXPORT_SYMBOL(__down_interruptible);
@@ -38,8 +35,6 @@ EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);
 
-EXPORT_SYMBOL(strstr);
-
 EXPORT_SYMBOL(strncpy_from_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(clear_user);
@@ -54,11 +49,8 @@ extern void *dcache_dummy;
 EXPORT_SYMBOL(dcache_dummy);
 #endif
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL(cpu_callout_map);
 
 /* Global SMP stuff */
-EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
 
 /* TLB flushing */
@@ -78,27 +70,11 @@ EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__muldi3);
 
 /* memory and string operations */
-EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memcpy);
-/* EXPORT_SYMBOL(memcpy_fromio); // not implement yet */
-/* EXPORT_SYMBOL(memcpy_toio); // not implement yet */
 EXPORT_SYMBOL(memset);
-/* EXPORT_SYMBOL(memset_io); // not implement yet */
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
-
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strncpy);
 
 EXPORT_SYMBOL(_inb);
 EXPORT_SYMBOL(_inw);

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
 
