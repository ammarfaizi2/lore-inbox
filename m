Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVFGCTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFGCTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFGCTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:19:14 -0400
Received: from mail.renesas.com ([202.234.163.13]:34806 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261332AbVFGCPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:15:48 -0400
Date: Tue, 07 Jun 2005 11:15:42 +0900 (JST)
Message-Id: <20050607.111542.749257374.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       sakugawa@linux-m32r.org
Subject: [PATCH 2.6.12-rc5-mm2] m32r: Update setup_xxxxx.c (was Re: [PATCH
 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050531140151.791007b3.akpm@osdl.org>
References: <20050531.214805.783383719.takata.hirokazu@renesas.com>
	<20050531140151.791007b3.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates arch/m32r/setup_xxxxx.c.
- Change coding styles of hw_interrupt_type struct's initialization portions.

From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc5] m32r: Support M3A-2170(Mappi-III) platform
Date: Tue, 31 May 2005 14:01:51 -0700
> Hirokazu Takata <takata@linux-m32r.org> wrote:
> > @@ -0,0 +1,208 @@
> > +/*
> > + *  linux/arch/m32r/kernel/setup_mappi3.c
> > + *
> > + *  Setup routines for Renesas MAPPI-III(M3A-2170) Board
> > + *
> > + *  Copyright (c) 2001-2005   Hiroyuki Kondo, Hirokazu Takata,
> > + *                            Hitoshi Yamamoto, Mamoru Sakugawa
> > + */
> > +
> > ...
> > +static struct hw_interrupt_type mappi3_irq_type =
> > +{
> > +	"MAPPI3-IRQ",
> > +	startup_mappi3_irq,
> > +	shutdown_mappi3_irq,
> > +	enable_mappi3_irq,
> > +	disable_mappi3_irq,
> > +	mask_and_ack_mappi3,
> > +	end_mappi3_irq
> > +};
> 
> Would be nicer to use
> 
> 	.name = value,
> 

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup_m32700ut.c |   56 +++++++++++++++++++-------------------
 arch/m32r/kernel/setup_mappi.c    |   14 ++++-----
 arch/m32r/kernel/setup_mappi2.c   |   14 ++++-----
 arch/m32r/kernel/setup_mappi3.c   |   14 ++++-----
 arch/m32r/kernel/setup_oaks32r.c  |   14 ++++-----
 arch/m32r/kernel/setup_opsput.c   |   28 +++++++++----------
 arch/m32r/kernel/setup_usrv.c     |   28 +++++++++----------
 7 files changed, 84 insertions(+), 84 deletions(-)


diff -ruNp a/arch/m32r/kernel/setup_m32700ut.c b/arch/m32r/kernel/setup_m32700ut.c
--- a/arch/m32r/kernel/setup_m32700ut.c	2004-12-25 06:35:27.000000000 +0900
+++ b/arch/m32r/kernel/setup_m32700ut.c	2005-06-03 11:18:15.000000000 +0900
@@ -78,13 +78,13 @@ static void shutdown_m32700ut_irq(unsign
 
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
@@ -155,13 +155,13 @@ static void shutdown_m32700ut_pld_irq(un
 
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
@@ -224,13 +224,13 @@ static void shutdown_m32700ut_lanpld_irq
 
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
@@ -293,13 +293,13 @@ static void shutdown_m32700ut_lcdpld_irq
 
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
diff -ruNp a/arch/m32r/kernel/setup_mappi.c b/arch/m32r/kernel/setup_mappi.c
--- a/arch/m32r/kernel/setup_mappi.c	2004-12-25 06:35:00.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi.c	2005-06-03 11:18:35.000000000 +0900
@@ -70,13 +70,13 @@ static void shutdown_mappi_irq(unsigned 
 
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
diff -ruNp a/arch/m32r/kernel/setup_mappi2.c b/arch/m32r/kernel/setup_mappi2.c
--- a/arch/m32r/kernel/setup_mappi2.c	2005-06-02 12:09:20.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi2.c	2005-06-03 10:39:21.000000000 +0900
@@ -79,13 +79,13 @@ static void shutdown_mappi2_irq(unsigned
 
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
diff -ruNp a/arch/m32r/kernel/setup_mappi3.c b/arch/m32r/kernel/setup_mappi3.c
--- a/arch/m32r/kernel/setup_mappi3.c	2005-06-02 12:09:20.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi3.c	2005-06-02 20:59:00.000000000 +0900
@@ -79,13 +79,13 @@ static void shutdown_mappi3_irq(unsigned
 
 static struct hw_interrupt_type mappi3_irq_type =
 {
-	"MAPPI3-IRQ",
-	startup_mappi3_irq,
-	shutdown_mappi3_irq,
-	enable_mappi3_irq,
-	disable_mappi3_irq,
-	mask_and_ack_mappi3,
-	end_mappi3_irq
+	.typename = "MAPPI3-IRQ",
+	.startup = startup_mappi3_irq,
+	.shutdown = shutdown_mappi3_irq,
+	.enable = enable_mappi3_irq,
+	.disable = disable_mappi3_irq,
+	.ack = mask_and_ack_mappi3,
+	.end = end_mappi3_irq
 };
 
 void __init init_IRQ(void)
diff -ruNp a/arch/m32r/kernel/setup_oaks32r.c b/arch/m32r/kernel/setup_oaks32r.c
--- a/arch/m32r/kernel/setup_oaks32r.c	2004-12-25 06:35:40.000000000 +0900
+++ b/arch/m32r/kernel/setup_oaks32r.c	2005-06-03 10:43:02.000000000 +0900
@@ -70,13 +70,13 @@ static void shutdown_oaks32r_irq(unsigne
 
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
diff -ruNp a/arch/m32r/kernel/setup_opsput.c b/arch/m32r/kernel/setup_opsput.c
--- a/arch/m32r/kernel/setup_opsput.c	2004-12-25 06:33:48.000000000 +0900
+++ b/arch/m32r/kernel/setup_opsput.c	2005-06-03 10:54:29.000000000 +0900
@@ -79,13 +79,13 @@ static void shutdown_opsput_irq(unsigned
 
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
@@ -156,13 +156,13 @@ static void shutdown_opsput_pld_irq(unsi
 
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
diff -ruNp a/arch/m32r/kernel/setup_usrv.c b/arch/m32r/kernel/setup_usrv.c
--- a/arch/m32r/kernel/setup_usrv.c	2004-12-25 06:35:01.000000000 +0900
+++ b/arch/m32r/kernel/setup_usrv.c	2005-06-03 11:20:21.000000000 +0900
@@ -70,13 +70,13 @@ static void shutdown_mappi_irq(unsigned 
 
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
@@ -143,13 +143,13 @@ static void shutdown_m32700ut_pld_irq(un
 
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

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
