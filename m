Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVLGLZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVLGLZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVLGLY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:24:59 -0500
Received: from mail.renesas.com ([202.234.163.13]:36814 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1750850AbVLGLY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:24:59 -0500
Date: Wed, 07 Dec 2005 20:24:56 +0900 (JST)
Message-Id: <20051207.202456.303477463.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5-mm1] m32r: Remove unnecessary icu_data_t
 definitions
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary struct icu_data_t definitions of 
arch/m32r/kernel/setup_*.c.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup_m32104ut.c |    6 ------
 arch/m32r/kernel/setup_m32700ut.c |    8 --------
 arch/m32r/kernel/setup_mappi.c    |    6 ------
 arch/m32r/kernel/setup_mappi2.c   |    6 ------
 arch/m32r/kernel/setup_mappi3.c   |    6 ------
 arch/m32r/kernel/setup_oaks32r.c  |    6 ------
 arch/m32r/kernel/setup_opsput.c   |    8 --------
 arch/m32r/kernel/setup_usrv.c     |    6 ------
 include/asm-m32r/m32102.h         |    7 ++-----
 9 files changed, 2 insertions(+), 57 deletions(-)

Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_m32104ut.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_m32104ut.c	2005-12-06 22:35:41.000000000 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_m32104ut.c	2005-12-07 20:16:27.713971160 +0900
@@ -20,12 +20,6 @@
 
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-#endif /* CONFIG_SMP */
-
 icu_data_t icu_data[NR_IRQS];
 
 static void disable_m32104ut_irq(unsigned int irq)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_m32700ut.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_m32700ut.c	2005-12-07 15:23:03.219261152 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_m32700ut.c	2005-12-07 15:23:08.127514984 +0900
@@ -26,15 +26,7 @@
  */
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-static icu_data_t icu_data[M32700UT_NUM_CPU_IRQ];
-#else
 icu_data_t icu_data[M32700UT_NUM_CPU_IRQ];
-#endif /* CONFIG_SMP */
-
 
 static void disable_m32700ut_irq(unsigned int irq)
 {
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_mappi.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_mappi.c	2005-12-07 15:23:03.232259176 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_mappi.c	2005-12-07 15:23:08.146512096 +0900
@@ -19,12 +19,6 @@
 
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-#endif /* CONFIG_SMP */
-
 icu_data_t icu_data[NR_IRQS];
 
 static void disable_mappi_irq(unsigned int irq)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_mappi2.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_mappi2.c	2005-12-07 15:23:03.245257200 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_mappi2.c	2005-12-07 15:23:08.152511184 +0900
@@ -19,12 +19,6 @@
 
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-#endif /* CONFIG_SMP */
-
 icu_data_t icu_data[NR_IRQS];
 
 static void disable_mappi2_irq(unsigned int irq)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_mappi3.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_mappi3.c	2005-12-07 15:23:03.257255376 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_mappi3.c	2005-12-07 15:23:08.160509968 +0900
@@ -19,12 +19,6 @@
 
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-#endif /* CONFIG_SMP */
-
 icu_data_t icu_data[NR_IRQS];
 
 static void disable_mappi3_irq(unsigned int irq)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_oaks32r.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_oaks32r.c	2005-12-07 15:23:03.265254160 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_oaks32r.c	2005-12-07 15:23:08.166509056 +0900
@@ -18,12 +18,6 @@
 
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-#endif /* CONFIG_SMP */
-
 icu_data_t icu_data[NR_IRQS];
 
 static void disable_oaks32r_irq(unsigned int irq)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_opsput.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_opsput.c	2005-12-07 15:23:03.287250816 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_opsput.c	2005-12-07 15:23:08.174507840 +0900
@@ -27,15 +27,7 @@
  */
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#ifndef CONFIG_SMP
-typedef struct {
-	unsigned long icucr;  /* ICU Control Register */
-} icu_data_t;
-static icu_data_t icu_data[OPSPUT_NUM_CPU_IRQ];
-#else
 icu_data_t icu_data[OPSPUT_NUM_CPU_IRQ];
-#endif /* CONFIG_SMP */
-
 
 static void disable_opsput_irq(unsigned int irq)
 {
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_usrv.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/setup_usrv.c	2005-12-07 15:23:03.301248688 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/setup_usrv.c	2005-12-07 15:23:08.181506776 +0900
@@ -18,12 +18,6 @@
 
 #define irq2port(x) (M32R_ICU_CR1_PORTL + ((x - 1) * sizeof(unsigned long)))
 
-#if !defined(CONFIG_SMP)
-typedef struct {
-	unsigned long icucr;	/* ICU Control Register */
-} icu_data_t;
-#endif /* CONFIG_SMP */
-
 icu_data_t icu_data[M32700UT_NUM_CPU_IRQ];
 
 static void disable_mappi_irq(unsigned int irq)
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/m32102.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/m32102.h	2005-12-07 15:23:03.315246560 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/m32102.h	2005-12-07 15:23:08.139513160 +0900
@@ -302,15 +302,12 @@
 #define M32R_FPGA_VERSION0_PORTL    (0x30+M32R_FPGA_TOP)
 #define M32R_FPGA_VERSION1_PORTL    (0x34+M32R_FPGA_TOP)
 
+#endif /* CONFIG_SMP */
+
 #ifndef __ASSEMBLY__
-/* For NETDEV WATCHDOG */
 typedef struct {
 	unsigned long icucr;	/* ICU Control Register */
 } icu_data_t;
-
-extern icu_data_t icu_data[];
 #endif
 
-#endif /* CONFIG_SMP */
-
 #endif /* _M32102_H_ */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
