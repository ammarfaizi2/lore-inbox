Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289825AbSAPC4q>; Tue, 15 Jan 2002 21:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289829AbSAPC41>; Tue, 15 Jan 2002 21:56:27 -0500
Received: from zero.tech9.net ([209.61.188.187]:25352 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289825AbSAPC4V>;
	Tue, 15 Jan 2002 21:56:21 -0500
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, Ed Tomlinson <tomlins@cam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.40.0201151803020.940-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201151803020.940-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 21:59:38 -0500
Message-Id: <1011149980.8756.180.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 21:04, Davide Libenzi wrote:

> On 15 Jan 2002, Robert Love wrote:
> > This isn't a bad idea, as long as we don't use it as a crutch or
> > excuse.  That is, answer scheduling problems with "properly nice your
> > tasks" -- the scheduler should be smart enough, to some degree.
> >
> > FWIW, Solaris actually implements a completely different scheduling
> > policy, SCHED_INTERACT or something.  It is for windowed tasks in X --
> > they get a large interactivity bonus.

> Now ( with 2.5.3-pre1 ) intractivity is *very good* but SCHED_INTERACT
> would help *a lot* to get things even more right.

I looked it up; its called class IA.  I don't know if it grows from a
limitation of their scheduler (i.e. they can't calculate priority and be
as fair to interactive tasks as us) or if it offers a fundamental
advantage.  I suspect their are a myriad of things things we can do with
an interactive/GUI scheduling policy.

One thing this is, since their kernel is preemptible, it marks processes
that very much always deserve a scheduling boost based on interactivity,
and thus their interactivity is quite nice.

	Robert Love

