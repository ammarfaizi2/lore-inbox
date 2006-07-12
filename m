Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWGLQkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWGLQkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWGLQkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:40:23 -0400
Received: from [198.99.130.12] ([198.99.130.12]:9623 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751354AbWGLQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:40:07 -0400
Message-Id: <200607121640.k6CGe94f021241@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/5] UML - Header formatting cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 12:40:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up whitespace and return syntax in os.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/os.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/os.h	2006-07-12 11:26:41.000000000 -0400
+++ linux-2.6.17/arch/um/include/os.h	2006-07-12 12:04:42.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -15,9 +15,9 @@
 #include "irq_user.h"
 #include "sysdep/tls.h"
 
-#define OS_TYPE_FILE 1 
-#define OS_TYPE_DIR 2 
-#define OS_TYPE_SYMLINK 3 
+#define OS_TYPE_FILE 1
+#define OS_TYPE_DIR 2
+#define OS_TYPE_SYMLINK 3
 #define OS_TYPE_CHARDEV 4
 #define OS_TYPE_BLOCKDEV 5
 #define OS_TYPE_FIFO 6
@@ -61,68 +61,68 @@ struct openflags {
 };
 
 #define OPENFLAGS() ((struct openflags) { .r = 0, .w = 0, .s = 0, .c = 0, \
- 					  .t = 0, .a = 0, .e = 0, .cl = 0 })
+					  .t = 0, .a = 0, .e = 0, .cl = 0 })
 
 static inline struct openflags of_read(struct openflags flags)
 {
-	flags.r = 1; 
-	return(flags);
+	flags.r = 1;
+	return flags;
 }
 
 static inline struct openflags of_write(struct openflags flags)
 {
-	flags.w = 1; 
-	return(flags); 
+	flags.w = 1;
+	return flags;
 }
 
 static inline struct openflags of_rdwr(struct openflags flags)
 {
-	return(of_read(of_write(flags)));
+	return of_read(of_write(flags));
 }
 
 static inline struct openflags of_set_rw(struct openflags flags, int r, int w)
 {
 	flags.r = r;
 	flags.w = w;
-	return(flags);
+	return flags;
 }
 
 static inline struct openflags of_sync(struct openflags flags)
-{ 
-	flags.s = 1; 
-	return(flags); 
+{
+	flags.s = 1;
+	return flags;
 }
 
 static inline struct openflags of_create(struct openflags flags)
-{ 
-	flags.c = 1; 
-	return(flags); 
+{
+	flags.c = 1;
+	return flags;
 }
- 
+
 static inline struct openflags of_trunc(struct openflags flags)
-{ 
-	flags.t = 1; 
-	return(flags); 
+{
+	flags.t = 1;
+	return flags;
 }
- 
+
 static inline struct openflags of_append(struct openflags flags)
-{ 
-	flags.a = 1; 
-	return(flags); 
+{
+	flags.a = 1;
+	return flags;
 }
- 
+
 static inline struct openflags of_excl(struct openflags flags)
-{ 
-	flags.e = 1; 
-	return(flags); 
+{
+	flags.e = 1;
+	return flags;
 }
 
 static inline struct openflags of_cloexec(struct openflags flags)
-{ 
-	flags.cl = 1; 
-	return(flags); 
+{
+	flags.cl = 1;
+	return flags;
 }
-  
+
 /* file.c */
 extern int os_stat_file(const char *file_name, struct uml_stat *buf);
 extern int os_stat_fd(const int fd, struct uml_stat *buf);
@@ -204,7 +204,7 @@ extern int run_kernel_thread(int (*fn)(v
 
 extern int os_map_memory(void *virt, int fd, unsigned long long off,
 			 unsigned long len, int r, int w, int x);
-extern int os_protect_memory(void *addr, unsigned long len, 
+extern int os_protect_memory(void *addr, unsigned long len,
 			     int r, int w, int x);
 extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);

