Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbREBLMZ>; Wed, 2 May 2001 07:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbREBLMQ>; Wed, 2 May 2001 07:12:16 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:56269 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S131949AbREBLMH>; Wed, 2 May 2001 07:12:07 -0400
Message-Id: <m14uubp-001QJTC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: alan@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel locking guide fix.
Date: Wed, 02 May 2001 21:15:53 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN -I \$.*\$ -X /tmp/kerndiff.hKrYxB --minimal linux-2.4.4-official/Documentation/DocBook/kernel-locking.tmpl working-2.4.4-rcu/Documentation/DocBook/kernel-locking.tmpl
--- linux-2.4.4-official/Documentation/DocBook/kernel-locking.tmpl	Tue May  1 12:26:15 2001
+++ working-2.4.4-rcu/Documentation/DocBook/kernel-locking.tmpl	Wed May  2 21:14:19 2001
@@ -760,8 +760,11 @@
     </para>
 
     <para>
-      Any atomic operation is defined to act as a memory barrier
-      (ie. as per the <function>mb()</function> macro).  Also,
+      Some atomic operations are defined to act as a memory barrier
+      (ie. as per the <function>mb()</function> macro, but if in
+      doubt, be explicit.
+      <!-- Rusty Russell 2 May 2001, 2.4.4 -->
+      Also,
       spinlock operations act as partial barriers: operations after
       gaining a spinlock will never be moved to precede the
       <function>spin_lock()</function> call, and operations before

--
Premature optmztion is rt of all evl. --DK
