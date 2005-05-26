Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVEZWqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEZWqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVEZWoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:44:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41453 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261841AbVEZWkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:40:46 -0400
Message-Id: <200505262230.j4QMUSbu014688@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/7] UML - Remove 2_5compat.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old useless header that was used in Ye Olde Times during 2.4->2.5
porting to abstract differences. It's definitions are no more used anyway, so
let's finally kill it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ssl.c	2005-05-26 17:16:45.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/ssl.c	2005-05-26 17:17:01.000000000 -0400
@@ -22,7 +22,6 @@
 #include "init.h"
 #include "irq_user.h"
 #include "mconsole_kern.h"
-#include "2_5compat.h"
 
 static int ssl_version = 1;
 
Index: linux-2.6.11/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/stdio_console.c	2005-05-26 17:16:45.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/stdio_console.c	2005-05-26 17:17:01.000000000 -0400
@@ -28,7 +28,6 @@
 #include "irq_user.h"
 #include "mconsole_kern.h"
 #include "init.h"
-#include "2_5compat.h"
 
 #define MAX_TTYS (16)
 
Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-05-26 17:16:48.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-05-26 17:17:01.000000000 -0400
@@ -49,7 +49,6 @@
 #include "irq_user.h"
 #include "irq_kern.h"
 #include "ubd_user.h"
-#include "2_5compat.h"
 #include "os.h"
 #include "mem.h"
 #include "mem_kern.h"
Index: linux-2.6.11/arch/um/include/2_5compat.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/2_5compat.h	2005-05-26 17:16:45.000000000 -0400
+++ linux-2.6.11/arch/um/include/2_5compat.h	2003-09-15 09:40:47.000000000 -0400
@@ -1,24 +0,0 @@
-/* 
- * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __2_5_COMPAT_H__
-#define __2_5_COMPAT_H__
-
-#define INIT_HARDSECT(arr, maj, sizes)
-
-#define SET_PRI(task) do ; while(0)
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
Index: linux-2.6.11/arch/um/kernel/exec_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/exec_kern.c	2005-05-26 17:16:45.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/exec_kern.c	2005-05-26 17:17:01.000000000 -0400
@@ -16,7 +16,6 @@
 #include "kern.h"
 #include "irq_user.h"
 #include "tlb.h"
-#include "2_5compat.h"
 #include "os.h"
 #include "time_user.h"
 #include "choose-mode.h"
Index: linux-2.6.11/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/process_kern.c	2005-05-26 17:16:46.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/process_kern.c	2005-05-26 17:17:01.000000000 -0400
@@ -44,7 +44,6 @@
 #include "tlb.h"
 #include "frame_kern.h"
 #include "sigcontext.h"
-#include "2_5compat.h"
 #include "os.h"
 #include "mode.h"
 #include "mode_kern.h"
@@ -192,7 +191,6 @@ void default_idle(void)
 
 	while(1){
 		/* endless idle loop with no priority at all */
-		SET_PRI(current);
 
 		/*
 		 * although we are an idle CPU, we do not want to
Index: linux-2.6.11/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/trap_kern.c	2005-05-26 17:16:47.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/trap_kern.c	2005-05-26 17:17:01.000000000 -0400
@@ -23,7 +23,6 @@
 #include "kern.h"
 #include "chan_kern.h"
 #include "mconsole_kern.h"
-#include "2_5compat.h"
 #include "mem.h"
 #include "mem_kern.h"
 
Index: linux-2.6.11/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.11.orig/fs/hostfs/hostfs_kern.c	2005-05-26 17:16:48.000000000 -0400
+++ linux-2.6.11/fs/hostfs/hostfs_kern.c	2005-05-26 17:17:01.000000000 -0400
@@ -23,7 +23,6 @@
 #include "kern_util.h"
 #include "kern.h"
 #include "user_util.h"
-#include "2_5compat.h"
 #include "init.h"
 
 struct hostfs_inode_info {

