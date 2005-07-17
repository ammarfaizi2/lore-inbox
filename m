Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVGQOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVGQOwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVGQOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 10:52:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:65171 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261300AbVGQOw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 10:52:29 -0400
Date: Sun, 17 Jul 2005 16:52:28 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, blaisorblade@yahoo.it,
       linux-kernel@vger.kernel.org
Subject: [PATCH] readd missing define to arch/um/Makefile-i386
Message-ID: <20050717145228.GA15771@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


New in 2.6.13-rc3-git4:

scripts/Makefile.build:13: /Makefile: No such file or directory
scripts/Makefile.build:64: kbuild: Makefile.build is included improperly

the define was removed, but its still required to build some targets.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/um/Makefile-i386 |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13-rc3-git4/arch/um/Makefile-i386
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/um/Makefile-i386
+++ linux-2.6.13-rc3-git4/arch/um/Makefile-i386
@@ -33,6 +33,7 @@ ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
 
+SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 prepare: $(SYS_HEADERS)
