Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVEFW6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVEFW6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVEFWy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:54:57 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:39942 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261315AbVEFWyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:54:12 -0400
Message-Id: <200505062249.j46MnUA8010475@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/12] UML - Makefile cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates some stuff from arch/um/kernel/Makefile which refers to a 
file which has long since been deleted.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/Makefile	2005-05-05 12:19:04.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/Makefile	2005-05-05 12:42:52.000000000 -0400
@@ -23,14 +23,10 @@
 obj-$(CONFIG_MODE_TT) += tt/
 obj-$(CONFIG_MODE_SKAS) += skas/
 
-# This needs be compiled with frame pointers regardless of how the rest of the
-# kernel is built.
-CFLAGS_frame.o := -fno-omit-frame-pointer
-
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(user-objs-y) config.o helper.o main.o process.o tempfile.o \
-	time.o tty_log.o umid.o user_util.o frame.o
+	time.o tty_log.o umid.o user_util.o
 
 include arch/um/scripts/Makefile.rules
 

