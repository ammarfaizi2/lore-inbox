Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSAMRhe>; Sun, 13 Jan 2002 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSAMRhY>; Sun, 13 Jan 2002 12:37:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2948 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286411AbSAMRhR>;
	Sun, 13 Jan 2002 12:37:17 -0500
Date: Sun, 13 Jan 2002 20:34:39 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>
Subject: [patch] O(1) scheduler, -H7
Message-ID: <Pine.LNX.4.33.0201131933500.6560-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -H7 patch is available:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H7.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-H7.patch

there is an important SMP fix in this release, found by Anton Blanchard:
double-spin_unlock()ing triggered oopses on high-end SMP boxes.

stability status: all reported problems were fixed by -H6, the only
problem remaining was Anton's SMP crashes, which should be fixed in this
-H7 patch.

Changes between -H6 and -H7:

- Anton Blanchard: fix double spin_unlock in sched.c. This fixes
  a high-end SMP oops he saw.

- William Lee Irwin III: fix mwave's ->nice code.

- cleanup: mmu_context.h renamed to sched.h, as suggested by
  Richard Henderson.

- added a irqs_enabled() macro to the x86 tree, to simplify irq.c.

Bug reports, comments, suggestions welcome.

	Ingo

