Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUDSNdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUDSN2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:28:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19214 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264417AbUDSNWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:22:14 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (ppc)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYiw-00056A-Qw@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:22:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/ppc/ subtree.  This has not been compile tested, so
needs the architecture maintainers (or willing volunteers) to
test.

Please ensure that at least the first two patches have already
been applied to your tree; they can be found at:

	http://lkml.org/lkml/2004/4/18/86
	http://lkml.org/lkml/2004/4/18/87

This patch is part of a larger patch aiming towards getting the
include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
can sanely get at things like mm_struct and friends.

In the event that any of these files fails to build, chances are
you need to include some other header file rather than pgalloc.h.
Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
or asm/tlbflush.h.

===== arch/ppc/mm/44x_mmu.c 1.3 vs edited =====
--- 1.3/arch/ppc/mm/44x_mmu.c	Fri Feb 13 15:24:55 2004
+++ edited/arch/ppc/mm/44x_mmu.c	Mon Apr 19 13:40:33 2004
@@ -42,7 +42,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
===== arch/ppc/mm/4xx_mmu.c 1.7 vs edited =====
--- 1.7/arch/ppc/mm/4xx_mmu.c	Fri Sep 12 17:26:52 2003
+++ edited/arch/ppc/mm/4xx_mmu.c	Mon Apr 19 13:40:33 2004
@@ -39,7 +39,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
===== arch/ppc/mm/cachemap.c 1.14 vs edited =====
--- 1.14/arch/ppc/mm/cachemap.c	Thu Apr  1 20:45:32 2004
+++ edited/arch/ppc/mm/cachemap.c	Mon Apr 19 13:40:33 2004
@@ -37,7 +37,6 @@
 #include <linux/highmem.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/hardirq.h>
===== arch/ppc/mm/init.c 1.34 vs edited =====
--- 1.34/arch/ppc/mm/init.c	Thu Feb  5 05:11:47 2004
+++ edited/arch/ppc/mm/init.c	Mon Apr 19 13:40:33 2004
@@ -32,7 +32,6 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
