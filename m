Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIXDaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTIXD3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:29:44 -0400
Received: from dp.samba.org ([66.70.73.150]:12236 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261628AbTIXD3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:29:25 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Re: document unused pte bits on i386
Date: Wed, 24 Sep 2003 12:52:53 +1000
Message-Id: <20030924032924.B3AEB2C491@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Ed L Cashin <ecashin@uga.edu>

  Ed L Cashin <ecashin@uga.edu> writes:
  
  > Hi.  This small patch documents that bits 9, 10, and 11 are unused by
  > the Linux kernel.  The IA-32 Intel Architecture Software Developer's
  > Manual says that these bits are available for programmer use.
  >
  > I checked and couldn't see any use of these bits in the Linux kernel.
  > If I'm wrong and these bits *are* being used by the linux kernel, a
  > comment in include/asm-i386/pgtable.h would be helpful.  If they are
  > not, this patch confirms for developers that the kernel isn't using
  > these bits.
  
  For consistency, there should be the analogous _PAGE_BIT_XXX macros,
  too, so here's a replacement patch that has those.
  
  

--- trivial-2.6.0-test5-bk10/include/asm-i386/pgtable.h.orig	2003-09-24 12:27:18.000000000 +1000
+++ trivial-2.6.0-test5-bk10/include/asm-i386/pgtable.h	2003-09-24 12:27:18.000000000 +1000
@@ -108,6 +108,9 @@
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
+#define _PAGE_BIT_UNUSED1	9	/* available for programmer */
+#define _PAGE_BIT_UNUSED2	10
+#define _PAGE_BIT_UNUSED3	11
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_RW	0x002
@@ -118,6 +121,9 @@
 #define _PAGE_DIRTY	0x040
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
+#define _PAGE_UNUSED1	0x200	/* available for programmer */
+#define _PAGE_UNUSED2	0x400
+#define _PAGE_UNUSED3	0x800
 
 #define _PAGE_FILE	0x040	/* set:pagecache unset:swap */
 #define _PAGE_PROTNONE	0x080	/* If not present */
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Ed L Cashin <ecashin@uga.edu>: Re: [TRIVIAL][PATCH] document unused pte bits on i386
