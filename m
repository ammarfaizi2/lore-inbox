Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVAXVFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVAXVFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:03:45 -0500
Received: from mail.dif.dk ([193.138.115.101]:37061 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261652AbVAXVCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:02:40 -0500
Date: Mon, 24 Jan 2005 22:05:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make 'make help' show all *config targets and update
 descriptions slightly.
Message-ID: <Pine.LNX.4.61.0501242201200.2798@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"make help" doesn't show "make randconfig" nor "make config" as options 
and the description of oldconfig could be better (IMHO). Patch below adds 
the missing targets to the help and updates the description of oldconfig.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc2-bk2-orig/scripts/kconfig/Makefile	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc2-bk2/scripts/kconfig/Makefile	2005-01-24 21:42:21.000000000 +0100
@@ -49,12 +49,14 @@
 	$(Q)$< -D arch/$(ARCH)/configs/$@ arch/$(ARCH)/Kconfig
 
 # Help text used by make help
 help:
-	@echo  '  oldconfig	  - Update current config utilising a line-oriented program'
+	@echo  '  config	  - Update current config utilising a line-oriented program'
 	@echo  '  menuconfig	  - Update current config utilising a menu based program'
 	@echo  '  xconfig	  - Update current config utilising a QT based front-end'
 	@echo  '  gconfig	  - Update current config utilising a GTK based front-end'
+	@echo  '  oldconfig	  - Update current config utilising a provided .config as base'
+	@echo  '  randconfig	  - New config with random answer to all options'
 	@echo  '  defconfig	  - New config with default answer to all options'
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
 	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
 	@echo  '  allnoconfig	  - New minimal config'




