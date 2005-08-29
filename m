Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbVH2UOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbVH2UOD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVH2UOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:14:02 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:37134 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751548AbVH2UOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:14:01 -0400
Message-Id: <200508292006.j7TK6vke029916@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 2/9] UML - Build cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:06:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro - Build cleanups

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/Makefile
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/Makefile	2005-08-15 12:03:04.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/Makefile	2005-08-15 13:16:39.000000000 -0400
@@ -56,6 +56,7 @@
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap
+AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
Index: linux-2.6.13-rc6/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-i386/Makefile	2005-08-15 12:02:57.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-i386/Makefile	2005-08-15 13:16:55.000000000 -0400
@@ -22,8 +22,6 @@
 # why ask why?
 $(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
 
-$(obj)/stub.o : a_flags = $(STUB_CFLAGS)
-
 subdir- := util
 
 include arch/um/scripts/Makefile.unmap
Index: linux-2.6.13-rc6/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-x86_64/Makefile	2005-08-15 12:03:02.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-x86_64/Makefile	2005-08-15 13:17:21.000000000 -0400
@@ -34,8 +34,6 @@
 # why ask why?
 $(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
 
-$(obj)/stub.o : a_flags = $(STUB_CFLAGS)
-
 subdir- := util
 
 include arch/um/scripts/Makefile.unmap

