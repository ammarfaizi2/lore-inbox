Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUB0KtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUB0KtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:49:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:37050 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261784AbUB0Ksy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:48:54 -0500
Subject: [PATCH] ppc64: Fix warning on pmac build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077878400.22397.324.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 21:40:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a stupid warning in PowerMac SMP build on ppc64

diff -urN linux-iommu/arch/ppc64/kernel/pmac_smp.c linux-DART/arch/ppc64/kernel/pmac_smp.c
--- linux-iommu/arch/ppc64/kernel/pmac_smp.c	2004-02-27 14:55:19.000000000 +1100
+++ linux-DART/arch/ppc64/kernel/pmac_smp.c	2004-02-27 15:00:48.000000000 +1100
@@ -57,7 +57,7 @@
 extern void pmac_secondary_start_2(void);
 extern void pmac_secondary_start_3(void);
 
-extern void smp_openpic_message_pass(int target, int msg, unsigned long data, int wait);
+extern void smp_openpic_message_pass(int target, int msg);
 
 extern struct smp_ops_t *smp_ops;
 


