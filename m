Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbTCGG6u>; Fri, 7 Mar 2003 01:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbTCGG6u>; Fri, 7 Mar 2003 01:58:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:42128 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261404AbTCGG6t>; Fri, 7 Mar 2003 01:58:49 -0500
Date: Thu, 06 Mar 2003 23:09:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix NUMA scheduler problem after interactivity merge
Message-ID: <316310000.1047020960@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NODE_THRESHOLD got accidentally dropped in the interactive scheduler
changes merge. This puts it back.

Please apply,

M.

--- 2.5.64-bk/kernel/sched.c.old	2003-03-06 22:22:43.000000000 -0800
+++ 2.5.64-bk/kernel/sched.c	2003-03-06 22:23:41.000000000 -0800
@@ -67,6 +67,7 @@
 #define INTERACTIVE_DELTA	2
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
+#define NODE_THRESHOLD		125
 
 /*
  * If a task is 'interactive' then we reinsert it in the active



