Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUDSN1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUDSN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:26:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11790 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264408AbUDSNVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:21:10 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (H8300)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYhw-00055s-DN@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:21:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** H8300 doesn't seem to have a maintainer ***

This patch cleans up needless includes of asm/pgalloc.h from the
arch/h8300/ subtree.  This has not been compile tested, so
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

===== arch/h8300/kernel/h8300_ksyms.c 1.2 vs edited =====
--- 1.2/arch/h8300/kernel/h8300_ksyms.c	Wed Sep 24 07:15:36 2003
+++ edited/arch/h8300/kernel/h8300_ksyms.c	Mon Apr 19 13:34:39 2004
@@ -10,7 +10,6 @@
 #include <linux/config.h>
 
 #include <asm/setup.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
===== arch/h8300/mm/kmap.c 1.1 vs edited =====
--- 1.1/arch/h8300/mm/kmap.c	Mon Feb 17 00:01:58 2003
+++ edited/arch/h8300/mm/kmap.c	Mon Apr 19 13:34:39 2004
@@ -19,7 +19,6 @@
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
