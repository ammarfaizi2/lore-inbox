Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbUKDXkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbUKDXkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUKDXkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:40:00 -0500
Received: from mail.dif.dk ([193.138.115.101]:21683 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262495AbUKDXju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:39:50 -0500
Date: Fri, 5 Nov 2004 00:48:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][Trivial] Tidy up APIC mode output, remove double spaces.
Message-ID: <Pine.LNX.4.61.0411050037320.3402@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

Being listed as "INTEL APIC/IOAPIC, LOWLEVEL X86 SMP SUPPORT" maintainer 
wins you this patch.

Small, trivial, patch that removes a few double spaces when printing the 
APIC mode used. No functional changes, I simply found that output like 
this looked a bit goofy :
Enabling APIC mode:  Flat.  Using 3 I/O APICs
and that removing the double spaces and adding a period at the end would 
make it look nicer, so I made a patch to accomplish that.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-bigsmp/mach_apic.h linux-2.6.10-rc1-bk14/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-bigsmp/mach_apic.h	2004-10-18 23:55:24.000000000 +0200
+++ linux-2.6.10-rc1-bk14/include/asm-i386/mach-bigsmp/mach_apic.h	2004-11-05 00:32:39.000000000 +0100
@@ -78,7 +78,7 @@ static inline void init_apic_ldr(void)
 
 static inline void clustered_apic_check(void)
 {
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+	printk("Enabling APIC mode: %s. Using %d I/O APICs.\n",
 		"Cluster", nr_ioapics);
 }
 
diff -urp linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-default/mach_apic.h linux-2.6.10-rc1-bk14/include/asm-i386/mach-default/mach_apic.h
--- linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-default/mach_apic.h	2004-10-18 23:55:35.000000000 +0200
+++ linux-2.6.10-rc1-bk14/include/asm-i386/mach-default/mach_apic.h	2004-11-05 00:32:59.000000000 +0100
@@ -58,8 +58,8 @@ static inline physid_mask_t ioapic_phys_
 
 static inline void clustered_apic_check(void)
 {
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-					"Flat", nr_ioapics);
+	printk("Enabling APIC mode: %s. Using %d I/O APICs.\n",
+		"Flat", nr_ioapics);
 }
 
 static inline int multi_timer_check(int apic, int irq)
diff -urp linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-es7000/mach_apic.h linux-2.6.10-rc1-bk14/include/asm-i386/mach-es7000/mach_apic.h
--- linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-es7000/mach_apic.h	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.10-rc1-bk14/include/asm-i386/mach-es7000/mach_apic.h	2004-11-05 00:33:58.000000000 +0100
@@ -86,7 +86,7 @@ extern int apic_version [MAX_APICS];
 static inline void clustered_apic_check(void)
 {
 	int apic = bios_cpu_apicid[smp_processor_id()];
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs, target cpus %lx\n",
+	printk("Enabling APIC mode: %s. Using %d I/O APICs, target cpus %lx.\n",
 		(apic_version[apic] == 0x14) ? 
 		"Physical Cluster" : "Logical Cluster", nr_ioapics, cpus_addr(TARGET_CPUS)[0]);
 }
diff -urp linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-numaq/mach_apic.h linux-2.6.10-rc1-bk14/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-numaq/mach_apic.h	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.10-rc1-bk14/include/asm-i386/mach-numaq/mach_apic.h	2004-11-05 00:34:24.000000000 +0100
@@ -37,7 +37,7 @@ static inline void init_apic_ldr(void)
 
 static inline void clustered_apic_check(void)
 {
-	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+	printk("Enabling APIC mode: %s. Using %d I/O APICs.\n",
 		"NUMA-Q", nr_ioapics);
 }
 
diff -urp linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-summit/mach_apic.h linux-2.6.10-rc1-bk14/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.10-rc1-bk14-orig/include/asm-i386/mach-summit/mach_apic.h	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.10-rc1-bk14/include/asm-i386/mach-summit/mach_apic.h	2004-11-05 00:35:43.000000000 +0100
@@ -82,8 +82,8 @@ static inline int apic_id_registered(voi
 
 static inline void clustered_apic_check(void)
 {
-	printk("Enabling APIC mode:  Summit.  Using %d I/O APICs\n",
-						nr_ioapics);
+	printk("Enabling APIC mode: Summit. Using %d I/O APICs.\n",
+		nr_ioapics);
 }
 
 static inline int apicid_to_node(int logical_apicid)


