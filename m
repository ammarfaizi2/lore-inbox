Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262985AbTC1OLJ>; Fri, 28 Mar 2003 09:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbTC1OLJ>; Fri, 28 Mar 2003 09:11:09 -0500
Received: from pop.gmx.de ([213.165.65.60]:38188 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262985AbTC1OLI>;
	Fri, 28 Mar 2003 09:11:08 -0500
Message-Id: <5.2.0.9.2.20030328152305.019b3e70@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 28 Mar 2003 15:26:52 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.66-mm1
Cc: Andrew Morton <akpm@digeo.com>, Ed Tomlinson <tomlins@cam.org>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.44.0303281139500.6678-100000@localhost.localdom
 ain>
References: <20030327205912.753c6d53.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:45 AM 3/28/2003 +0100, Ingo Molnar wrote:

>On Thu, 27 Mar 2003, Andrew Morton wrote:
>
> > That longer Code: line is really handy.
> >
> > You died in schedule()->deactivate_task()->dequeue_task().
> >
> > static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
> > {
> >       array->nr_active--;
> >
> > `array' is zero.
> >
> > I'm going to Cc Ingo and run away.  Ed uses preempt.
>
>hm, this is an 'impossible' scenario from the scheduler code POV. Whenever
>we deactivate a task, we remove it from the runqueue and set p->array to
>NULL. Whenever we activate a task again, we set p->array to non-NULL. A
>double-deactivate is not possible. I tried to reproduce it with various
>scheduler workloads, but didnt succeed.
>
>Mike, do you have a backtrace of the crash you saw?

No, I didn't save it due to "grubby fingerprints".

         -Mike 

