Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVGZURo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVGZURo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGZUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:15:27 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:21772 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262044AbVGZUPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:15:05 -0400
Message-Id: <200507262003.j6QK3oZU010061@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       olh@suse.de
Subject: [PATCH 1/4] UML - Fix rc3-mm1 build
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jul 2005 16:03:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olh@suse.de>

New in 2.6.13-rc3-git4:

scripts/Makefile.build:13: /Makefile: No such file or directory
scripts/Makefile.build:64: kbuild: Makefile.build is included improperly

the define was removed, but its still required to build some targets.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/Makefile-i386
===================================================================
--- linux-2.6.12.orig/arch/um/Makefile-i386	2005-07-18 11:53:17.000000000 -0400
+++ linux-2.6.12/arch/um/Makefile-i386	2005-07-18 11:54:30.000000000 -0400
@@ -33,6 +33,7 @@
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
 
+SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 prepare: $(SYS_HEADERS)

