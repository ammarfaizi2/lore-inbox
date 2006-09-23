Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWIWAWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWIWAWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWIWAWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:22:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15795 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932207AbWIWAWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:22:49 -0400
Date: Sat, 23 Sep 2006 01:22:46 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sanitize frv archclean
Message-ID: <20060923002246.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/frv/Makefile      |    5 +----
 arch/frv/boot/Makefile |    3 ++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/frv/Makefile b/arch/frv/Makefile
index d163747..038e3a8 100644
--- a/arch/frv/Makefile
+++ b/arch/frv/Makefile
@@ -108,11 +108,8 @@ Image: vmlinux
 bootstrap:
 	$(Q)$(MAKEBOOT) bootstrap
 
-archmrproper:
-	$(Q)$(MAKE) $(build)=arch/frv/boot mrproper
-
 archclean:
-	$(Q)$(MAKE) $(build)=arch/frv/boot clean
+	$(Q)$(MAKE) $(clean)=arch/frv/boot
 
 archdep: scripts/mkdep symlinks
 	$(Q)$(MAKE) $(build)=arch/frv/boot dep
diff --git a/arch/frv/boot/Makefile b/arch/frv/boot/Makefile
index 5dfc93f..dc6f038 100644
--- a/arch/frv/boot/Makefile
+++ b/arch/frv/boot/Makefile
@@ -8,6 +8,8 @@ #
 # Copyright (C) 1995-2000 Russell King
 #
 
+targets := Image zImage bootpImage
+
 SYSTEM	=$(TOPDIR)/$(LINUX)
 
 ZTEXTADDR	 = 0x02080000
@@ -66,7 +68,6 @@ #
 # miscellany
 #
 mrproper clean:
-	$(RM) Image zImage bootpImage
 #	@$(MAKE) -C compressed clean
 #	@$(MAKE) -C bootp clean
 
-- 
1.4.2.GIT
