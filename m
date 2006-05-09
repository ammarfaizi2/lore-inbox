Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWEIU5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWEIU5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWEIU5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750724AbWEIU5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:14 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205956.174004000@drseuss.boston.redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:36 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 1/8] nmi watchdog header cleanup
Content-Disposition: inline; filename=nmi-x86-header-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Misc header cleanup for nmi watchdog.

Signed-off-by: Don Zickus <dzickus@redhat.com>

Index: linux-don/arch/i386/kernel/apic.c
===================================================================
--- linux-don.orig/arch/i386/kernel/apic.c
+++ linux-don/arch/i386/kernel/apic.c
@@ -36,6 +36,7 @@
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
 #include <asm/i8253.h>
+#include <asm/nmi.h>
 
 #include <mach_apic.h>
 #include <mach_apicdef.h>
Index: linux-don/arch/i386/kernel/io_apic.c
===================================================================
--- linux-don.orig/arch/i386/kernel/io_apic.c
+++ linux-don/arch/i386/kernel/io_apic.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/timer.h>
 #include <asm/i8259.h>
+#include <asm/nmi.h>
 
 #include <mach_apic.h>
 
Index: linux-don/arch/i386/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/i386/kernel/nmi.c
+++ linux-don/arch/i386/kernel/nmi.c
@@ -14,20 +14,15 @@
  */
 
 #include <linux/config.h>
-#include <linux/mm.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
-#include <linux/mc146818rtc.h>
-#include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
+#include <linux/percpu.h>
 
 #include <asm/smp.h>
-#include <asm/div64.h>
 #include <asm/nmi.h>
 
 #include "mach_traps.h"
Index: linux-don/arch/i386/kernel/smpboot.c
===================================================================
--- linux-don.orig/arch/i386/kernel/smpboot.c
+++ linux-don/arch/i386/kernel/smpboot.c
@@ -52,6 +52,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/nmi.h>
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
Index: linux-don/arch/i386/oprofile/op_model_athlon.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_model_athlon.c
+++ linux-don/arch/i386/oprofile/op_model_athlon.c
@@ -13,6 +13,7 @@
 #include <linux/oprofile.h>
 #include <asm/ptrace.h>
 #include <asm/msr.h>
+#include <asm/nmi.h>
  
 #include "op_x86_model.h"
 #include "op_counter.h"
Index: linux-don/arch/i386/oprofile/op_model_p4.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_model_p4.c
+++ linux-don/arch/i386/oprofile/op_model_p4.c
@@ -14,6 +14,7 @@
 #include <asm/ptrace.h>
 #include <asm/fixmap.h>
 #include <asm/apic.h>
+#include <asm/nmi.h>
 
 #include "op_x86_model.h"
 #include "op_counter.h"
Index: linux-don/arch/i386/oprofile/op_model_ppro.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/op_model_ppro.c
+++ linux-don/arch/i386/oprofile/op_model_ppro.c
@@ -14,6 +14,7 @@
 #include <asm/ptrace.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
+#include <asm/nmi.h>
  
 #include "op_x86_model.h"
 #include "op_counter.h"
Index: linux-don/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/io_apic.c
+++ linux-don/arch/x86_64/kernel/io_apic.c
@@ -41,6 +41,7 @@
 #include <asm/mach_apic.h>
 #include <asm/acpi.h>
 #include <asm/dma.h>
+#include <asm/nmi.h>
 
 #define __apicdebuginit  __init
 
Index: linux-don/include/asm-i386/apic.h
===================================================================
--- linux-don.orig/include/asm-i386/apic.h
+++ linux-don/include/asm-i386/apic.h
@@ -112,24 +112,12 @@ extern void init_apic_mappings (void);
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
-extern void setup_apic_nmi_watchdog (void);
-extern int reserve_lapic_nmi(void);
-extern void release_lapic_nmi(void);
-extern void disable_timer_nmi_watchdog(void);
-extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
-extern unsigned int nmi_watchdog;
-#define NMI_NONE	0
-#define NMI_IO_APIC	1
-#define NMI_LOCAL_APIC	2
-#define NMI_INVALID	3
-
 extern int disable_timer_pin_1;
 
 void smp_send_timer_broadcast_ipi(struct pt_regs *regs);
Index: linux-don/include/asm-i386/nmi.h
===================================================================
--- linux-don.orig/include/asm-i386/nmi.h
+++ linux-don/include/asm-i386/nmi.h
@@ -5,24 +5,38 @@
 #define ASM_NMI_H
 
 #include <linux/pm.h>
