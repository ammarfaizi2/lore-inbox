Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWHJThI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWHJThI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWHJThH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:492 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932656AbWHJThB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:01 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [102/145] x86_64: Remove unneeded externs in acpi/boot.c
Message-Id: <20060810193700.33E4413C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:00 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

And move one into proto.h

Cc: len.brown@intel.com
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/acpi/boot.c |    3 ---
 include/asm-x86_64/proto.h   |    2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -47,9 +47,6 @@ EXPORT_SYMBOL(acpi_disabled);
 
 #ifdef	CONFIG_X86_64
 
-extern void __init clustered_apic_check(void);
-
-extern int gsi_irq_sharing(int gsi);
 #include <asm/proto.h>
 
 static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id) { return 0; }
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -124,6 +124,8 @@ extern int fix_aperture;
 extern int reboot_force;
 extern int notsc_setup(char *);
 
+extern int gsi_irq_sharing(int gsi);
+
 extern void smp_local_timer_interrupt(struct pt_regs * regs);
 
 long do_arch_prctl(struct task_struct *task, int code, unsigned long addr);
