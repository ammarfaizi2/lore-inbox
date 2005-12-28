Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVL1RdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVL1RdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVL1RdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:33:13 -0500
Received: from quark.didntduck.org ([69.55.226.66]:26548 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932542AbVL1RdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:33:12 -0500
Message-ID: <43B2CC7B.4020307@didntduck.org>
Date: Wed, 28 Dec 2005 12:33:47 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: Remove duplicate exports
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove exports that are already exported from the object's source file.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit e60e288822de60b794544c76c20f9dd2c9c5c22c
tree 7e1a8bc47128bc5b5e98ff0531c8009e4d84d038
parent f26d8d02de18c29fdb8f17c1609ac2bfd7c538fe
author Brian Gerst <bgerst@didntduck.org> Wed, 28 Dec 2005 12:29:34 -0500
committer Brian Gerst <bgerst@didntduck.org> Wed, 28 Dec 2005 12:29:34 -0500

 arch/x86_64/kernel/x8664_ksyms.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/x86_64/kernel/x8664_ksyms.c b/arch/x86_64/kernel/x8664_ksyms.c
index 18b84f8..90a5e48 100644
--- a/arch/x86_64/kernel/x8664_ksyms.c
+++ b/arch/x86_64/kernel/x8664_ksyms.c
@@ -53,10 +53,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(ioremap_nocache);
 EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
-EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(kernel_thread);
 EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
@@ -84,9 +80,6 @@ EXPORT_SYMBOL(__put_user_2);
 EXPORT_SYMBOL(__put_user_4);
 EXPORT_SYMBOL(__put_user_8);
 
-EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(strstr);
-
 EXPORT_SYMBOL(strncpy_from_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(clear_user);
@@ -107,11 +100,9 @@ EXPORT_SYMBOL(clear_page);
 EXPORT_SYMBOL(cpu_pda);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(__write_lock_failed);
 EXPORT_SYMBOL(__read_lock_failed);
 
-EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(cpu_callout_map);
 #endif
@@ -132,30 +123,17 @@ EXPORT_SYMBOL_GPL(unset_nmi_callback);
 #undef memcpy
 #undef memset
 #undef memmove
-#undef memchr
 #undef strlen
-#undef strncmp
-#undef strncpy
-#undef strchr	
 
 extern void * memset(void *,int,__kernel_size_t);
 extern size_t strlen(const char *);
 extern void * memmove(void * dest,const void *src,size_t count);
-extern void *memchr(const void *s, int c, size_t n);
 extern void * memcpy(void *,const void *,__kernel_size_t);
 extern void * __memcpy(void *,const void *,__kernel_size_t);
 
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(memchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
 


