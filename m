Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312416AbSCURV5>; Thu, 21 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312419AbSCURVs>; Thu, 21 Mar 2002 12:21:48 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:9347 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312408AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [10/10]
Message-Id: <E16o6CB-0005OQ-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update to get the Alpha in sync with i386.

-Chris


--- linux-2.5.7/arch/alpha/vmlinux.lds.in~	Mon Mar 18 15:37:02 2002
+++ linux-2.5.7/arch/alpha/vmlinux.lds.in	Thu Mar 21 05:37:10 2002
@@ -57,6 +57,12 @@
 	__initcall_end = .;
   }
 
+  .data.percpu ALIGN(32): {
+	__per_cpu_start = .;
+	*(.data.percpu)
+	__per_cpu_end = .;
+  }
+
   /* The initial task and kernel stack */
   .data.init_thread ALIGN(2*8192) : {
 	__init_end = .;
