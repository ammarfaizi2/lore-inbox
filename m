Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbXARNEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbXARNEy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 08:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbXARNEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 08:04:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:50520 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbXARNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 08:04:18 -0500
Message-Id: <20070118130030.663647000@strauss.suse.de>
References: <20070118125849.441998000@strauss.suse.de>
User-Agent: quilt/0.46-14
Date: Thu, 18 Jan 2007 13:59:07 +0100
From: Bernhard Walle <bwalle@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [patch 18/26] Dynamic kernel command-line - s390
Content-Disposition: inline; filename=dynamic-kernel-command-line-s390.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---
 arch/s390/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.20-rc4-mm1/arch/s390/kernel/setup.c
===================================================================
--- linux-2.6.20-rc4-mm1.orig/arch/s390/kernel/setup.c
+++ linux-2.6.20-rc4-mm1/arch/s390/kernel/setup.c
@@ -625,7 +625,7 @@ setup_arch(char **cmdline_p)
 #endif /* CONFIG_64BIT */
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
 
 	*cmdline_p = COMMAND_LINE;
 	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';

-- 
