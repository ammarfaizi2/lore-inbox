Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVEAVSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVEAVSk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVEAVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:18:39 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:19987 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262679AbVEAVSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:23 -0400
Message-Id: <200505012112.j41LCqT3016451@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/22] UML - Tidy Makefile.rules
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some breaking of some overly-long lines.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/scripts/Makefile.rules
===================================================================
--- linux-2.6.11-mm.orig/arch/um/scripts/Makefile.rules	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/scripts/Makefile.rules	2005-04-30 13:09:24.000000000 -0400
@@ -2,12 +2,13 @@
 # arch/um: Generic definitions
 # ===========================================================================
 
-USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
-USER_OBJS += $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))
-
+USER_SINGLE_OBJS := \
+	$(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
+USER_OBJS += $(filter %_user.o,$(obj-y) $(obj-m)  $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-$(USER_OBJS): c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
+	$(CFLAGS_$(notdir $@))
 
 quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@

