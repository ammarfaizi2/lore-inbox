Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUBMCpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUBMCpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:45:15 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:22147 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S266687AbUBMCpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:45:07 -0500
Message-ID: <402C3A99.4080308@quark.didntduck.org>
Date: Thu, 12 Feb 2004 21:46:49 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Module headers cleanup
Content-Type: multipart/mixed;
 boundary="------------050708090002080607000100"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708090002080607000100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Cleans up some leftovers from the old module loader:
- Remove unused defines from modules.h
- Remove unused file modsetver.h

--
				Brian Gerst

--------------050708090002080607000100
Content-Type: text/plain;
 name="modules-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules-1"

diff -urN linux-2.6.2-bk/include/asm-arm26/module.h linux/include/asm-arm26/module.h
--- linux-2.6.2-bk/include/asm-arm26/module.h	2003-12-17 21:58:57.000000000 -0500
+++ linux/include/asm-arm26/module.h	2004-02-09 15:20:45.000000000 -0500
@@ -4,9 +4,4 @@
  * This file contains the arm architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
-
 #endif /* _ASM_ARM_MODULE_H */
diff -urN linux-2.6.2-bk/include/asm-h8300/module.h linux/include/asm-h8300/module.h
--- linux-2.6.2-bk/include/asm-h8300/module.h	2003-12-17 21:58:16.000000000 -0500
+++ linux/include/asm-h8300/module.h	2004-02-09 15:20:50.000000000 -0500
@@ -4,9 +4,4 @@
  * This file contains the H8/300 architecture specific module code.
  */
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
-
 #endif /* _ASM_H8/300_MODULE_H */
diff -urN linux-2.6.2-bk/include/asm-parisc/module.h linux/include/asm-parisc/module.h
--- linux-2.6.2-bk/include/asm-parisc/module.h	2003-12-17 21:58:16.000000000 -0500
+++ linux/include/asm-parisc/module.h	2004-02-09 15:20:54.000000000 -0500
@@ -17,11 +17,6 @@
 #define Elf_Rela Elf32_Rela
 #endif
 
-#define module_map(x)		vmalloc(x)
-#define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
-#define arch_init_modules(x)	do { } while (0)
-
 struct mod_arch_specific
 {
 	unsigned long got_offset, got_count, got_max;
diff -urN linux-2.6.2-bk/include/linux/modsetver.h linux/include/linux/modsetver.h
--- linux-2.6.2-bk/include/linux/modsetver.h	2003-12-17 21:58:49.000000000 -0500
+++ linux/include/linux/modsetver.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,10 +0,0 @@
-/* Symbol versioning nastiness.  */
-
-#define __SYMBOL_VERSION(x)       __ver_ ## x
-#define __VERSIONED_SYMBOL2(x,v)  x ## _R ## v
-#define __VERSIONED_SYMBOL1(x,v)  __VERSIONED_SYMBOL2(x,v)
-#define __VERSIONED_SYMBOL(x)     __VERSIONED_SYMBOL1(x,__SYMBOL_VERSION(x))
-
-#ifndef _set_ver
-#define _set_ver(x)		  __VERSIONED_SYMBOL(x)
-#endif

--------------050708090002080607000100--
