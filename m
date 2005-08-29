Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbVH2USo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbVH2USo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbVH2UOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:14:03 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:36878 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751598AbVH2UOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:14:01 -0400
Message-Id: <200508292007.j7TK70Iu029922@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 3/9] UML - Remove libc reference in build
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro - Remove an unneeded reference to libc

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/scripts/Makefile.unmap
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/scripts/Makefile.unmap	2005-08-08 12:11:18.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/scripts/Makefile.unmap	2005-08-15 13:55:40.000000000 -0400
@@ -12,7 +12,7 @@
 
 quiet_cmd_wrapld = LD      $@
 define cmd_wrapld
-	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) $(CFLAGS) -print-file-name=libc.a); \
+	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< ; \
 	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
 endef
 

