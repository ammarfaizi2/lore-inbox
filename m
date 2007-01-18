Return-Path: <linux-kernel-owner+w=401wt.eu-S932414AbXARNEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbXARNEx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbXARNE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:50518 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbXARNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:17 -0500
Message-Id: <20070118130029.919022000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:00 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 11/26] Dynamic kernel command-line - m32r
Content-Disposition: inline; filename=dynamic-kernel-command-line-m32r.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/m32r/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc4-mm1/arch/m32r/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/m32r/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/m32r/kernel/setup.c
@@ -64,7 +64,7 @@ struct screen_info screen_info = {
 
 extern int root_mountflags;
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static struct resource data_resource = {
 	.name   = "Kernel data",
@@ -95,8 +95,8 @@ static __inline__ void parse_mem_cmdline
 	int usermem = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)CONFIG_MEMORY_START+PAGE_OFFSET;
 	memory_end = memory_start+(unsigned long)CONFIG_MEMORY_SIZE;

-- 
