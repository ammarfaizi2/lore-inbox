Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSAXJee>; Thu, 24 Jan 2002 04:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSAXJeX>; Thu, 24 Jan 2002 04:34:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:26891 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286207AbSAXJeJ>;
	Thu, 24 Jan 2002 04:34:09 -0500
Subject: [PATCH] preemptive kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net, george@mvista.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 04:39:00 -0500
Message-Id: <1011865141.867.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch makes the Linux kernel preemptible: higher priority processes
can preempt other lower priority processes, even if they are running in
kernel-mode.

An updated preemptive kernel for 2.5.3-pre4 is available here:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.5/

And for 2.4.8-pre6 (and 2.4.18-pre6 + Ingo's O(1) Scheduler, J5):

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

Most notably, the SMP instabilities under the new scheduler have been
solved.  This version is rock-solid on my testing in both 2.4 and 2.5
under UP and SMP.

Ingo Molnar offered some optimizations, some of which are in this
release and others which I will work on for future releases.

Enjoy,

	Robert love

Changes since 20020113 release:

- rename preempt_is_disabled to preempt_get_count (me)

- remove preempt_prefetch, it does more harm than good (Ingo Molnar)

- optimize preempt_enable (George Anzinger, Ingo Molnar)

- better locking in sched.c (me)

- fix race on fork (Ingo Molnar)

- fix mismatched locking in new O(1) migration code (me)

- use BUG_ON instead of BUG where applicable (me)
  	o for 2.4, add BUG_ON macro

- update Documentation/preempt_locking.txt (me)

- misc clean up (me)

