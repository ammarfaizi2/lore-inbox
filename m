Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUIFRvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUIFRvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUIFRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:50:09 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61871 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268396AbUIFRt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:49:57 -0400
Subject: [patch 1/1] uml: no extraversion in arch/um/Makefile for mainline
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 06 Sep 2004 19:35:24 +0200
Message-Id: <20040906173524.EE034B977@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extraversion in arch/um/Makefile is not needed in mainline, but just for
separate patches; also, they should set it in the main Makefile, not elsewhere
(Jeff Garzik has just complained).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Makefile |    9 ---------
 1 files changed, 9 deletions(-)

diff -puN arch/um/Makefile~uml-no-extraversion-in-mainline arch/um/Makefile
--- uml-linux-2.6.8.1/arch/um/Makefile~uml-no-extraversion-in-mainline	2004-09-06 19:23:08.400492544 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Makefile	2004-09-06 19:24:05.342835992 +0200
@@ -10,13 +10,6 @@ SHELL := /bin/bash
 
 filechk_gen_header = $<
 
-# Recalculate MODLIB to reflect the EXTRAVERSION changes (via KERNELRELEASE)
-# The way the toplevel Makefile is written EXTRAVERSION is not supposed
-# to be changed outside the toplevel Makefile, but recalculating MODLIB is
-# a sufficient workaround until we no longer need architecture dependent
-# EXTRAVERSION...
-MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
-
 core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/drivers/		\
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -44,8 +37,6 @@ SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$
 include $(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(ARCH_DIR)/Makefile-os-$(OS)
 
-EXTRAVERSION := $(EXTRAVERSION)-1um
-
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
_
