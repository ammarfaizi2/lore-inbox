Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUDSNdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUDSNbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:31:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25358 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264425AbUDSNXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:23:13 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       uclinux-v850@lsi.nec.co.jp
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (v850)
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Message-Id: <E1BFYju-00056S-Is@dyn-67.arm.linux.org.uk>
Date: Mon, 19 Apr 2004 14:23:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/v850/ subtree.  This has not been compile tested, so
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

===== arch/v850/kernel/signal.c 1.8 vs edited =====
--- 1.8/arch/v850/kernel/signal.c	Tue Feb 18 02:41:09 2003
+++ edited/arch/v850/kernel/signal.c	Mon Apr 19 13:45:30 2004
@@ -31,7 +31,6 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/thread_info.h>
 #include <asm/cacheflush.h>
 
===== arch/v850/kernel/v850_ksyms.c 1.4 vs edited =====
--- 1.4/arch/v850/kernel/v850_ksyms.c	Fri Jul 25 03:24:25 2003
+++ edited/arch/v850/kernel/v850_ksyms.c	Mon Apr 19 13:45:30 2004
@@ -9,7 +9,6 @@
 #include <linux/interrupt.h>
 #include <linux/config.h>
 
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
