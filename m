Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSHSBcK>; Sun, 18 Aug 2002 21:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHSBcK>; Sun, 18 Aug 2002 21:32:10 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:53522 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316615AbSHSBcJ>;
	Sun, 18 Aug 2002 21:32:09 -0400
Date: Sun, 18 Aug 2002 21:28:04 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.31 : include/asm/a.out.h 
Message-ID: <Pine.LNX.4.44.0208182120560.861-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patches are related to the addition of the 
include/asm-generic/a.out.h . Archs ia64, m68k, mips64, parisc, 
ppc64 are included. Please review.

Regards,
Frank

--- include/asm-ia64/a.out.h.old	Mon Mar 18 19:32:06 2002
+++ include/asm-ia64/a.out.h	Thu Aug  8 21:52:32 2002
@@ -12,14 +12,7 @@
  */
 
 #include <linux/types.h>
-
-struct exec {
-	unsigned long a_info;
-	unsigned long a_text;
-	unsigned long a_data;
-	unsigned long a_bss;
-	unsigned long a_entry;
-};
+#include <asm-generic/a.out.h>
 
 #define N_TXTADDR(x)	0
 #define N_DATADDR(x)	0

--- include/asm-m68k/a.out.h.old	Wed Dec 27 15:46:42 1995
+++ include/asm-m68k/a.out.h	Thu Aug  8 22:03:01 2002
@@ -1,21 +1,7 @@
 #ifndef __M68K_A_OUT_H__
 #define __M68K_A_OUT_H__
 
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
+#include <asm-generic/a.out.h>
 
 #ifdef __KERNEL__
 
--- include/asm-mips64/a.out.h.old	Sun Sep 30 20:40:07 2001
+++ include/asm-mips64/a.out.h	Thu Aug  8 22:59:07 2002
@@ -8,21 +8,7 @@
 #ifndef _ASM_A_OUT_H
 #define _ASM_A_OUT_H
 
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
+#include <asm-generic/a.out.h>
 
 #ifdef __KERNEL__
 

--- include/asm-parisc/a.out.h.old	Tue Dec  5 15:29:39 2000
+++ include/asm-parisc/a.out.h	Thu Aug  8 23:00:24 2002
@@ -1,21 +1,7 @@
 #ifndef __PARISC_A_OUT_H__
 #define __PARISC_A_OUT_H__
 
-struct exec
-{
-  unsigned int a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
+#include <asm-generic/a.out.h>
 
 #ifdef __KERNEL__
 

--- include/asm-ppc64/a.out.h.old	Wed Feb 20 19:46:23 2002
+++ include/asm-ppc64/a.out.h	Thu Aug  8 23:02:43 2002
@@ -11,22 +11,8 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include <asm-generic/a.out.h>
 
-struct exec
-{
-	unsigned long a_info;	/* Use macros N_MAGIC, etc for access */
-	unsigned a_text;	/* length of text, in bytes */
-	unsigned a_data;	/* length of data, in bytes */
-	unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-	unsigned a_syms;	/* length of symbol table data in file, in bytes */
-	unsigned a_entry;	/* start address */
-	unsigned a_trsize;	/* length of relocation info for text, in bytes */
-	unsigned a_drsize;	/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
 
 #ifdef __KERNEL__
 

