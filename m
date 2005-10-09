Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVJITmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVJITmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVJITmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:42:43 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:25496 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751038AbVJITmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:42:33 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/6] Uml: hide commands when not being verbose
Date: Sun, 09 Oct 2005 21:37:05 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051009193705.26019.10908.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add a missing $(Q) to a "ln" invocation.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -152,7 +152,7 @@ archclean:
 $(SYMLINK_HEADERS):
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
-	ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
+	$(Q)ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
 else
 	$(Q)cd $(TOPDIR)/$(dir $@) ; \
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)

