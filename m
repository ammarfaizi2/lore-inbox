Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVB0ABk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVB0ABk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVB0ABk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:01:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63911
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261303AbVB0AAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:00:09 -0500
Message-ID: <20050227010006.2.patchmail@tglx>
References: <20050227005956.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
To: linux-m32r@ml.linux-m32r.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/10] M32R:  C99 initializers for hw_interrupt_type structures
Date: Sun, 27 Feb 2005 00:56:18 +0100 (CET)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the initializers of hw_interrupt_type structures to C99 initializers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 setup_m32700ut.c |   56 +++++++++++++++++++++++++++----------------------------
 setup_mappi.c    |   14 ++++++-------
 setup_mappi2.c   |   14 ++++++-------
 setup_oaks32r.c  |   14 ++++++-------
 setup_opsput.c   |   56 +++++++++++++++++++++++++++----------------------------
 setup_usrv.c     |   28 +++++++++++++--------------
 6 files changed, 91 insertions(+), 91 deletions(-)
---
diff -urN 2.6.11-rc5.orig/arch/m32r/kernel/setup_m32700ut.c 2.6.11-rc5/arch/m32r/kernel/setup_m32700ut.c
--- 2.6.11-rc5.orig/arch/m32r/kernel/setup_m32700ut.c	2004-12-24 22:35:27.000000000 +0100
+++ 2.6.11-rc5/arch/m32r/kernel/setup_m32700ut.c	2005-02-26 20:54:19.000000000 +0100
@@ -78,13 +78,13 @@
 
 static struct hw_interrupt_type m32700ut_irq_type =
 {
-	"M32700UT-IRQ",
-	startup_m32700ut_irq,
-	shutdown_m32700ut_irq,
-	enable_m32700ut_irq,
-	disable_m32700ut_irq,
-	mask_and_ack_m32700ut,
-	end_m32700ut_irq
+	.typename = "M32700UT-IRQ",
+	.startup = startup_m32700ut_irq,
+	.shutdown = shutdown_m32700ut_irq,
+	.enable = enable_m32700ut_irq,
+	.disable = disable_m32700ut_irq,
+	.ack = mask_and_ack_m32700ut,
+	.end = end_m32700ut_irq
 };
 
 /*
@@ -155,13 +155,13 @@
 
 static struct hw_interrupt_type m32700ut_pld_irq_type =
 {
-	"M32700UT-PLD-IRQ",
-	startup_m32700ut_pld_irq,
-	shutdown_m32700ut_pld_irq,
-	enable_m32700ut_pld_irq,
-	disable_m32700ut_pld_irq,
-	mask_and_ack_m32700ut_pld,
-	end_m32700ut_pld_irq
+	.typename = "M32700UT-PLD-IRQ",
+	.startup = startup_m32700ut_pld_irq,
+	.shutdown = shutdown_m32700ut_pld_irq,
+	.enable = enable_m32700ut_pld_irq,
+	.disable = disable_m32700ut_pld_irq,
+	.ack = mask_and_ack_m32700ut_pld,
+	.end = end_m32700ut_pld_irq
 };
 
 /*
@@ -224,13 +224,13 @@
 
 static struct hw_interrupt_type m32700ut_lanpld_irq_type =
 {
-	"M32700UT-PLD-LAN-IRQ",
-	startup_m32700ut_lanpld_irq,
-	shutdown_m32700ut_lanpld_irq,
-	enable_m32700ut_lanpld_irq,
-	disable_m32700ut_lanpld_irq,
-	mask_and_ack_m32700ut_lanpld,
-	end_m32700ut_lanpld_irq
+	.typename = "M32700UT-PLD-LAN-IRQ",
+	.startup = startup_m32700ut_lanpld_irq,
+	.shutdown = shutdown_m32700ut_lanpld_irq,
+	.enable = enable_m32700ut_lanpld_irq,
+	.disable = disable_m32700ut_lanpld_irq,
+	.ack = mask_and_ack_m32700ut_lanpld,
+	.end = end_m32700ut_lanpld_irq
 };
 
 /*
@@ -293,13 +293,13 @@
 
 static struct hw_interrupt_type m32700ut_lcdpld_irq_type =
 {
-	"M32700UT-PLD-LCD-IRQ",
-	startup_m32700ut_lcdpld_irq,
-	shutdown_m32700ut_lcdpld_irq,
-	enable_m32700ut_lcdpld_irq,
-	disable_m32700ut_lcdpld_irq,
-	mask_and_ack_m32700ut_lcdpld,
-	end_m32700ut_lcdpld_irq
+	.typename = "M32700UT-PLD-LCD-IRQ",
+	.startup = startup_m32700ut_lcdpld_irq,
+	.shutdown = shutdown_m32700ut_lcdpld_irq,
+	.enable = enable_m32700ut_lcdpld_irq,
+	.disable = disable_m32700ut_lcdpld_irq,
+	.ack = mask_and_ack_m32700ut_lcdpld,
+	.end = end_m32700ut_lcdpld_irq
 };
 
 void __init init_IRQ(void)
diff -urN 2.6.11-rc5.orig/arch/m32r/kernel/setup_mappi2.c 2.6.11-rc5/arch/m32r/kernel/setup_mappi2.c
--- 2.6.11-rc5.orig/arch/m32r/kernel/setup_mappi2.c	2004-12-24 22:35:50.000000000 +0100
+++ 2.6.11-rc5/arch/m32r/kernel/setup_mappi2.c	2005-02-26 20:54:19.000000000 +0100
@@ -79,13 +79,13 @@
 
 static struct hw_interrupt_type mappi2_irq_type =
 {
-	"MAPPI2-IRQ",
-	startup_mappi2_irq,
-	shutdown_mappi2_irq,
-	enable_mappi2_irq,
-	disable_mappi2_irq,
-	mask_and_ack_mappi2,
-	end_mappi2_irq
+	.typename = "MAPPI2-IRQ",
+	.startup = startup_mappi2_irq,
+	.shutdown = shutdown_mappi2_irq,
+	.enable = enable_mappi2_irq,
+	.disable = disable_mappi2_irq,
+	.ack = mask_and_ack_mappi2,
+	.end = end_mappi2_irq
 };
 
 void __init init_IRQ(void)
diff -urN 2.6.11-rc5.orig/arch/m32r/kernel/setup_mappi.c 2.6.11-rc5/arch/m32r/kernel/setup_mappi.c
--- 2.6.11-rc5.orig/arch/m32r/kernel/setup_mappi.c	2004-12-24 22:35:00.000000000 +0100
+++ 2.6.11-rc5/arch/m32r/kernel/setup_mappi.c	2005-02-26 20:54:19.000000000 +0100
@@ -70,13 +70,13 @@
 
 static struct hw_interrupt_type mappi_irq_type =
 {
-	"MAPPI-IRQ",
-	startup_mappi_irq,
-	shutdown_mappi_irq,
-	enable_mappi_irq,
-	disable_mappi_irq,
-	mask_and_ack_mappi,
-	end_mappi_irq
+	.typename = "MAPPI-IRQ",
+	.startup = startup_mappi_irq,
+	.shutdown = shutdown_mappi_irq,
+	.enable = enable_mappi_irq,
+	.disable = disable_mappi_irq,
+	.ack = mask_and_ack_mappi,
+	.end = end_mappi_irq
 };
 
 void __init init_IRQ(void)
diff -urN 2.6.11-rc5.orig/arch/m32r/kernel/setup_oaks32r.c 2.6.11-rc5/arch/m32r/kernel/setup_oaks32r.c
--- 2.6.11-rc5.orig/arch/m32r/kernel/setup_oaks32r.c	2004-12-24 22:35:40.000000000 +0100
+++ 2.6.11-rc5/arch/m32r/kernel/setup_oaks32r.c	2005-02-26 20:54:19.000000000 +0100
@@ -70,13 +70,13 @@
 
 static struct hw_interrupt_type oaks32r_irq_type =
 {
-	"OAKS32R-IRQ",
-	startup_oaks32r_irq,
-	shutdown_oaks32r_irq,
-	enable_oaks32r_irq,
-	disable_oaks32r_irq,
-	mask_and_ack_mappi,
-	end_oaks32r_irq
+	.typename = "OAKS32R-IRQ",
+	.startup = startup_oaks32r_irq,
+	.shutdown = shutdown_oaks32r_irq,
+	.enable = enable_oaks32r_irq,
+	.disable = disable_oaks32r_irq,
+	.ack = mask_and_ack_mappi,
+	.end = end_oaks32r_irq
 };
 
 void __init init_IRQ(void)
diff -urN 2.6.11-rc5.orig/arch/m32r/kernel/setup_opsput.c 2.6.11-rc5/arch/m32r/kernel/setup_opsput.c
--- 2.6.11-rc5.orig/arch/m32r/kernel/setup_opsput.c	2004-12-24 22:33:48.000000000 +0100
+++ 2.6.11-rc5/arch/m32r/kernel/setup_opsput.c	2005-02-26 20:54:19.000000000 +0100
@@ -79,13 +79,13 @@
 
 static struct hw_interrupt_type opsput_irq_type =
 {
-	"OPSPUT-IRQ",
-	startup_opsput_irq,
-	shutdown_opsput_irq,
-	enable_opsput_irq,
-	disable_opsput_irq,
-	mask_and_ack_opsput,
-	end_opsput_irq
+	.typename = "OPSPUT-IRQ",
+	.startup = startup_opsput_irq,
+	.shutdown = shutdown_opsput_irq,
+	.enable = enable_opsput_irq,
+	.disable = disable_opsput_irq,
+	.ack = mask_and_ack_opsput,
+	.end = end_opsput_irq
 };
 
 /*
@@ -156,13 +156,13 @@
 
 static struct hw_interrupt_type opsput_pld_irq_type =
 {
-	"OPSPUT-PLD-IRQ",
-	startup_opsput_pld_irq,
-	shutdown_opsput_pld_irq,
-	enable_opsput_pld_irq,
-	disable_opsput_pld_irq,
-	mask_and_ack_opsput_pld,
-	end_opsput_pld_irq
+	.typename = "OPSPUT-PLD-IRQ",
+	.startup = startup_opsput_pld_irq,
+	.shutdown = shutdown_opsput_pld_irq,
+	.enable = enable_opsput_pld_irq,
+	.disable = disable_opsput_pld_irq,
+	.ack = mask_and_ack_opsput_pld,
+	.end = end_opsput_pld_irq
 };
 
 /*
@@ -225,13 +225,13 @@
 
 static struct hw_interrupt_type opsput_lanpld_irq_type =
 {
-	"OPSPUT-PLD-LAN-IRQ",
-	startup_opsput_lanpld_irq,
-	shutdown_opsput_lanpld_irq,
-	enable_opsput_lanpld_irq,
-	disable_opsput_lanpld_irq,
-	mask_and_ack_opsput_lanpld,
-	end_opsput_lanpld_irq
+	.typename = "OPSPUT-PLD-LAN-IRQ",
+	.startup = startup_opsput_lanpld_irq,
+	.shutdown = shutdown_opsput_lanpld_irq,
+	.enable = enable_opsput_lanpld_irq,
+	.disable = disable_opsput_lanpld_irq,
+	.ack = mask_and_ack_opsput_lanpld,
+	.end = end_opsput_lanpld_irq
 };
 
 /*
@@ -294,13 +294,13 @@
 
 static struct hw_interrupt_type opsput_lcdpld_irq_type =
 {
-	"OPSPUT-PLD-LCD-IRQ",
-	startup_opsput_lcdpld_irq,
-	shutdown_opsput_lcdpld_irq,
-	enable_opsput_lcdpld_irq,
-	disable_opsput_lcdpld_irq,
-	mask_and_ack_opsput_lcdpld,
-	end_opsput_lcdpld_irq
+	.type = "OPSPUT-PLD-LCD-IRQ",
+	.startup = startup_opsput_lcdpld_irq,
+	.shutdown = shutdown_opsput_lcdpld_irq,
+	.enable = enable_opsput_lcdpld_irq,
+	.disable = disable_opsput_lcdpld_irq,
+	.ack = mask_and_ack_opsput_lcdpld,
+	.end = end_opsput_lcdpld_irq
 };
 
 void __init init_IRQ(void)
diff -urN 2.6.11-rc5.orig/arch/m32r/kernel/setup_usrv.c 2.6.11-rc5/arch/m32r/kernel/setup_usrv.c
--- 2.6.11-rc5.orig/arch/m32r/kernel/setup_usrv.c	2004-12-24 22:35:01.000000000 +0100
+++ 2.6.11-rc5/arch/m32r/kernel/setup_usrv.c	2005-02-26 20:54:19.000000000 +0100
@@ -70,13 +70,13 @@
 
 static struct hw_interrupt_type mappi_irq_type =
 {
-	"M32700-IRQ",
-	startup_mappi_irq,
-	shutdown_mappi_irq,
-	enable_mappi_irq,
-	disable_mappi_irq,
-	mask_and_ack_mappi,
-	end_mappi_irq
+	.typename = "M32700-IRQ",
+	.startup = startup_mappi_irq,
+	.shutdown = shutdown_mappi_irq,
+	.enable = enable_mappi_irq,
+	.disable = disable_mappi_irq,
+	.ack = mask_and_ack_mappi,
+	.end = end_mappi_irq
 };
 
 /*
@@ -143,13 +143,13 @@
 
 static struct hw_interrupt_type m32700ut_pld_irq_type =
 {
-	"USRV-PLD-IRQ",
-	startup_m32700ut_pld_irq,
-	shutdown_m32700ut_pld_irq,
-	enable_m32700ut_pld_irq,
-	disable_m32700ut_pld_irq,
-	mask_and_ack_m32700ut_pld,
-	end_m32700ut_pld_irq
+	.typename = "USRV-PLD-IRQ",
+	.startup = startup_m32700ut_pld_irq,
+	.shutdown = shutdown_m32700ut_pld_irq,
+	.enable = enable_m32700ut_pld_irq,
+	.disable = disable_m32700ut_pld_irq,
+	.ack = mask_and_ack_m32700ut_pld,
+	.end = end_m32700ut_pld_irq
 };
 
 void __init init_IRQ(void)
