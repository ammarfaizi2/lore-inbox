Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRH2Fez>; Wed, 29 Aug 2001 01:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271909AbRH2Fep>; Wed, 29 Aug 2001 01:34:45 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:60716 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S271906AbRH2Fej>; Wed, 29 Aug 2001 01:34:39 -0400
Subject: Updated Linux 2.4.9/2.4.10 kernel preemption patches
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: cliff@oisec.net, jjs@toyota.com, andy@spylog.ru, nigel@nrg.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 29 Aug 2001 01:35:26 -0400
Message-Id: <999063343.2134.84.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patches are at:
http://tech9.net/rml/linux/patch-rml-2.4.9-ac3-preempt-kernel-1
and,
http://tech9.net/rml/linux/patch-rml-2.4.10-pre2-preempt-kernel-1
for kernels 2.4.9-ac3 and 2.4.10-pre2.

These are updates of Nigel Gamble's kernel preemption patches for recent
kernels.  See http://kpreempt.sourceforge.net/.  These patches create a
configure option to enable a preemptible kernel using SMP lock points.
A preemptible kernel will yield control of execution to higher priority
processes as needed.  Ie, the process timeslice now applies to kernel
space.

Changes since my previous patch:
* update for 2.4.9-ac3 and 2.4.10-pre2
* fix the compile bug (yay!) -- the linking dependency of dec_and_lock
requires CONFIG_HAVE_DEC_LOCK which SMP sets in recent kernels.  now
CONFIG_PREEMPT sets, too

So, yes, this should fix the kernel compile buggy.  At least it did for
me, after I was finally able to reproduce the problem.

Enjoy and please comment, test, and benchmark.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

