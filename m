Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310466AbSCBVy6>; Sat, 2 Mar 2002 16:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310465AbSCBVyi>; Sat, 2 Mar 2002 16:54:38 -0500
Received: from zero.tech9.net ([209.61.188.187]:40206 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S310464AbSCBVye>;
	Sat, 2 Mar 2002 16:54:34 -0500
Subject: [PATCH] 2.4: updated preemptive kernel patch
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 02 Mar 2002 16:54:39 -0500
Message-Id: <1015106079.13693.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been awhile since a post since I have been concentrating on
preempt-kernel in 2.5, however 2.4 preempt-kernel work is not stopping. 

Patches for 2.4.18, 2.4.19-pre2, and 2.4.19-pre2-ac2 are available at:

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4

please use a mirror.  Patches for earlier kernel releases are available,
too, but may not be in sync with this release.  Users of Ingo's O(1)
scheduler are encouraged to use Alan's tree as it has O(1) merged. 
Older 2.5 patches are available as well, but preempt-kernel was merged
as of 2.5.4-pre6.

Also available are updated preempt-stats patches (tool for determining
length and cause of preempt-off periods):

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-stats/

for 2.4.18, 2.4.19-pre2, and 2.5.5.

ChangeLog for preempt-kernel:

20020301:

- fix the preempt_count for non-CPU0 idle       (George Anzinger)
  threads

20020210:

- (2.5 only) merge i386 codebase into official	(me, Linus)
- (2.5 only) remove /proc/<pid>/stat code	(me)

20020209:

- (2.5 only) cleanup entry.S			(Linus)
- (2.5 only) remove dependencies on sched.h	(Linus)
- (2.5 only) use current_thread_info()-> not	(Linus)
  current->thread_info->

20020208:

- (2.5 only) use new thread_info struct not the	(me)
  task_struct for preempt_count

20020207:

- barrier in preempt_schedule to enforce	(George Anzinger)
  proper ordering to ensure no missed
  preemptions

ChangeLog for preempt-stats:

20020302:

- make preempt-stats report meaningful stats	(Todd Poynor)
  on SMP
- fix overflow with large latency values on	(Todd Poynor)
  high clock-rate CPUs

20020204:

- accidently removed preempt_schedule export	(Willy Tarreau)
- properly export statistics functions		(Willy Tarreau)

	Robert Love

