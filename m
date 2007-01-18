Return-Path: <linux-kernel-owner+w=401wt.eu-S932331AbXARNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbXARNEx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbXARNE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:54873 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348AbXARNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:17 -0500
Message-Id: <20070118130030.026612000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:01 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 12/26] Dynamic kernel command-line - m68k
Content-Disposition: inline; filename=dynamic-kernel-command-line-m68k.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/m68k/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.20-rc4-mm1/arch/m68k/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/m68k/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/m68k/kernel/setup.c
@@ -256,7 +256,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) &_end;
 
 	*cmdline_p = m68k_command_line;
-	memcpy(saved_command_line, *cmdline_p, CL_SIZE);
+	memcpy(boot_command_line, *cmdline_p, CL_SIZE);
 
 	/* Parse the command line for arch-specific options.
 	 * For the m68k, this is currently only "debug=xxx" to enable printing

-- 
