Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTIXXGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 19:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbTIXXGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 19:06:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19384 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261535AbTIXXGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 19:06:45 -0400
Subject: [PATCH] linux-2.6.0-test5_nrcpus-limit-typo_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064444596.3864.404.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Sep 2003 16:03:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, all,
	This patch fixes a printk formatting typo("0x%d" should be "0x%x")
noticed by James Cleverdon. 

Please consider for inclusion.

thanks
-john

===== arch/i386/kernel/mpparse.c 1.50 vs edited =====
--- 1.50/arch/i386/kernel/mpparse.c	Tue Sep  9 23:41:39 2003
+++ edited/arch/i386/kernel/mpparse.c	Wed Sep 24 15:58:33 2003
@@ -169,7 +169,7 @@
 
 	if (num_processors >= NR_CPUS) {
 		printk(KERN_WARNING "NR_CPUS limit of %i reached.  Cannot "
-			"boot CPU(apicid 0x%d).\n", NR_CPUS, m->mpc_apicid);
+			"boot CPU(apicid 0x%x).\n", NR_CPUS, m->mpc_apicid);
 		return;
 	}
 	num_processors++;



