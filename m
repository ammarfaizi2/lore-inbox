Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbTAJKHD>; Fri, 10 Jan 2003 05:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264767AbTAJKHD>; Fri, 10 Jan 2003 05:07:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2549 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264766AbTAJKHC>; Fri, 10 Jan 2003 05:07:02 -0500
Date: Fri, 10 Jan 2003 11:15:41 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Scott Bambrough <scottb@rebel.com>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 code from arch/arm/nwfpe/fpmodule.c
Message-ID: <20030110101541.GE6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a #if for kernel 2.0 from
arch/arm/nwfpe/fpmodule.c in 2.5.55.

Please apply
Adrian


--- linux-2.5.55/arch/arm/nwfpe/fpmodule.c.old	2003-01-10 11:12:13.000000000 +0100
+++ linux-2.5.55/arch/arm/nwfpe/fpmodule.c	2003-01-10 11:12:33.000000000 +0100
@@ -44,10 +44,9 @@
 /* kernel symbols required for signal handling */
 #ifdef MODULE
 void fp_send_sig(unsigned long sig, struct task_struct *p, int priv);
-#if LINUX_VERSION_CODE > 0x20115
+
 MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
 MODULE_DESCRIPTION("NWFPE floating point emulator");
-#endif
 
 #else
 #define fp_send_sig	send_sig
