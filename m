Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSALTia>; Sat, 12 Jan 2002 14:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbSALTiU>; Sat, 12 Jan 2002 14:38:20 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:44294 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287373AbSALTiH>;
	Sat, 12 Jan 2002 14:38:07 -0500
Date: Sat, 12 Jan 2002 12:35:14 -0700
From: yodaiken@fsmlabs.com
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: arjan@fenrus.demon.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112123514.B6034@hq.fsmlabs.com>
In-Reply-To: <E16PTIR-0002sL-00@the-village.bc.nu> <005b01c19b9e$90a5af40$0501a8c0@psuedogod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <005b01c19b9e$90a5af40$0501a8c0@psuedogod>; from ed.sweetman@wmich.edu on Sat, Jan 12, 2002 at 02:23:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 02:23:00PM -0500, Ed Sweetman wrote:
> hardware to hardware could have a higher priority than normal programs being
> run.   That way they're not preempted by simple programs, it would have to
> be purposely preempted by the user.

Priority is currently, and sensibly, by process. A process may run user
code, do sys-calls, or field interrupts both soft and hard. Now do you want to
adjust the priority at every transition?

> Lowering the latency, sure the low latency code probably does nearly as well
> as the preempt patch.  that's fine.  Shortening the time locks are held by
> better code can help to a certain extent (unless a lot of the kernel code is
> poorly written, which i doubt).  at it's present state though,  my idea to
> fix the kernel would be to give parts of the kernel where locks are made,

"Fix" what? What is the objective of your fix?


> that shouldn't be broken normally, higher priorities.  That way we can
> distinguish between safe locks to preempt at and the ones that can do harm.
> But those people who require their app to be treated special can run it
> with -20 and preempt everything.   To me that makes sense.  Is there a

So:
	get semaphore on slab memory and raise priority
		get preempted by "treated special" app that then
			does an operation on the slab queues 

Is that what you want?
		
> reason why it doesn't?  Besides ethstetics.   the only way the ethsetic

It doesn't work? Is that a sufficient reason?


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

