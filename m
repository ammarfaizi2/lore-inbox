Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVEXWYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVEXWYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVEXWX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:23:58 -0400
Received: from opersys.com ([64.40.108.71]:53260 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261357AbVEXWV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:21:27 -0400
Message-ID: <4293AB4D.4030506@opersys.com>
Date: Tue, 24 May 2005 18:31:41 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Sven Dietrich <sdietrich@mvista.com>
CC: "'Ingo Molnar'" <mingo@elte.hu>, "'Esben Nielsen'" <simlo@phys.au.dk>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Daniel Walker'" <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, "'Philippe Gerum'" <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <001701c560a6$cafbe2b0$c800a8c0@mvista.com>
In-Reply-To: <001701c560a6$cafbe2b0$c800a8c0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sven Dietrich wrote:
> Linux has been distributing and decoupling locking and
> data structures since the first multi CPU kernel was booted.
> 
> All data integrity is just as consistent in RT, so HOW does 
> the behavior change? 

Here's quoting Arjan from another thread just today:
> PREEMPT was (and is?) a stability risk and so you'll see RHEL4 not
> having it enabled.

... and that's for simple preemption ...

Beyond that, I must admit that I'm probably missing the point of
your question: fact is that running interrupt handlers as threads
!= dealing with interrupts in a linear fashion (as is now.) That's
behavior change right there, to mention just that.

> The more the computer becomes an entertainment device in the
> mainstream (ahem, Ipod), the more this will be an opportunity
> for Linux. People are of course running Linux on their Ipods
> already. But - can it play the music without skipping? 

Like I said, there are many paths that lead to the same result.

> With RT it CAN.

Sure. There's a nice thread about just that topic (using rt,
as in Adeos, to get skipless audio) following the release of
Adeos back in june 2002.

> The pressure is going to increase, the question is do
> we lead, or do we follow and pay, whereever they want to 
> take us today?

To the best of my understanding, support for a given feature in
other unices has not necessarily resulted in it being included
in Linux. sys_clone() is a good example. Frankly, though, I
would rather not get into such a philosophical debate. My point
is that I personally (and it seems others too) feel that the
cost/benefit ratio plays favorably for a lightweight rt solution.

> Basically this technology could go into the kernel, to quote Ingo, 
> as "no-drag". You turn it off and it goes away, no overhead. 
> No pain, no worries, no stress, no flaming. 

Sure, but the same could be said for a lot of different things.
But like I said in my mail to Ingo, the approaches discussed
here are not mutually exclusive.

> There is absolutely nothing, btw. in any of the the 
> sub-kernels, patented or not, that can't be done in Linux.

If you look in the archives, you'll actually find me making an
almost identical statement. And like I said back then, the
question isn't whether Linux can become QNX, but whether this
is a desirable goal. And I'll stop here, simply because that's
not up to me to decide. I've taken enough bandwidth as it is
on this thread, and I frankly don't think that any of what I
said above has added any more information for those who've
read my previous postings. I only got into this thread to point
out that some info about RTAI was wrong. So like I told Ingo,
if rt-preempt gets in, then so be it.

<repeating-myself>
>From my POV, it just seems that it's worth asking a basic
question: what is the least intrusive modification to the Linux
kernel that will allow obtaining hard-rt and what mechanisms
can we or can we not build on that modification? Again, my
answer to this question doesn't matter, it's the development
crowd's collective answer that matters. And in championing
the hypervisor/nanokernel path, I could turn out to be horribly
wrong. At this stage, though, I'm yet unconvinced of the
necessity of anything but the most basic kernel changes (as
in using function pointers for the interrupt control path,
which could be a CONFIG_ also).

Much as you see the deployment of Linux in various products
by virtue of working for a distro vendor, so do I encounter
quite a few embedded developers through various venues like
hands-on classes I teach, and in almost every case of hard-
rt problem with Linux I've had submitted to me, there is a
way of getting what is needed with what something like a
nanokernel. Sure, there are cases where it isn't enough and
where something like rt-preempt or RTAI or whatever would
be best, but from my experience this is not the norm.

Again, this is all a question of perspective. I'm basing my
analysis on my personal experience. Yours may dictate an
entirely different path, and again, I could be completely
wrong. We may also end up somewhere in between:

There is, in fact, nothing precluding rt-preemption from
co-existing with a nanokernel.
</repeating-myself>

Cheers,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
