Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVK3VNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVK3VNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVK3VNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:13:22 -0500
Received: from fmr21.intel.com ([143.183.121.13]:43189 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750744AbVK3VNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:13:21 -0500
Subject: [PATCH] Add VT flag to cpuinfo
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com
Message-Id: <20051130211705.220E9E1486@los-vmm.sc.intel.com>
Date: Wed, 30 Nov 2005 13:17:05 -0800 (PST)
From: donald.d.dugger@intel.com (Donald D Dugger)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew-

Attached is a trivial patch to 2.6 that will add `vt' to the flags field
of `/proc/cpuinfo' for CPUs that have Intel's virtualization technology.

Signed-off-by: Donald D. Dugger <donald.d.dugger@intel.com>

--
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
Donald.D.Dugger@intel.com
Ph: (303)440-1368

diff -Naur linux-2.6.14/arch/i386/kernel/cpu/proc.c linux-2.6.14-ddd/arch/i386/kernel/cpu/proc.c
--- linux-2.6.14/arch/i386/kernel/cpu/proc.c	2005-10-27 18:02:08.000000000 -0600
+++ linux-2.6.14-ddd/arch/i386/kernel/cpu/proc.c	2005-11-14 14:22:52.000000000 -0700
@@ -44,7 +44,7 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
+		"pni", NULL, NULL, "monitor", "ds_cpl", "vt", NULL, "est",
 		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
diff -Naur linux-2.6.14/arch/x86_64/kernel/setup.c linux-2.6.14-ddd/arch/x86_64/kernel/setup.c
--- linux-2.6.14/arch/x86_64/kernel/setup.c	2005-10-27 18:02:08.000000000 -0600
+++ linux-2.6.14-ddd/arch/x86_64/kernel/setup.c	2005-11-11 14:47:59.000000000 -0700
@@ -1213,7 +1213,7 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
+		"pni", NULL, NULL, "monitor", "ds_cpl", "vt", NULL, "est",
 		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
