Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289387AbSAODaL>; Mon, 14 Jan 2002 22:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289388AbSAODaC>; Mon, 14 Jan 2002 22:30:02 -0500
Received: from [66.89.142.2] ([66.89.142.2]:62013 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S289387AbSAOD3p>;
	Mon, 14 Jan 2002 22:29:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: george anzinger <george@mvista.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 15 Jan 2002 04:31:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16QC5P-0000nO-00@starship.berlin> <3C439D02.EBCD78C4@mvista.com>
In-Reply-To: <3C439D02.EBCD78C4@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QKK0-0000pN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 04:07 am, george anzinger wrote:
> Daniel Phillips wrote:
> > 
> > On January 14, 2002 10:09 am, yodaiken@fsmlabs.com wrote:
> > > UNIX generally tries to ensure liveness. So you know that
> > >       cat lkarchive | grep feel | wc
> > > will complete and not just that, it will run pretty reasonably because
> > > for UNIX _every_ process is important and gets cpu and IO time.
> > > When you start trying to add special low latency tasks, you endanger
> > > liveness.  And preempt is especially corrosive because one of the
> > > mechanisms UNIX uses to assure liveness is to make sure that once a
> > > process starts it can do a significant chunk of work.
>
> If I read this right, your complaint is not with preemption but with
> scheduler policy.  Clearly both are needed to "assure liveness". 
> Another way of looking at preemption is that is enables a more
> responsive and nimble scheduler policy (afterall it is the scheduler
> that decided that task A should give way to task B.  All preemption does
> is to allow that to happen with greater dispatch.)  Given that, we can
> then discuss what scheduler policy should be.

You responded to the wrong person, however I'll take this opportunity to 
agree with you, on the basis of my years of experience with critical path 
scheduling.  For project schedules 'earlist completion' is the name of the 
game, within bounds of available resources.  When you delay an indvidual 
'task' (I'm using the project management term here) past the earliest time it 
can be scheduled, you are using up its 'float', and if the delay is longer 
than the task's float, the completion time of the schedule as a whole will be 
delayed.  This is no different for a computer than it is for a group of 
people, it is still a scheduling problem.  Delaying any random task risks 
delaying the schedule as a whole, and that risk approaches certainty as the 
number of delays approaches infinity.

N.B.: the above observation is aimed at project managers, who will know 
exactly what I'm talking about.  Otherwise, don't worry if it sounds like so 
much BS, it actually isn't ;-)

--
Daniel
