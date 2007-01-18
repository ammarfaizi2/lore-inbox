Return-Path: <linux-kernel-owner+w=401wt.eu-S932407AbXARNFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbXARNFt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbXARNEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:22 -0500
Received: from mx1.suse.de ([195.135.220.2]:50514 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbXARNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:16 -0500
Message-Id: <20070118130029.372537000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:58:55 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 06/26] Dynamic kernel command-line - cris
Content-Disposition: inline; filename=dynamic-kernel-command-line-cris.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set cris_command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/cris/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/cris/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/cris/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/cris/kernel/setup.c
@@ -29,7 +29,7 @@ struct screen_info screen_info;
 extern int root_mountflags;
 extern char _etext, _edata, _end;
 
-char cris_command_line[COMMAND_LINE_SIZE] = { 0, };
+char __initdata cris_command_line[COMMAND_LINE_SIZE] = { 0, };
 
 extern const unsigned long text_start, edata; /* set by the linker script */
 extern unsigned long dram_start, dram_end;
@@ -153,8 +153,8 @@ setup_arch(char **cmdline_p)
 #endif
 
 	/* Save command line for future references. */
-	memcpy(saved_command_line, cris_command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	memcpy(boot_command_line, cris_command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
 
 	/* give credit for the CRIS port */
 	show_etrax_copyright();

-- 
