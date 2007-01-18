Return-Path: <linux-kernel-owner+w=401wt.eu-S932435AbXARNHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbXARNHp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbXARNE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:54878 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932389AbXARNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:19 -0500
Message-Id: <20070118130030.966626000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:10 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 21/26] Dynamic kernel command-line - sparc
Content-Disposition: inline; filename=dynamic-kernel-command-line-sparc.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/sparc/kernel/setup.c       |    2 +-
 arch/sparc/kernel/sparc_ksyms.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/sparc/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/sparc/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/sparc/kernel/setup.c
@@ -246,7 +246,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	strcpy(boot_command_line, *cmdline_p);
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
Index: linux-2.6.20-rc4-mm1/arch/sparc/kernel/sparc_ksyms.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/sparc/kernel/sparc_ksyms.c
+++ linux-2.6.20-rc4-mm1/arch/sparc/kernel/sparc_ksyms.c
@@ -229,7 +229,7 @@ EXPORT_SYMBOL(prom_getproplen);
 EXPORT_SYMBOL(prom_getproperty);
 EXPORT_SYMBOL(prom_node_has_property);
 EXPORT_SYMBOL(prom_setprop);
-EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(boot_command_line);
 EXPORT_SYMBOL(prom_apply_obio_ranges);
 EXPORT_SYMBOL(prom_feval);
 EXPORT_SYMBOL(prom_getbool);

-- 
