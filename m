Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRDDST5>; Wed, 4 Apr 2001 14:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRDDSTr>; Wed, 4 Apr 2001 14:19:47 -0400
Received: from palrel1.hp.com ([156.153.255.242]:59659 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129292AbRDDSTg>;
	Wed, 4 Apr 2001 14:19:36 -0400
From: Scott Rhine <rhine@rsn.hp.com>
Message-Id: <200104041818.NAA25008@hueco-e.rsn.hp.com>
Subject: [Lse-tech] HP Plug In Policies vs Multiqueue Scheduler (fwd)
To: linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2001 13:18:48 CDT
X-Mailer: Elm [revision: 111.1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a little cross talk lately about the "HP" schedulers that
may be sowing some confusion.

1) Pluggable policies provides a minimally intrusive way to develop and
   test new scheduler policies such as Processor Sets, or the Fair Share
   Scheduler.  It provides a good way to test a theory without rebooting.
   (Linus said that this approach was useful for experiments but was too 
    dangerous to allow in the main line kernel. sigh. We're still working on a
    way to get *some* flexibility via goodness, etc.)

2) The Multi-queue approach I put on our web site is not pluggable, because
   the prototype didn't generate enough interest or performance improvement.
   It was an academic exercise showing what I considered the minimum change 
   necessary.  It took about two days to code and measure the revised scaling.
   Consider it the opening volley of a group discussion, not a finished product.

3) the cpu stealing rules try to mimic those for a earlier kernel for an i386
   architecture.  Due to the ~20 penalty, stealing was not mathematically 
   possible between cpus until everything with preference for that CPU has 
   reached 0 count.  When one queue is empty, I try to emulate the single 
   queue behavior and pick the best job from all queues.  This was for 
   simplicity and compatibility, not fairness or speed.

What they say is true, there is no such thing as bad publicity.  I've had more
MQ downloads this week than I did when they were new.
