Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbUDSN1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUDSN1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:27:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14350 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264413AbUDSNVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:21:42 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (m68knommu)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYiR-000561-RU@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:21:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** m68knommu does not appear to have a maintainer listed ***

This patch cleans up needless includes of asm/pgalloc.h from the
arch/m68knommu/ subtree.  This has not been compile tested, so
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

===== arch/m68knommu/kernel/m68k_ksyms.c 1.3 vs edited =====
--- 1.3/arch/m68knommu/kernel/m68k_ksyms.c	Mon Mar 31 23:29:49 2003
+++ edited/arch/m68knommu/kernel/m68k_ksyms.c	Mon Apr 19 13:37:30 2004
@@ -11,7 +11,6 @@
 
 #include <asm/setup.h>
 #include <asm/machdep.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
===== arch/m68knommu/mm/kmap.c 1.1 vs edited =====
--- 1.1/arch/m68knommu/mm/kmap.c	Fri Nov  1 15:19:55 2002
+++ edited/arch/m68knommu/mm/kmap.c	Mon Apr 19 13:37:30 2004
@@ -16,7 +16,6 @@
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
