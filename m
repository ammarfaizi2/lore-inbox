Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVBJQqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVBJQqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVBJQqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 11:46:10 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:12558 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262160AbVBJQqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 11:46:03 -0500
Subject: [patch 1/1] Uml: fix makefile typo [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 10 Feb 2005 17:40:37 +0100
Message-Id: <20050210164037.E43784B51@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>

Fix a typo in the Makefile cleanup merged earlier, which causes compile
failures in some edge cases.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/Makefile~uml-fix-mode-makefile arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-fix-mode-makefile	2005-02-10 17:38:46.273481568 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-02-10 17:38:46.276481112 +0100
@@ -39,8 +39,8 @@ MODE_INCLUDE	+= $(foreach mode,$(um-mode
 MAKEFILES-INCL	+= $(foreach mode,$(um-modes-y),\
 		   $(srctree)/$(ARCH_DIR)/Makefile-$(mode))
 
-ifneq ($(MAKEFILE-INCL),)
-  include $(MAKEFILE-INCL)
+ifneq ($(MAKEFILES-INCL),)
+  include $(MAKEFILES-INCL)
 endif
 
 ARCH_INCLUDE	:= -I$(ARCH_DIR)/include
_
