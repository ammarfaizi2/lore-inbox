Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUJWEaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUJWEaH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUJWE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:29:19 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:3975
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S267661AbUJWE0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:26:17 -0400
Subject: [patch 4/5] uml: KBUILD_OUTPUT fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sat, 23 Oct 2004 05:53:21 +0200
Message-Id: <20041023035321.47D4E95D3@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/Makefile~uml-KBUILD_OUTPUT-fix arch/um/Makefile
--- vanilla-linux-2.6.9/arch/um/Makefile~uml-KBUILD_OUTPUT-fix	2004-10-21 02:05:31.482358736 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/Makefile	2004-10-21 02:15:20.592800336 +0200
@@ -28,14 +28,14 @@ MAKEFILE-$(CONFIG_MODE_TT) += Makefile-t
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
 
 ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
+  include $(addprefix $(srctree)/$(ARCH_DIR)/,$(MAKEFILE-y))
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-include $(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
_
