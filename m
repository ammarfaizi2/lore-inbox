Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWEMLhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWEMLhs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWEMLhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:37:48 -0400
Received: from mx1.lost-oasis.net ([212.85.153.8]:55174 "EHLO
	mx1.lost-oasis.net") by vger.kernel.org with ESMTP id S932389AbWEMLhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:37:47 -0400
Date: Sat, 13 May 2006 13:37:31 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, akpm@osdl.org
Subject: Remove duplicate symbol exports on Alpha
Message-ID: <20060513113731.GA31654@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rth@twiddle.net, ink@jurassic.park.msu.ru, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

This patch fixes the following warnings seen on alpha using 2.6.17-rc4:
WARNING: vmlinux: 'enable_irq' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'disable_irq' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'disable_irq_nosync' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'probe_irq_mask' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'sys_open' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'sys_read' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strstr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memscan' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memcmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strnlen' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcmp' exported twice. Previous export was in vmlinux

Signed-off-by: Mathieu Chouquet-Stringer <mchouque@free.fr>

diff --git a/arch/alpha/kernel/alpha_ksyms.c b/arch/alpha/kernel/alpha_ksyms.c
index c645c5e..3f70154 100644
--- a/arch/alpha/kernel/alpha_ksyms.c
+++ b/arch/alpha/kernel/alpha_ksyms.c
@@ -53,10 +53,6 @@ extern void __divqu (void);
 extern void __remqu (void);
 
 EXPORT_SYMBOL(alpha_mv);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
-EXPORT_SYMBOL(probe_irq_mask);
 EXPORT_SYMBOL(screen_info);
 EXPORT_SYMBOL(perf_irq);
 EXPORT_SYMBOL(callback_getenv);
@@ -68,19 +64,13 @@ #endif /* CONFIG_ALPHA_GENERIC */
 
 /* platform dependent support */
 EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memsetw);
@@ -122,11 +112,9 @@ EXPORT_SYMBOL(alpha_write_fp_reg_s);
 
 /* In-kernel system calls.  */
 EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(sys_open);
 EXPORT_SYMBOL(sys_dup);
 EXPORT_SYMBOL(sys_exit);
 EXPORT_SYMBOL(sys_write);
-EXPORT_SYMBOL(sys_read);
 EXPORT_SYMBOL(sys_lseek);
 EXPORT_SYMBOL(execve);
 EXPORT_SYMBOL(sys_setsid);

-- 
Mathieu Chouquet-Stringer                         mchouque@free.fr
