Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278114AbRJLUTZ>; Fri, 12 Oct 2001 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278115AbRJLUTQ>; Fri, 12 Oct 2001 16:19:16 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:54564 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S278114AbRJLUTB>; Fri, 12 Oct 2001 16:19:01 -0400
Subject: Updated preempt-kernel patches
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 12 Oct 2001 16:19:36 -0400
Message-Id: <1002917978.957.86.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated preempt-kernel patches for 2.4.10, 2.4.12, 2.4.13-pre1, and
(phew!) 2.4.12-ac1 are available at:

http://tech9.net/rml/linux

Note the patches for 2.4.10 are updated over previously releases.

These patches allow create a preemptible kernel -- increasing system
response time.  Everyone is encouraged to give it a whirl and report
back.

Major changes include code to prevent CPU changes on preempt (should
prevent a class of race conditions), an SMP compile fix, and various
cleanups.

Full change log:

20011011
- remove pgalloc.h preemption disable statements -- not
  needed with the new CPU switch prevention
- fix compile on SMP in some configurations (ac tree only)

20011005
- rearrange sched.c so we can patch cleanly against rtsched
  (or vice versa)

20011004
- prevent the case of preemption causing a CPU switch
  by locking tasks to the current CPU in preempt_schedule
- revert to _raw_spin_xxx from _spin_xxx since PPC uses
  that convention.

20011003
- push pcmcia-cs tools fix into their next release

20011001
- fix spin_lock_prefetch optimization causing (harmless)
  compile warnings

	Robert Love

