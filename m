Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132946AbRDEP5c>; Thu, 5 Apr 2001 11:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132945AbRDEP5W>; Thu, 5 Apr 2001 11:57:22 -0400
Received: from m97-mp1-cvx1a.col.ntl.com ([213.104.68.97]:18692 "EHLO
	[213.104.68.97]") by vger.kernel.org with ESMTP id <S132943AbRDEP5P>;
	Thu, 5 Apr 2001 11:57:15 -0400
To: <root@chaos.analogic.com>
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to let all others run
In-Reply-To: <Pine.LNX.3.95.1010404165539.4737A-100000@chaos.analogic.com>
From: John Fremlin <chief@bandits.org>
Date: 05 Apr 2001 16:55:50 +0100
In-Reply-To: "Richard B. Johnson"'s message of "Wed, 4 Apr 2001 17:00:32 -0400 (EDT)"
Message-ID: <m2itkjwdbt.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On 4 Apr 2001, John Fremlin wrote:
> > 
> > Hi Oliver!
> > 
> >  Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> writes:
> > 
> > > is there a way to let all other runable tasks run until they block
> > > or return to user space, before the task wishing to do so is run
> > > again ?
> > 
> > Are you trying to do this in kernel or something? From userspace you
> > can use nice(2) then sched_yield(2), though I don't know if the linux
> > implementations will guarrantee anything.
> > 
> 
> I recommend using usleep(0) instead of sched_yield(). Last time I
> checked, sched_yield() seemed to spin and eat CPU cycles, usleep(0)
> always gives up the CPU.

What is wrong with this? sched_yield only yields to processes with
lower priority (hence suggestion to use nice(2)). Does sched_yield()
fail to yield in cases when a higher priority process wants to run? 
usleep() wastes time if no other such process is waiting, surely?

[...]

-- 

	http://www.penguinpowered.com/~vii
