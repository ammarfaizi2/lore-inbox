Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263463AbRFFDTT>; Tue, 5 Jun 2001 23:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263467AbRFFDTJ>; Tue, 5 Jun 2001 23:19:09 -0400
Received: from illusionary.com ([216.139.204.133]:20229 "EHLO
	www.illusionary.com") by vger.kernel.org with ESMTP
	id <S263463AbRFFDTE>; Tue, 5 Jun 2001 23:19:04 -0400
From: Derek Glidden <dglidden@illusionary.com>
Date: Tue, 5 Jun 2001 23:19:08 -0400
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010605231908.A10520@illusionary.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1D927E.1B2EBE76@uow.edu.au>; from andrewm@uow.edu.au on Wed, Jun 06, 2001 at 12:16:30PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 12:16:30PM +1000, Andrew Morton wrote:
> "Jeffrey W. Baker" wrote:
> > 
> > Because the 2.4 VM is so broken, and
> > because my machines are frequently deeply swapped,
> 
> The swapoff algorithms in 2.2 and 2.4 are basically identical.
> The problem *appears* worse in 2.4 because it uses lots
> more swap.

I disagree with the terminology you're using.  It *is* worse in 2.4,
period.  If it only *appears* worse, then if I encounter a situation
where a 2.2 box has utilized as much swap as a 2.4 box, I should see the
same results.  Yet this happens not to be the case. 

A 2.2 box that's a hundred or more megs into swap, even when that swap
space is "actual programs" rather than just mysteriously allocated swap
(as with 2.4), it only takes the time to page all that off disk back
into RAM, making the machine a little sluggish while it's happening and
definitely not making the machine entirely unresponsive.  

On the other hand, a 2.4 box that's a hundred or more megs into swap,
even when there's nothing actually running to take up that swap space,
i.e. it's just "mysteriously allocated for some reason" swap, will take
several minutes, while the CPU is pegged, the drive is inactive, and the
entire machine is completely unresponsive to anything - for all
appearances locked up tight.

I have been unable to make a box running the 2.2 kernel behave the same
way as 2.4 does, even if I put the 2.2 kernel under severe memory
pressure and the 2.4 kernel is entirely idle with no tasks but the most
basic system processes running.

So from my perspective, which really is a real-world perspective because
I can cause this same behaviour during normal day-to-day desktop
operation of my machine, the behaviour of 2.4 *is* different from the
behaviour of 2.2 when it comes to memory management.

> > they can sometimes take over 30 minutes to shutdown.
> 
> Yes. The sys_swapoff() system call can take many minutes
> of CPU time.  It basically does:
>    [...]
> It's interesting that you've found a case where this
> actually has an operational impact.

I can't tell if this is humour or not.  I hope it is, because I can
sure show you actual operational impact of this mis-behaviour all
day long.  :)

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
