Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbUCYApO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUCYAjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:39:21 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:13278 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262623AbUCXX6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:58:43 -0500
Subject: [patch 7/22] __early_param for cris
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
From: trini@kernel.crashing.org
Message-Id: <20040324235840.JIA2477.fed1mtao01.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:58:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Remove saved_command_line (and saving of the command line).
- Call parse_early_options


---

 linux-2.6-early_setup-trini/arch/cris/kernel/setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/cris/kernel/setup.c~cris arch/cris/kernel/setup.c
--- linux-2.6-early_setup/arch/cris/kernel/setup.c~cris	2004-03-24 16:15:06.600701403 -0700
+++ linux-2.6-early_setup-trini/arch/cris/kernel/setup.c	2004-03-24 16:15:06.602700953 -0700
@@ -31,7 +31,6 @@ extern char _etext, _edata, _end;
 #define COMMAND_LINE_SIZE 256
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 extern const unsigned long text_start, edata; /* set by the linker script */
 extern unsigned long dram_start, dram_end;
@@ -160,6 +159,7 @@ setup_arch(char **cmdline_p)
 		sizeof(command_line));
 #endif
 	command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	parse_early_options(cmdline_p);
 
 	/* give credit for the CRIS port */
 

_
