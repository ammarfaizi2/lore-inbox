Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUBZWo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUBZWo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:44:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36576 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261217AbUBZWnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:43:43 -0500
Date: Thu, 26 Feb 2004 23:43:34 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: rmk@arm.linux.org.uk, spyro@f2s.com, Scott Bambrough <scottb@rebel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove kernel 2.0 #ifdef's from arm{,26} code
Message-ID: <20040226224333.GW5499@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes #ifdef's for kernel 2.0 from 
arch/arm{,26}/nwfpe/fpmodule.c .

Please apply
Adrian


--- linux-2.6.3-mm4/arch/arm26/nwfpe/fpmodule.c.old	2004-02-26 23:40:02.000000000 +0100
+++ linux-2.6.3-mm4/arch/arm26/nwfpe/fpmodule.c	2004-02-26 23:41:14.000000000 +0100
@@ -46,10 +46,9 @@
 
 #ifdef MODULE
 void fp_send_sig(unsigned long sig, PTASK p, int priv);
-#if LINUX_VERSION_CODE > 0x20115
+
 MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
 MODULE_DESCRIPTION("NWFPE floating point emulator");
-#endif
 
 #else
 #define fp_send_sig	send_sig
--- linux-2.6.3-mm4/arch/arm/nwfpe/fpmodule.c.old	2004-02-26 23:40:56.000000000 +0100
+++ linux-2.6.3-mm4/arch/arm/nwfpe/fpmodule.c	2004-02-26 23:41:07.000000000 +0100
@@ -50,10 +50,9 @@
 
 #ifdef MODULE
 void fp_send_sig(unsigned long sig, struct task_struct *p, int priv);
-#if LINUX_VERSION_CODE > 0x20115
+
 MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
 MODULE_DESCRIPTION("NWFPE floating point emulator (" NWFPE_BITS " precision)");
-#endif
 
 #else
 #define fp_send_sig	send_sig
