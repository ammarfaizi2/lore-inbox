Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUBUEDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUBUEDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:03:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:37804 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261507AbUBUEDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:03:41 -0500
Subject: [PATCH] ppc32: Export cpu_possible_map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077335865.865.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 14:57:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

cpu_possible_map is needed by some modules, export it.

diff -urN linux-2.5/arch/ppc/kernel/smp.c linuxppc-2.5-benh/arch/ppc/kernel/smp.c
--- linux-2.5/arch/ppc/kernel/smp.c	2004-02-21 14:54:41.775963008 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/smp.c	2004-02-21 14:56:33.747940680 +1100
@@ -54,6 +54,7 @@
 struct thread_info *secondary_ti;
 
 EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL(cpu_possible_map);
 
 /* SMP operations for this machine */
 static struct smp_ops_t *smp_ops;


