Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRIFWCK>; Thu, 6 Sep 2001 18:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRIFWCA>; Thu, 6 Sep 2001 18:02:00 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:1321 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S267534AbRIFWBn>; Thu, 6 Sep 2001 18:01:43 -0400
Subject: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 06 Sep 2001 18:02:06 -0400
Message-Id: <999813729.2039.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at (about 29K):

http://tech9.net/rml/linux/patch-rml-2.4.10-pre4-preempt-kernel-1
http://tech9.net/rml/linux/patch-rml-2.4.9-ac9-preempt-kernel-1

for kernel 2.4.10-pre4 and 2.4.9-ac9, respectively.

Changes since previous post:
* update for new kernels
* fix newline/space format buglet

Changes since original patch:
* fix compile bug -- CONFIG_HAVE_DEC_LOCK is set as needed, now.

This patch allows a new config setting, CONFIG_PREEMPT (set in
`Processor Type and Features') that enables a fully preemptible kernel. 
Preemption is controled via SMP lock points.  Control of execution is
yielded to higher processes even if the currently running process is in
kernel space.

This should increase response and decrease latency, and is a highly
recommended patch for real-time, audio, and embedded systems.  However,
it is recommended for anyone.  I use it on my everyday workstation.

An interesting new article on a preemptible kernel in linux is available
at:

http://www.linuxdevices.com/articles/AT5152980814.html

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

