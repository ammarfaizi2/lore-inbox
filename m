Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275043AbRIYPaG>; Tue, 25 Sep 2001 11:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275033AbRIYP34>; Tue, 25 Sep 2001 11:29:56 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:24849 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275043AbRIYP3n>;
	Tue, 25 Sep 2001 11:29:43 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, linux-irda@pasta.cs.uit.no
Subject: [patch] 2.4.10 drivers/net/irda/smc-ircc.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 01:29:58 +1000
Message-ID: <19781.1001431798@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Data should be __initdata, not __init, and cannot be const.

Index: 10.1/drivers/net/irda/smc-ircc.c
--- 10.1/drivers/net/irda/smc-ircc.c Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/f/c/23_smc-ircc.c 1.3.1.1.1.1.1.1 644)
+++ 10.9(w)/drivers/net/irda/smc-ircc.c Wed, 26 Sep 2001 01:26:37 +1000 kaos (linux-2.4/f/c/23_smc-ircc.c 1.3.1.1.1.1.1.1 644)
@@ -99,7 +99,7 @@ static int  ircc_pmproc(struct pm_dev *d
 #define	SERx4	8	/* SuperIO Chip supports 115,2 KBaud * 4=460,8 KBaud */
 
 /* These are the currently known SMC SuperIO chipsets */
-static const smc_chip_t __init fdc_chips_flat[]=
+static smc_chip_t __initdata fdc_chips_flat[]=
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37C44",	KEY55_1|NoIRDA,		0x00, 0x00 }, /* This chip can not detected */
@@ -113,7 +113,7 @@ static const smc_chip_t __init fdc_chips
 	{ NULL }
 };
 
-static const smc_chip_t __init fdc_chips_paged[]=
+static smc_chip_t __initdata fdc_chips_paged[]=
 {
 	/* Base address 0x3f0 or 0x370 */
 	{ "37B72X",	KEY55_1|SIR|SERx4,	0x4c, 0x00 },
@@ -132,7 +132,7 @@ static const smc_chip_t __init fdc_chips
 	{ NULL }
 };
 
-static const smc_chip_t __init lpc_chips_flat[]=
+static smc_chip_t __initdata lpc_chips_flat[]=
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47N227",	KEY55_1|FIR|SERx4,	0x5a, 0x00 },
@@ -140,7 +140,7 @@ static const smc_chip_t __init lpc_chips
 	{ NULL }
 };
 
-static const smc_chip_t __init lpc_chips_paged[]=
+static smc_chip_t __initdata lpc_chips_paged[]=
 {
 	/* Base address 0x2E or 0x4E */
 	{ "47B27X",	KEY55_1|SIR|SERx4,	0x51, 0x00 },

