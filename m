Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVKQXsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVKQXsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVKQXsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:48:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:30375 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965131AbVKQXsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:48:11 -0500
Date: Thu, 17 Nov 2005 17:45:40 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, <linuxppc-embedded@ozlabs.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] ppc: Fix warnings related to seq_file
Message-ID: <Pine.LNX.4.44.0511171745150.17133-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we moved things around in irq.h seq_file became an issue.  Fix
warnings related to its usage.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit ac2a1a810d71d6c5f928cfbb428717bc3c567fde
tree c213a8035b6bb13aeb5e2bf639b3af9830462fb2
parent 81fa90f4627668b94ba55163dca08b076ee71e50
author Kumar Gala <galak@kernel.crashing.org> Thu, 17 Nov 2005 17:47:03 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 17 Nov 2005 17:47:03 -0600

 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |    2 ++
 arch/ppc/platforms/85xx/stx_gp3.h            |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
index 7b26bcc..198a6a0 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
@@ -25,6 +25,8 @@
 #define BCSR_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
+struct seq_file;
+
 extern int mpc85xx_ads_show_cpuinfo(struct seq_file *m);
 extern void mpc85xx_ads_init_IRQ(void) __init;
 extern void mpc85xx_ads_map_io(void) __init;
diff --git a/arch/ppc/platforms/85xx/stx_gp3.h b/arch/ppc/platforms/85xx/stx_gp3.h
index 7bcc6c3..2f25b51 100644
--- a/arch/ppc/platforms/85xx/stx_gp3.h
+++ b/arch/ppc/platforms/85xx/stx_gp3.h
@@ -21,7 +21,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xe0000000)
@@ -43,7 +42,6 @@ extern void mpc85xx_setup_hose(void) __i
 extern void mpc85xx_restart(char *cmd);
 extern void mpc85xx_power_off(void);
 extern void mpc85xx_halt(void);
-extern int mpc85xx_show_cpuinfo(struct seq_file *m);
 extern void mpc85xx_init_IRQ(void) __init;
 extern unsigned long mpc85xx_find_end_of_memory(void) __init;
 extern void mpc85xx_calibrate_decr(void) __init;

