Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWAROVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWAROVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWAROVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:21:22 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:32936 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1030325AbWAROVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:21:22 -0500
Date: Wed, 18 Jan 2006 15:18:59 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@elte.hu>, david singleton <dsingleton@mvista.com>,
       Bill Huey <billh@gnuppy.monkey.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <1137588583.6762.40.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0601181518040.1993-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Steven Rostedt wrote:

> On Wed, 2006-01-18 at 11:31 +0100, Esben Nielsen wrote:
> > Hi,
> >  I have updated it:
> >
> > 1) Now ALL_TASKS_PI is 0 again. Only RT tasks will be added to
> > task->pi_waiters. Therefore we avoid taking the owner->pi_lock when the
> > waiter isn't RT.
> > 2) Merged into 2.6.15-rt6.
> > 3) Updated the tester to test the hand over of BKL, which was mentioned
> > as a potential issue by Bill Huey. Also added/adjusted the tests for the
> > ALL_TASKS_PI==0 setup.
> > (I really like unittesting: If someone points out an issue or finds a bug,
> > make a test first demonstrating the problem. Then fixing the code is a lot
> > easier - especially in this case where I run rt.c in userspace where I can
> > easily use gdb.)
>
> Hmm, maybe I'll actually get a chance to finally play with this. I've
> discovered issues with the hrtimers earlier, and was too busy helping
> Thomas with them.  That had to take precedence.
>
I just keep making small improvements and test as I get time (which isn't
much).

Esben
> ;)
>
> -- Steve
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

