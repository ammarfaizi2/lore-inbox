Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288225AbSAMW3H>; Sun, 13 Jan 2002 17:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288231AbSAMW26>; Sun, 13 Jan 2002 17:28:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:24594 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288225AbSAMW2n>;
	Sun, 13 Jan 2002 17:28:43 -0500
Subject: [PATCH] update: preemptive kernel for O(1) sched
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: george@mvista.com, kpreempt-tech@lists.sourceforge.net, mingo@elte.hu,
        torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 17:31:41 -0500
Message-Id: <1010961108.814.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update of the fully preemptible kernel patch for use with
Ingo Molnar's O(1) scheduler.

A few users reported oopses which I hope this update will address. 
George Anzinger and I also worked in some optimizations, most notably to
preempt_schedule.  More to come.

An updated preempt-kernel for 2.5.2-pre11:
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.5/preempt-kernel-rml-2.5.2-pre11-2.patch

An updated preempt-kernel for 2.4.18-pre3 + O1-H7:
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/ingo-O1-sched/preempt-kernel-rml-2.4.18-pre3-ingo-2.patch

Again, the 2.5 patch is for use with the stock version of Ingo's
scheduler.  Updates to his scheduler (H7, etc.) will be addressed as
they are merged.  Likewise, the 2.4 patch is for H7 only.  Other
versions are use-at-your-own-risk.

Any outstanding bugs please report.  Comments, patches, etc. welcome.

Full ChangeLog:

- more preempt-safe work for new scheduling functions

- mark PREEMPT_ACTIVE jump in schedule unlikely

- optimize preempt_schedule

- change value of PREEMPT_ACTIVE (0x40000000=>0x400000)

- (2.5 only) report preempt_count in /proc/pid/stat

- more comments

	Robert Love

