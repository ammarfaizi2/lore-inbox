Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVATS3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVATS3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVATS1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:27:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19212 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261380AbVATSUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:20:20 -0500
Date: Thu, 20 Jan 2005 19:20:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] unexport profile_pc
Message-ID: <20050120182019.GJ3174@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any modular usage of profile_pc in the kernel.

Is the patch below correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/kernel/time.c     |    1 -
 arch/i386/kernel/time.c    |    1 -
 arch/ppc/kernel/time.c     |    1 -
 arch/ppc64/kernel/time.c   |    1 -
 arch/sparc64/kernel/time.c |    1 -
 arch/x86_64/kernel/time.c  |    1 -
 6 files changed, 6 deletions(-)

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/time.c.old	2005-01-20 19:00:34.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/time.c	2005-01-20 19:00:44.000000000 +0100
@@ -209,7 +209,6 @@
 
 	return pc;
 }
-EXPORT_SYMBOL(profile_pc);
 #endif
 
 /*
--- linux-2.6.11-rc1-mm2-full/arch/sparc64/kernel/time.c.old	2005-01-20 19:00:52.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/sparc64/kernel/time.c	2005-01-20 19:00:56.000000000 +0100
@@ -86,7 +86,6 @@
 		return regs->u_regs[UREG_RETPC];
 	return pc;
 }
-EXPORT_SYMBOL(profile_pc);
 #endif
 
 static void tick_disable_protection(void)
--- linux-2.6.11-rc1-mm2-full/arch/arm/kernel/time.c.old	2005-01-20 19:01:05.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/arm/kernel/time.c	2005-01-20 19:01:08.000000000 +0100
@@ -69,7 +69,6 @@
 
 	return pc;
 }
-EXPORT_SYMBOL(profile_pc);
 #endif
 
 /*
--- linux-2.6.11-rc1-mm2-full/arch/ppc/kernel/time.c.old	2005-01-20 19:01:14.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/ppc/kernel/time.c	2005-01-20 19:01:18.000000000 +0100
@@ -119,7 +119,6 @@
 
 	return pc;
 }
-EXPORT_SYMBOL(profile_pc);
 #endif
 
 /*
--- linux-2.6.11-rc1-mm2-full/arch/ppc64/kernel/time.c.old	2005-01-20 19:01:25.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/ppc64/kernel/time.c	2005-01-20 19:01:29.000000000 +0100
@@ -206,7 +206,6 @@
 
 	return pc;
 }
-EXPORT_SYMBOL(profile_pc);
 #endif
 
 #ifdef CONFIG_PPC_ISERIES
--- linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/time.c.old	2005-01-20 19:01:36.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/x86_64/kernel/time.c	2005-01-20 19:01:42.000000000 +0100
@@ -199,7 +199,6 @@
 	}
 	return pc;
 }
-EXPORT_SYMBOL(profile_pc);
 
 /*
  * In order to set the CMOS clock precisely, set_rtc_mmss has to be called 500

