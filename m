Return-Path: <linux-kernel-owner+w=401wt.eu-S932447AbXARNHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbXARNHo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbXARNE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:59 -0500
Received: from ns.suse.de ([195.135.220.2]:50524 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932393AbXARNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:19 -0500
Message-Id: <20070118130031.059485000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:11 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 22/26] Dynamic kernel command-line - sparc64
Content-Disposition: inline; filename=dynamic-kernel-command-line-sparc64.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/sparc64/kernel/setup.c         |    2 +-
 arch/sparc64/kernel/sparc64_ksyms.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/sparc64/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/sparc64/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/sparc64/kernel/setup.c
@@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	strcpy(boot_command_line, *cmdline_p);
 
 	if (tlb_type == hypervisor)
 		printk("ARCH: SUN4V\n");
Index: linux-2.6.20-rc4-mm1/arch/sparc64/kernel/sparc64_ksyms.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/sparc64/kernel/sparc64_ksyms.c
+++ linux-2.6.20-rc4-mm1/arch/sparc64/kernel/sparc64_ksyms.c
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(prom_getproplen);
 EXPORT_SYMBOL(prom_getproperty);
 EXPORT_SYMBOL(prom_node_has_property);
 EXPORT_SYMBOL(prom_setprop);
-EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(boot_command_line);
 EXPORT_SYMBOL(prom_finddevice);
 EXPORT_SYMBOL(prom_feval);
 EXPORT_SYMBOL(prom_getbool);

-- 
