Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTDGXgo (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbTDGXey (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:34:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6273
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263807AbTDGXOX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:14:23 -0400
Date: Tue, 8 Apr 2003 01:33:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080033.h380XGuJ009206@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: x86-64 typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-x86_64/byteorder.h linux-2.5.67-ac1/include/asm-x86_64/byteorder.h
--- linux-2.5.67/include/asm-x86_64/byteorder.h	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-x86_64/byteorder.h	2003-04-03 23:51:08.000000000 +0100
@@ -17,7 +17,7 @@
 	return x;
 }
 
-/* Do not define swab16.  Gcc is smart enought to recognize "C" version and
+/* Do not define swab16.  Gcc is smart enough to recognize "C" version and
    convert it into rotation or exhange.  */
 
 #define __arch__swab32(x) ___arch__swab32(x)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-x86_64/fixmap.h linux-2.5.67-ac1/include/asm-x86_64/fixmap.h
--- linux-2.5.67/include/asm-x86_64/fixmap.h	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-x86_64/fixmap.h	2003-04-03 23:51:08.000000000 +0100
@@ -66,7 +66,7 @@
 
 /*
  * 'index to address' translation. If anyone tries to use the idx
- * directly without tranlation, we catch the bug with a NULL-deference
+ * directly without translation, we catch the bug with a NULL-deference
  * kernel oops. Illegal ranges of incoming indices are caught too.
  */
 extern inline unsigned long fix_to_virt(const unsigned int idx)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-x86_64/mmzone.h linux-2.5.67-ac1/include/asm-x86_64/mmzone.h
--- linux-2.5.67/include/asm-x86_64/mmzone.h	2003-02-15 03:39:34.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-x86_64/mmzone.h	2003-04-03 23:51:08.000000000 +0100
@@ -1,6 +1,6 @@
 /* K8 NUMA support */
 /* Copyright 2002,2003 by Andi Kleen, SuSE Labs */
-/* 2.5 Version losely based on the NUMAQ Code by Pat Gaughen. */
+/* 2.5 Version loosely based on the NUMAQ Code by Pat Gaughen. */
 #ifndef _ASM_X86_64_MMZONE_H
 #define _ASM_X86_64_MMZONE_H 1
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-x86_64/rwsem.h linux-2.5.67-ac1/include/asm-x86_64/rwsem.h
--- linux-2.5.67/include/asm-x86_64/rwsem.h	2003-03-06 17:04:37.000000000 +0000
+++ linux-2.5.67-ac1/include/asm-x86_64/rwsem.h	2003-04-03 23:51:08.000000000 +0100
@@ -26,7 +26,7 @@
  * This should be totally fair - if anything is waiting, a process that wants a
  * lock will go to the back of the queue. When the currently active lock is
  * released, if there's a writer at the front of the queue, then that and only
- * that will be woken up; if there's a bunch of consequtive readers at the
+ * that will be woken up; if there's a bunch of consecutive readers at the
  * front, then they'll all be woken up, but no other readers will be.
  */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/asm-x86_64/system.h linux-2.5.67-ac1/include/asm-x86_64/system.h
--- linux-2.5.67/include/asm-x86_64/system.h	2003-04-08 00:37:39.000000000 +0100
+++ linux-2.5.67-ac1/include/asm-x86_64/system.h	2003-04-03 23:51:08.000000000 +0100
@@ -40,7 +40,7 @@
 /* It would be more efficient to let the compiler clobber most of these registers.
    Clobbering all is not possible because that lets reload freak out. Even just 
    clobbering six generates wrong code with gcc 3.1 for me so do it this way for now.
-   rbp needs to be always explicitely saved because gcc cannot clobber the
+   rbp needs to be always explicitly saved because gcc cannot clobber the
    frame pointer and the scheduler is compiled with frame pointers. -AK */
 #define SAVE_CONTEXT \
 	__PUSH(rsi) __PUSH(rdi) \
