Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283867AbRLABPj>; Fri, 30 Nov 2001 20:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283862AbRLABPb>; Fri, 30 Nov 2001 20:15:31 -0500
Received: from bitmover.com ([192.132.92.2]:33723 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S283866AbRLABPM>;
	Fri, 30 Nov 2001 20:15:12 -0500
Date: Fri, 30 Nov 2001 17:15:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011130171510.B19152@work.bitmover.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@zip.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Henning Schmiedehausen <hps@intermeta.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011130155740.I14710@work.bitmover.com> <Pine.LNX.4.40.0111301636010.1600-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.40.0111301636010.1600-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Nov 30, 2001 at 05:13:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 05:13:38PM -0800, Davide Libenzi wrote:
> On Fri, 30 Nov 2001, Larry McVoy wrote:
> Wait a minute.
> Wasn't it you that were screaming against Sun, leaving their team because
> their SMP decisions about scaling sucked, because their OS was bloated
> like hell with sync spinlocks, saying that they tried to make it scale but
> they failed miserably ?

Yup, that's me, guilty on all charges.

> What is changed now to make Solaris, a fairly vanishing OS, to be the
> reference OS/devmodel for every kernel developer ?

It's not.  I never said that we should solve the same problems the same
way that Sun did, go back and read the posting.

> Wasn't it you that were saying that Linux will never scale with more than
> 2 CPUs ?

No, that wasn't me.  I said it shouldn't scale beyond 4 cpus.  I'd be pretty
lame if I said it couldn't scale with more than 2.  Should != could.

> Because you know that adding fine grained spinlocks will make the OS
> complex to maintain and bloated ... like it was Solaris before you
> suddendly changed your mind.

Sorry it came out like that, I haven't changed my mind one bit.

> <YOUR QUOTE>
> >     Then people want more performance.  So they thread some more and now
> >     the locks aren't 1:1 to the objects.  What a lock covers starts to
> >     become fuzzy.  Thinks break down quickly after this because what
> >     happens is that it becomes unclear if you are covered or not and
> >     it's too much work to figure it out, so each time a thing is added
> >     to the kernel, it comes with a lock.  Before long, your 10 or 20
> >     locks are 3000 or more like what Solaris has.  This is really bad,
> >     it hurts performance in far reaching ways and it is impossible to
> >     undo.
> </YOUR QUOTE>
> 
> I kindly agree with this, just curious to understand which kind of amazing
> architectural solution Solaris took to be a reference for SMP
> development/scaling.

OK, so you got the wrong message.  I do _not_ like the approach Sun took,
it's a minor miracle that they are able to make Solaris work as well as
it works given the design decisions they made.

What I do like is Sun's engineering culture.  They work hard, they don't
back away from the corner cases, they have high standards.  All of which
and more are, in my opinion, a requirement to try and solve the problems
the way they solved them.

So the problem I've been stewing on is how you go about scaling the OS
in a way that doesn't require all those hot shot sun engineers to make
it work and maintain it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
