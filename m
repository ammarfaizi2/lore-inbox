Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273972AbRISAJv>; Tue, 18 Sep 2001 20:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273973AbRISAJc>; Tue, 18 Sep 2001 20:09:32 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:23100 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273972AbRISAJM>; Tue, 18 Sep 2001 20:09:12 -0400
Subject: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 18 Sep 2001 20:10:39 -0400
Message-Id: <1000858241.832.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables a preemptible kernel - now userspace programs can be
preempted, even if in kernel land.  This should result in greater system
response.

Updated patches are available at:
http://tech9.net/rml/linux/patch-rml-2.4.9-ac12-preempt-kernel-1 and
http://tech9.net/rml/linux/patch-rml-2.4.10-pre11-preempt-kernel-1
for 2.4.9-ac12 and 2.4.10-pre11, respectively.

ChangeLog is at http://tech9.net/rml/linux/changelog-preempt

The Athlon-optimized problem is fixed and a final solution is merged.

We have had reported success with XFS, although a patch is required to
compile, available at
http://tech9.net/rml/linux/other/patch-rml-2.4.10-pre10-xfs-preempt-fix-1

Finally, I have gotten great feedback from SMP users -- both in that "it
works" and that benchmarks show an improvement.  Thus, SMP and
preemption together are no longer marked experimental.

The only outstanding issue is a possible issue with ReiserFS, although I
am beginning to think this is attributed to VM muck and not ReiserFS. 
If you use ReiserFS, I would appreciate some feedback. (Note that the
issue is _not_ fs corruption or anything of the ilk, just odd syslog
messages and the such).

Please continue to supply feedback and relevant benchmarks.  I really
encourage "regular" users to try this out -- patch your kernel and
enable CONFIG_PREEMPT.  I am not an audio guy, trust me -- this is worth
it for any desktop.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

