Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277273AbRJDXwC>; Thu, 4 Oct 2001 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277271AbRJDXvx>; Thu, 4 Oct 2001 19:51:53 -0400
Received: from [208.129.208.52] ([208.129.208.52]:20747 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277270AbRJDXvf>;
	Thu, 4 Oct 2001 19:51:35 -0400
Date: Thu, 4 Oct 2001 16:56:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0110041655010.1022-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Mike Kravetz wrote:

> On Thu, Oct 04, 2001 at 10:42:37PM +0000, Linus Torvalds wrote:
> > Could we try to hit just two? Probably, but it doesn't really matter,
> > though: to make the lmbench scheduler benchmark go at full speed, you
> > want to limit it to _one_ CPU, which is not sensible in real-life
> > situations.
>
> Can you clarify?  I agree that tuning the system for the best LMbench
> performance is not a good thing to do!  However, in general on an
> 8 CPU system with only 2 'active' tasks I would think limiting the
> tasks to 2 CPUs would be desirable for cache effects.
>
> I know that running LMbench with 2 active tasks on an 8 CPU system
> results in those 2 tasks being 'round-robined' among all 8 CPUs.
> Prior analysis leads me to believe the reason for this is due to
> IPI latency.  reschedule_idle() chooses the 'best/correct' CPU for
> a task to run on, but before schedule() runs on that CPU another
> CPU runs schedule() and the result is that the task runs on a
> ?less desirable? CPU.  The nature of the LMbench scheduler benchmark
> makes this occur frequently.  The real question is: how often
> does this happen in real-life situations?

Well, if you remember the first time this issue was discussed on the
mailing list was due a real life situation not due a bench run.




- Davide


