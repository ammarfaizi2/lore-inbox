Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbTIJTXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbTIJTVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:21:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15885 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265609AbTIJTSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:18:47 -0400
Date: Wed, 10 Sep 2003 21:18:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: kbuild/ppc*: Remove obsolete _config support
Message-ID: <20030910191846.GE5604@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910191411.GA5517@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1272  -> 1.1273 
#	   arch/ppc/Makefile	1.43    -> 1.44   
#	 arch/ppc64/Makefile	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	sam@mars.ravnborg.org	1.1273
# kbuild/ppc*: Remove obsolete _config support
# --------------------------------------------
#
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	Wed Sep 10 21:15:51 2003
+++ b/arch/ppc/Makefile	Wed Sep 10 21:15:51 2003
@@ -58,10 +58,6 @@
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=arch/ppc/boot $@
 
-%_config: arch/ppc/configs/%_defconfig
-	rm -f .config arch/ppc/defconfig
-	cp -f arch/ppc/configs/$(@:config=defconfig) .config
-
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
 
diff -Nru a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile	Wed Sep 10 21:15:51 2003
+++ b/arch/ppc64/Makefile	Wed Sep 10 21:15:51 2003
@@ -41,10 +41,6 @@
 $(boottarget-y): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-%_config: arch/ppc64/configs/%_defconfig
-	rm -f .config arch/ppc64/defconfig
-	cp -f arch/ppc64/configs/$(@:config=defconfig) arch/ppc64/defconfig
-
 bootimage-$(CONFIG_PPC_PSERIES) := zImage
 bootimage-$(CONFIG_PPC_ISERIES) := vmlinux.sm
 BOOTIMAGE := $(bootimage-y)
