Return-Path: <linux-kernel-owner+w=401wt.eu-S932289AbXARNEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbXARNEy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbXARNEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54877 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932374AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.558354000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:06 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 17/26] Dynamic kernel command-line - ppc
Content-Disposition: inline; filename=dynamic-kernel-command-line-ppc.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/ppc/kernel/setup.c         |    2 +-
 arch/ppc/platforms/lopec.c      |    2 +-
 arch/ppc/platforms/pplus.c      |    2 +-
 arch/ppc/platforms/prep_setup.c |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ppc/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/ppc/kernel/setup.c
@@ -543,7 +543,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) klimit;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	parse_early_param();
Index: linux-2.6.20-rc4-mm1/arch/ppc/platforms/lopec.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ppc/platforms/lopec.c
+++ linux-2.6.20-rc4-mm1/arch/ppc/platforms/lopec.c
@@ -344,7 +344,7 @@ lopec_setup_arch(void)
 		 if (bootargs != NULL) {
 			 strcpy(cmd_line, bootargs);
 			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
+			 strcpy(boot_command_line, cmd_line);
 		}
 	}
 #endif
Index: linux-2.6.20-rc4-mm1/arch/ppc/platforms/pplus.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ppc/platforms/pplus.c
+++ linux-2.6.20-rc4-mm1/arch/ppc/platforms/pplus.c
@@ -592,7 +592,7 @@ static void __init pplus_setup_arch(void
 		if (bootargs != NULL) {
 			strcpy(cmd_line, bootargs);
 			/* again.. */
-			strcpy(saved_command_line, cmd_line);
+			strcpy(boot_command_line, cmd_line);
 		}
 	}
 #endif
Index: linux-2.6.20-rc4-mm1/arch/ppc/platforms/prep_setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/ppc/platforms/prep_setup.c
+++ linux-2.6.20-rc4-mm1/arch/ppc/platforms/prep_setup.c
@@ -634,7 +634,7 @@ static void __init prep_init_sound(void)
 	/*
 	 * Find a way to push these informations to the cs4232 driver
 	 * Give it out with printk, when not in cmd_line?
-	 * Append it to  cmd_line and saved_command_line?
+	 * Append it to  cmd_line and boot_command_line?
 	 * Format is cs4232=io,irq,dma,dma2
 	 */
 }
@@ -897,7 +897,7 @@ prep_setup_arch(void)
 		 if (bootargs != NULL) {
 			 strcpy(cmd_line, bootargs);
 			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
+			 strcpy(boot_command_line, cmd_line);
 		}
 	}
 

-- 
