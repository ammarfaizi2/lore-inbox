Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284356AbRLRRsb>; Tue, 18 Dec 2001 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284359AbRLRRsV>; Tue, 18 Dec 2001 12:48:21 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:22279 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284356AbRLRRsQ>; Tue, 18 Dec 2001 12:48:16 -0500
Date: Tue, 18 Dec 2001 09:50:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112180918340.2867-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112180940400.1591-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Linus Torvalds wrote:

>
> On Tue, 18 Dec 2001, Mike Kravetz wrote:
> > On Tue, Dec 18, 2001 at 02:09:16PM +0000, Alan Cox wrote:
> > > The scheduler is eating 40-60% of the machine on real world 8 cpu workloads.
> > > That isn't going to go away by sticking heads in sand.
> >
> > Can you be more specific as to the workload you are referring to?
> > As someone who has been playing with the scheduler for a while,
> > I am interested in all such workloads.
>
> Well, careful: depending on what "%" means, a 8-cpu machine has either
> "100% max" or "800% max".
>
> So are we talking about "we spend 40-60% of all CPU cycles in the
> scheduler" or are we talking about "we spend 40-60% of the CPU power of
> _one_ CPU out of 8 in the scheduler".
>
> Yes, 40-60% sounds like a lot ("Wow! About half the time is spent in the
> scheduler"), but I bet it's 40-60% of _one_ CPU, which really translates
> to "The worst scheduler case I've ever seen under a real load spent 5-8%
> of the machine CPU resources on scheduling".
>
> And let's face it, 5-8% is bad, but we're not talking "half the CPU power"
> here.

Linus, you're plain right that we can spend days debating about the
scheduler load.
You've to agree that sharing a single lock/queue for multiple CPU is,
let's say, quite crappy.
You agreed that the scheduler is easy and the fix should not take that
much time.
You said that you're going to accept the solution that is coming out from
the mailing list.
Why don't we start talking about some solution and code ?
Starting from a basic architecture down to the implementation.
Alan and Rik are quite "unloaded" now, what do You think ?



- Davide


