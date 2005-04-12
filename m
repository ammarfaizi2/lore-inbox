Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVDMAaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVDMAaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVDLUS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:18:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:24008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbVDLKb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:29 -0400
Message-Id: <200504121031.j3CAVIfW005284@shell0.pdx.osdl.net>
Subject: [patch 040/198] ppc32: fix compilation error in include/asm-m68k/setup.h
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benoit.boissinot@ens-lyon.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

make defconfig give the following error on ppc (gcc-4):

include/asm-m68k/setup.h:365: error: array type has incomplete element
type

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-m68k/setup.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/asm-m68k/setup.h~ppc32-fix-compilation-error-in-include-asm-m68k-setuph include/asm-m68k/setup.h
--- 25/include/asm-m68k/setup.h~ppc32-fix-compilation-error-in-include-asm-m68k-setuph	2005-04-12 03:21:12.928171520 -0700
+++ 25-akpm/include/asm-m68k/setup.h	2005-04-12 03:21:12.931171064 -0700
@@ -360,14 +360,14 @@ extern int m68k_is040or060;
 #define COMMAND_LINE_SIZE	CL_SIZE
 
 #ifndef __ASSEMBLY__
-extern int m68k_num_memory;		/* # of memory blocks found (and used) */
-extern int m68k_realnum_memory;		/* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
-
 struct mem_info {
 	unsigned long addr;		/* physical address of memory chunk */
 	unsigned long size;		/* length of memory chunk (in bytes) */
 };
+
+extern int m68k_num_memory;		/* # of memory blocks found (and used) */
+extern int m68k_realnum_memory;		/* real # of memory blocks found */
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 #endif
 
 #endif /* __KERNEL__ */
_
