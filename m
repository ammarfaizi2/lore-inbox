Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVJQJz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVJQJz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVJQJz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:55:59 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:23284 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932240AbVJQJz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:55:59 -0400
Date: Mon, 17 Oct 2005 05:54:53 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Roman Zippel <zippel@linux-m68k.org>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <Pine.LNX.4.61.0510171054430.1386@scrub.home>
Message-ID: <Pine.LNX.4.58.0510170547150.5859@localhost.localdomain>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509301825290.3728@scrub.home> <1128168344.15115.496.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
 <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu>
 <Pine.LNX.4.61.0510171054430.1386@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Oct 2005, Roman Zippel wrote:

> Hi,
>
> On Mon, 17 Oct 2005, Ingo Molnar wrote:
>
> > the thing is that Thomas has advanced the whole issue of timeouts and
> > timekeeping by leaps and bounds and he has written thousands of lines of
> > new and excellent code for a kernel subsystem that has seen little
> > activity for many years, before John got involved. One of Thomas'
> > accomplishments is a timer/time design that allows the enabling of HRT
> > timers via an _18 lines_ architecture patch. (!)
>
> Did I say these patches were bad in general? All I'm asking for is an
> explanation for a few design decisions to understand the patch and its
> behaviour better and evaluate alternative solutions.
> Neither of you have shown any real interest in this so far.
>

Well, for me anyway, the best way I have with understanding ones decisions
in their code design _is_ to start playing with the code.  Try it the way
you want and you might realize things don't work so well, and then you
might understand why Thomas did it his way.

There's several times where I thought I could write something better, and
after playing with it, the problems start to arise where I then become
"enlightened" by the decisions others have made.


> > the moment you express yourself via patches we'll know that 1) you
> > understand what we have done so far 2) you have useful ideas of what
> > should be done differently 3) you have the coder capability to implement
> > and test those ideas. Patches wont be ignored, i can assure you. Get the
> > patches rolling!
>
> This "shut up and show code" attitude is sometimes quite funny, but it's
> no real threat to me. I hoped to avoid this and solve this more civilized.
> Of course I'll understand the issues better afterwards, but you could as
> easily just tell me. It will waste my time, I could spend on other
> projects and it will put Andrew in the unfortunate position to decide,
> which patch to accept.
> Is this really what you want?
>

I think what Ingo is saying, is to modify Thomas' code and show where it
is failing, instead of just talking about it.  You can ask "why" he did
something, but I think Thomas gave you enough in his answers.  If you are
still not satisfied, then that is the time to start playing with the code
and find the problems, fix them and show us that "yes" your way is better.
Don't just ask why Thomas did it one way without a patch that changes it
to show us why he shouldn't have.

-- Steve

