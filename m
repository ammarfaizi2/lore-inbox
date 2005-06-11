Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVFKRZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVFKRZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVFKRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:25:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57184
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261751AbVFKRYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:24:52 -0400
Date: Sat, 11 Jun 2005 19:24:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611172448.GC5796@g5.random>
References: <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050611052319.GB16500@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611052319.GB16500@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 07:23:19AM +0200, Ingo Molnar wrote:
> Andrea, please just stop these scare tactics, it's getting boring. First 

These are not scare tactics, infact if you use RTOS for something where
a deadline has to be math guaranteed, and you certainly know that's not
possible to guarantee a deadline with preempt-RT if the OS is under
stress at the same time, and something goes wrong and I get a damage
from it, be sure I'd consider you liable for recommending me to use
solution that you know you can't demonstrate as correct, when fully
reliable solutions were available and you knew it (for free as well as
preempt-RT).

> you came with incorrect statements about locks, then you came with the 
> patent boogeyman, then you came with the driver bogosity, and now you 
> come with "but ... [sputter] ... but ... where's the _guarantee_?".

I raised the "guarantee" argument in the second email I posted to this
thread in explanataion of the statement "don't get the  idea of using
preempt-RT where hard-RT is required.". the staement "don't get the  
idea of using preempt-RT where hard-RT is required." comes from the very
_first_ email I posted to this thread.

I don't see why you attempt to reverse the truth and you try to picture
me as making up the next scare tactic of the day, when all posts are
public and with timestamps and when I raised the "_guarantee_" at the
very to of the thread, _before_ talking about _irq or local_irq_disable
or the patent.

The reason I got into this thread is not some economic interest that
some of the preempt-RT developers certainly has, nor any personal
feeling about you. I've said it because I wouldn't like to get near a
robot where the deadlines have to be met thanks to preempt-RT.

You've seen Bill answer when I've said I wouldn't even dream to use
preempt-RT in the project that needs the 50usec latency right? That's
the kind of thing that made me jump into this thread.

The rest of your email IMHO doesn't deserve comments except for this:

> if you review the PREEMPT_RT technology (with a cool mind) i do think 
> you'll eventually come to the conclusion that it is actually a pretty 
> nifty idea and implementation, with some pretty good potential :-) It's 

I've never stated otherwise, I've said _several_ times that in realtime
apps like audio and multimedia in general, preempt-RT is certainly the
best one can do if syscalls are involved anyways for a multitude of
reasons. If you were a musician and you were asking me for a realtime
solution I would sure point to preempt-RT, no argument about that. Even
if local_irq_disable would still do an hard cli, that's still better
than lowlatency alone, no? preempt can't get the irqs out of the way,
preempt-RT can, and that will help audio if you've a usb modem like mine
where the hardirq takes 8msec.

preempt-RT is a great feature at debugging as well, it is a clever
design as well.

> not trying to be the holy grail, it wont (nor does it want to) replace 
> nanokernels, but it actually has some thinking behind it and is 
> definitely useful to alot of people. And that is what matters. Your 

This is the point I tried to make all the way long. Some people here
clearly wants to use preempt-RT in all the domain of nanokernels and
that's wrong IMHO (again see Bill's answer when I've said I wouldn't
dream to use preempt-RT in the 50usec project on linuxdevices).

This is the source of all the flamewar as far as I can tell, and I'm
glad that even despite your insults, at the very end you agree too.
