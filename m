Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVEAVUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVEAVUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVEAVUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:20:15 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:25619 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262688AbVEAVSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:30 -0400
Message-Id: <200505012113.j41LD7QC016493@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 21/22] UML - Remove a dangling symlink
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:13:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

UML: remove no longer needed arch-signal.h

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/Makefile	2005-04-29 14:22:27.000000000 -0400
+++ linux-2.6.11/arch/um/Makefile	2005-04-29 14:39:05.000000000 -0400
@@ -17,7 +17,7 @@
 
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS := archparam.h system.h sigcontext.h processor.h ptrace.h \
-	arch-signal.h module.h vm-flags.h elf.h
+	module.h vm-flags.h elf.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
 # XXX: The "os" symlink is only used by arch/um/include/os.h, which includes
Index: linux-2.6.11/include/asm-um/arch-signal-i386.h
===================================================================
--- linux-2.6.11.orig/include/asm-um/arch-signal-i386.h	2005-04-29 13:44:52.000000000 -0400
+++ linux-2.6.11/include/asm-um/arch-signal-i386.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,24 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __UM_ARCH_SIGNAL_I386_H
-#define __UM_ARCH_SIGNAL_I386_H
-
-struct arch_signal_context {
-	unsigned long extrasigs[_NSIG_WORDS];
-};
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

