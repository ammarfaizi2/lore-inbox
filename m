Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310291AbSCGLvj>; Thu, 7 Mar 2002 06:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310285AbSCGLve>; Thu, 7 Mar 2002 06:51:34 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:12931 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310289AbSCGLvQ>; Thu, 7 Mar 2002 06:51:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 7 Mar 2002 03:51:14 -0800
Message-Id: <200203071151.DAA12917@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.6-pre3 calls release_kernel_lock without holding lock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	When I boot an SMP linux-2.5.6-pre3 on a uniprocessor x86, I
consistently get a kernel panic at boot when the release_kernel_lock()
call at line 760 of kernel/sched.c apparently attempts to release
its kernel lock without holding it.  I believe that this happens
when the kernel makes the first thread, but I'm not sure.

	2.5.6-pre2 did not have this problem.

	Just to rule out one thought that some of you may have about this,
I should mention that I am aware that the stock kernel now runs the
child of a fork() first (at least according to the comments in
kernel/fork.c), and I removed my run-child-first code some time ago.
So, that change is not the cause of this problem.

	I will post a follow-up if I am able to diagnose this problem,
but I think I'm going to sleep now, so I thought I ought to mention this.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