- 
+
 struct pt_regs;
- 
+
 typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
- 
-/** 
+
+/**
  * set_nmi_callback
  *
  * Set a handler for an NMI. Only one handler may be
  * set. Return 1 if the NMI was handled.
  */
 void set_nmi_callback(nmi_callback_t callback);
- 
-/** 
+
+/**
  * unset_nmi_callback
  *
  * Remove the handler previously set.
  */
 void unset_nmi_callback(void);
- 
+
+extern void setup_apic_nmi_watchdog (void);
+extern int reserve_lapic_nmi(void);
+extern void release_lapic_nmi(void);
+extern void disable_timer_nmi_watchdog(void);
+extern void enable_timer_nmi_watchdog(void);
+extern void nmi_watchdog_tick (struct pt_regs * regs);
+
+extern unsigned int nmi_watchdog;
+#define NMI_DEFAULT     -1
+#define NMI_NONE	0
+#define NMI_IO_APIC	1
+#define NMI_LOCAL_APIC	2
+#define NMI_INVALID	3
+
 #endif /* ASM_NMI_H */
Index: linux-don/include/asm-x86_64/apic.h
===================================================================
--- linux-don.orig/include/asm-x86_64/apic.h
+++ linux-don/include/asm-x86_64/apic.h
@@ -80,27 +80,11 @@ extern void init_apic_mappings (void);
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
-extern void setup_apic_nmi_watchdog (void);
-extern int reserve_lapic_nmi(void);
-extern void release_lapic_nmi(void);
-extern void disable_timer_nmi_watchdog(void);
-extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 extern void clustered_apic_check(void);
 
-extern void nmi_watchdog_default(void);
-extern int setup_nmi_watchdog(char *);
-
-extern unsigned int nmi_watchdog;
-#define NMI_DEFAULT	-1
-#define NMI_NONE	0
-#define NMI_IO_APIC	1
-#define NMI_LOCAL_APIC	2
-#define NMI_INVALID	3
-
 extern int disable_timer_pin_1;
 
 extern void setup_threshold_lvt(unsigned long lvt_off);
Index: linux-don/include/asm-x86_64/nmi.h
===================================================================
--- linux-don.orig/include/asm-x86_64/nmi.h
+++ linux-don/include/asm-x86_64/nmi.h
@@ -5,26 +5,27 @@
 #define ASM_NMI_H
 
 #include <linux/pm.h>
+#include <asm/io.h>
  
 struct pt_regs;
- 
+
 typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
- 
-/** 
+
+/**
  * set_nmi_callback
  *
  * Set a handler for an NMI. Only one handler may be
  * set. Return 1 if the NMI was handled.
  */
 void set_nmi_callback(nmi_callback_t callback);
- 
-/** 
+
+/**
  * unset_nmi_callback
  *
  * Remove the handler previously set.
  */
 void unset_nmi_callback(void);
- 
+
 #ifdef CONFIG_PM
  
 /** Replace the PM callback routine for NMI. */
@@ -56,4 +57,21 @@ extern int unknown_nmi_panic;
 
 extern int check_nmi_watchdog(void);
  
+extern void setup_apic_nmi_watchdog (void);
+extern int reserve_lapic_nmi(void);
+extern void release_lapic_nmi(void);
+extern void disable_timer_nmi_watchdog(void);
+extern void enable_timer_nmi_watchdog(void);
+extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+
+extern void nmi_watchdog_default(void);
+extern int setup_nmi_watchdog(char *);
+
+extern unsigned int nmi_watchdog;
+#define NMI_DEFAULT	-1
+#define NMI_NONE	0
+#define NMI_IO_APIC	1
+#define NMI_LOCAL_APIC	2
+#define NMI_INVALID	3
+
 #endif /* ASM_NMI_H */
Index: linux-don/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/x86_64/kernel/nmi.c
+++ linux-don/arch/x86_64/kernel/nmi.c
@@ -15,11 +15,7 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
-#include <linux/mc146818rtc.h>
-#include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/nmi.h>
@@ -27,13 +23,9 @@
 #include <linux/kprobes.h>
 
 #include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/mpspec.h>
 #include <asm/nmi.h>
-#include <asm/msr.h>
 #include <asm/proto.h>
 #include <asm/kdebug.h>
-#include <asm/local.h>
 #include <asm/mce.h>
 
 /*

--
