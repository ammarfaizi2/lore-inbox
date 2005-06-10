Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVFJPl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVFJPl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVFJPjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:39:15 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:31238 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262581AbVFJPep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:34:45 -0400
Message-Id: <200506101529.j5AFTSvl008276@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/4] UML - Build cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Jun 2005 11:29:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build failure when CONFIG_MODE_SKAS is disabled and make a Makefile
comment fit in 80 columns.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-i386/ptrace.h	2005-06-07 12:23:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-i386/ptrace.h	2005-06-07 12:35:21.000000000 -0400
@@ -8,6 +8,8 @@
 
 #include "uml-config.h"
 #include "user_constants.h"
+#include "sysdep/faultinfo.h"
+#include "choose-mode.h"
 
 #define MAX_REG_NR (UM_FRAME_SIZE / sizeof(unsigned long))
 #define MAX_REG_OFFSET (UM_FRAME_SIZE)
@@ -58,9 +60,6 @@ extern int sysemu_supported;
 #define PTRACE_SYSEMU_SINGLESTEP 32
 #endif
 
-#include "sysdep/faultinfo.h"
-#include "choose-mode.h"
-
 union uml_pt_regs {
 #ifdef UML_CONFIG_MODE_TT
 	struct tt_regs {
Index: linux-2.6.12-rc/arch/um/scripts/Makefile.rules
===================================================================
--- linux-2.6.12-rc.orig/arch/um/scripts/Makefile.rules	2005-06-07 12:23:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/scripts/Makefile.rules	2005-06-07 12:27:25.000000000 -0400
@@ -20,7 +20,7 @@ quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
 
 # this needs to be before the foreach, because targets does not accept
-# complete paths like $(obj)/$(f). To make sure this works, use a := assignment,
+# complete paths like $(obj)/$(f). To make sure this works, use a := assignment
 # or we will get $(obj)/$(f) in the "targets" value.
 # Also, this forces you to use the := syntax when assigning to targets.
 # Otherwise the line below will cause an infinite loop (if you don't know why,

