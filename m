Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUC3Fh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUC3Fh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:37:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:53141 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263134AbUC3Ffm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:35:42 -0500
Subject: [PATCH] ppc32: Remove duplicate export
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080624934.1213.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:35:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enable_kernel_fp is exported both in ppc_ksyms and near it's
definition in process.c, remove the former.

diff -urN linux-2.5/arch/ppc/kernel/ppc_ksyms.c linuxppc-2.5-benh/arch/ppc/kernel/ppc_ksyms.c
--- linux-2.5/arch/ppc/kernel/ppc_ksyms.c	2004-03-16 10:21:29.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/ppc_ksyms.c	2004-03-30 13:00:44.000000000 +1000
@@ -192,7 +192,6 @@
 
 EXPORT_SYMBOL(flush_instruction_cache);
 EXPORT_SYMBOL(giveup_fpu);
-EXPORT_SYMBOL(enable_kernel_fp);
 EXPORT_SYMBOL(flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
 EXPORT_SYMBOL(flush_icache_user_range);


