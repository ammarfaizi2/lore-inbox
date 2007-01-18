Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbXARNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbXARNEx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXARNE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:29 -0500
Received: from ns2.suse.de ([195.135.220.15]:54874 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.240001000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:03 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 14/26] Dynamic kernel command-line - mips
Content-Disposition: inline; filename=dynamic-kernel-command-line-mips.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/mips/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.20-rc4-mm1/arch/mips/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/mips/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/mips/kernel/setup.c
@@ -452,7 +452,7 @@ static void __init arch_mem_init(char **
 	print_memory_map();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 

-- 
