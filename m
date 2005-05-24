Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVEXVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVEXVXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVEXVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:23:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45812 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262193AbVEXVXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:23:24 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: <karim@opersys.com>, "'Ingo Molnar'" <mingo@elte.hu>
Cc: "'Esben Nielsen'" <simlo@phys.au.dk>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>, "'Philippe Gerum'" <rpm@xenomai.org>
Subject: RE: RT patch acceptance
Date: Tue, 24 May 2005 14:23:11 -0700
Message-ID: <001701c560a6$cafbe2b0$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <42935389.5030309@opersys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim wrote:
> 
> Ingo Molnar wrote:
> > just to make sure, by "much more complicated" are you 
> referring to the
> > PREEMPT_RT feature? Right now PREEMPT_RT consists of 8000 
> new lines of 
> > code (of which 2000 is debugging code) and 2000 lines of 
> modified kernel 
> > code. One of the primary goals i had was to keep it simple 
> and robust.
> 
> I'm refering to the complexity of the behavior. Turning 
> interrupts to threads and spinlocks to mutexes makes vanilla 
> Linux's behavior much more complicated than it already is. 
>

Linux has been distributing and decoupling locking and
data structures since the first multi CPU kernel was booted.

All data integrity is just as consistent in RT, so HOW does 
the behavior change? 

SMP is mainstream now (Pentium IV, to start). 

The kernel development is just taking the logical next step. 

RT is eco-friendly, even, if you can bear it, in preventing
high-powered CPUs from burning megawatts spinning on
a bit in memory. Watch the temperature spikes when that
happens.

Basically, the reality is, that software loading can always
exceed the given hardware, for any system. If you want 
some things to always work smoothly, you need to have some 
way to bound response time and prioritize deterministically.

The more the computer becomes an entertainment device in the
mainstream (ahem, Ipod), the more this will be an opportunity
for Linux. People are of course running Linux on their Ipods
already. But - can it play the music without skipping? 

With RT it CAN.

Also keep in mind the time-critical response requirements of
multimedia systems. Its not just Linux in embedded devices. 
Its going to Linux in your TV some day soon (or already).

Take a look at all the big Sony TVs. All MontaVista Linux.

But Linux is behind, somewhat in a lot of this technology,
as pointed out by others. IRQ threads is not radical, untested,
new technology. Nor is a mutex, priority inheritance or not.

Linux is consistent with the Unix legacy - resource sharing,
fairness, progress. All good things, endemic to the evolution
of Linux. But the other Unixes have moved past that - to keep up.

Most of the Unixes are clustering back-room systems now, but some
are still foraging alongside the north-western American 
Tyrannosaurus. They are evolving, and trying not to get chomped.

The pressure is going to increase, the question is do
we lead, or do we follow and pay, whereever they want to 
take us today?

Basically this technology could go into the kernel, to quote Ingo, 
as "no-drag". You turn it off and it goes away, no overhead. 
No pain, no worries, no stress, no flaming. 

And Linux leads the way, and the multimedia / audio folks are happy, 
able to push open source further, opening the door for more folks to 
contribute, best they know how.

There is absolutely nothing, btw. in any of the the 
sub-kernels, patented or not, that can't be done in Linux.


Sven


