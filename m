Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUDHEGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 00:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUDHEGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 00:06:49 -0400
Received: from ozlabs.org ([203.10.76.45]:40425 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261563AbUDHEGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 00:06:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16500.53157.593547.747353@cargo.ozlabs.ibm.com>
Date: Thu, 8 Apr 2004 14:05:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Julie DeWandel <jdewand@redhat.com>
Subject: [PATCH] export itLpNaca on iSeries
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch from Julie DeWandel exports the symbol itLpNaca on iSeries
machines, for the use of the viodasd driver.

Please apply.

Thanks,
Paul.

--- linux-2.6/arch/ppc64/kernel/ppc_ksyms.c.orig	2004-03-17 08:54:00.000000000 -0500
+++ linux-2.6/arch/ppc64/kernel/ppc_ksyms.c	2004-04-06 09:23:28.000000000 -0400
@@ -42,6 +42,7 @@
 #include <asm/cacheflush.h>
 #ifdef CONFIG_PPC_ISERIES
 #include <asm/iSeries/HvCallSc.h>
+#include <asm/iSeries/LparData.h>
 #endif
 
 extern int do_signal(sigset_t *, struct pt_regs *);
@@ -71,6 +72,9 @@ EXPORT_SYMBOL(__down_interruptible);
 EXPORT_SYMBOL(__up);
 EXPORT_SYMBOL(naca);
 EXPORT_SYMBOL(__down);
+#ifdef CONFIG_PPC_ISERIES
+EXPORT_SYMBOL(itLpNaca);
+#endif
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
