Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbTGROso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbTGROso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:48:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30085
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271800AbTGROKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:10:34 -0400
Date: Fri, 18 Jul 2003 15:24:54 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181424.h6IEOsf5017813@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix a doc error and misleading printk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/kernel/sched.c linux-2.6.0-test1-ac2/kernel/sched.c
--- linux-2.6.0-test1/kernel/sched.c	2003-07-14 14:11:57.000000000 +0100
+++ linux-2.6.0-test1-ac2/kernel/sched.c	2003-07-15 18:01:30.000000000 +0100
@@ -2080,7 +2080,7 @@
 }
 
 /**
- * sys_sched_get_priority_mix - return minimum RT priority.
+ * sys_sched_get_priority_min - return minimum RT priority.
  * @policy: scheduling class.
  *
  * this syscall returns the minimum rt_priority that can be used
@@ -2541,7 +2541,7 @@
 		if (time_before(jiffies, prev_jiffy + HZ))
 			return;
 		prev_jiffy = jiffies;
-		printk(KERN_ERR "Debug: sleeping function called from illegal"
+		printk(KERN_ERR "Debug: sleeping function called from invalid"
 				" context at %s:%d\n", file, line);
 		dump_stack();
 	}
