Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUGTTMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUGTTMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUGTSkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:40:32 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:46623
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S266134AbUGTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:06 -0400
Date: Tue, 20 Jul 2004 20:38:00 +0200
Message-Id: <200407201838.i6KIc0jb015379@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 462] m68k sparse missing void
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing `void' parameters (found by sparse)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/bvme6000/config.c	2004-04-27 20:46:00.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/bvme6000/config.c	2004-07-10 21:06:54.000000000 +0200
@@ -70,7 +70,7 @@
 		return 1;
 }
 
-void bvme6000_reset()
+void bvme6000_reset(void)
 {
 	volatile PitRegsPtr pit = (PitRegsPtr)BVME_PIT_BASE;
 
--- linux-2.6.8-rc2/arch/m68k/mvme147/config.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/mvme147/config.c	2004-07-10 21:06:54.000000000 +0200
@@ -69,7 +69,7 @@
 		return 1;
 }
 
-void mvme147_reset()
+void mvme147_reset(void)
 {
 	printk ("\r\n\nCalled mvme147_reset\r\n");
 	m147_pcc->watchdog = 0x0a;	/* Clear timer */
--- linux-2.6.8-rc2/arch/m68k/mvme16x/config.c	2004-04-27 20:46:00.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/mvme16x/config.c	2004-07-10 21:06:54.000000000 +0200
@@ -75,7 +75,7 @@
 		return 1;
 }
 
-void mvme16x_reset()
+void mvme16x_reset(void)
 {
 	printk ("\r\n\nCalled mvme16x_reset\r\n"
 			"\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r");
--- linux-2.6.8-rc2/arch/m68k/q40/config.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/q40/config.c	2004-07-10 21:06:54.000000000 +0200
@@ -123,7 +123,7 @@
 }
 #endif
 
-void q40_reset()
+void q40_reset(void)
 {
         halted=1;
         printk ("\n\n*******************************************\n"
@@ -132,7 +132,7 @@
 	Q40_LED_ON();
 	while(1) ;
 }
-void q40_halt()
+void q40_halt(void)
 {
         halted=1;
         printk ("\n\n*******************\n"
@@ -296,7 +297,7 @@
 	return 0;
 }
 
-unsigned int q40_get_ss()
+unsigned int q40_get_ss(void)
 {
 	return bcd2bin(Q40_RTC_SECS);
 }
--- linux-2.6.8-rc2/drivers/macintosh/via-pmu68k.c	2004-04-27 20:47:20.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/macintosh/via-pmu68k.c	2004-07-10 21:06:54.000000000 +0200
@@ -177,7 +177,7 @@
 /*f8*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
 };
 
-int pmu_probe()
+int pmu_probe(void)
 {
 	if (macintosh_config->adb_type == MAC_ADB_PB1) {
 		pmu_kind = PMU_68K_V1;
@@ -521,7 +521,7 @@
 }
 
 static void 
-recv_byte()
+recv_byte(void)
 {
 	char c;
 
@@ -531,7 +531,7 @@
 }
 
 static void 
-pmu_start()
+pmu_start(void)
 {
 	unsigned long flags;
 	struct adb_request *req;
@@ -556,7 +556,7 @@
 }
 
 void 
-pmu_poll()
+pmu_poll(void)
 {
 	unsigned long flags;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
