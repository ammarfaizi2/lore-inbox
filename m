Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbTHGPXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270359AbTHGPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:23:47 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:25731 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S270328AbTHGPXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:23:36 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: trivial <trivial@rustcorp.com.au>
Subject: [TRIVIAL][PATCH] document unused pte bits on i386
From: Ed L Cashin <ecashin@uga.edu>
Date: Thu, 07 Aug 2003 11:23:34 -0400
Message-ID: <87n0elwky1.fsf@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  This small patch documents that bits 9, 10, and 11 are unused by
the Linux kernel.  The IA-32 Intel Architecture Software Developer's
Manual says that these bits are available for programmer use.

I checked and couldn't see any use of these bits in the Linux kernel.
If I'm wrong and these bits *are* being used by the linux kernel, a
comment in include/asm-i386/pgtable.h would be helpful.  If they are
not, this patch confirms for developers that the kernel isn't using
these bits.


--- linux-2.6.0-test2/include/asm-i386/pgtable.h~	Sun Jul 27 13:06:27 2003
+++ linux-2.6.0-test2/include/asm-i386/pgtable.h	Thu Aug  7 11:16:36 2003
@@ -118,6 +118,9 @@
 #define _PAGE_DIRTY	0x040
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
+#define _PAGE_UNUSED1	0x200	/* available for programmer */
+#define _PAGE_UNUSED2	0x400
+#define _PAGE_UNUSED3	0x800
 
 #define _PAGE_FILE	0x040	/* set:pagecache unset:swap */
 #define _PAGE_PROTNONE	0x080	/* If not present */


-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

