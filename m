Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281173AbRKZFk3>; Mon, 26 Nov 2001 00:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281270AbRKZFkT>; Mon, 26 Nov 2001 00:40:19 -0500
Received: from mail.anu.edu.au ([150.203.2.7]:28628 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S281173AbRKZFkH>;
	Mon, 26 Nov 2001 00:40:07 -0500
Message-ID: <3C01D4AE.D50B2B12@anu.edu.au>
Date: Mon, 26 Nov 2001 16:35:42 +1100
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] 2.5/2.6/2.7 transition
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote

>So I could throw a 2.6 directly over the fence, and start a 2.7 series,
>but that would have two really killer problems
>
> (a) I really don't like giving something bad to whoever gets to be
>     maintainer of the stable kernel. It just doesn't work that way:
>     whoever would be willing to maintain such a stable kernel would be a
>     real sucker and a glutton for punishment.
.
. 
>The _real_ solution is to make fewer fundamental changes between stable
>kernels, and that's a real solution that I expect to become more and more
>realistic as the kernel stabilizes. I already expect 2.5 to have a _lot_
>less fundamental changes than the 2.3.x tree ever had - the SMP
>scaliability efforts and page-cachification between 2.2.x and 2.4.x is
>really quite a big change.


I think theres a more fundamental problem with our model of kernel
development.
It would be nice to have stable kernel releases much more often, say
every 6- 8 months.
Or at worst once a year.
But the way we do development just doesn't lend itself to that.
Lots of experimental code gets dumped into the devel kernel, by the time
that gets sorted out, something else experimental has been pushed in
elsewhere. We try to get around this by having freeze periods, but that
seems unnatural. And in a freeze period, you have the quandry of if
something is unstable, do you try to fix it or do you pull it out.

Essentially the problem of stabilising a devel kernel is itself
unstable. Its a battle between bug fixers trying to stabilise things and
developers trying to get new features in. And to go from a devel kernel
to a stable kernel, everything has to be stable at the same time. Which
historically has been a real problem :-)

I don't know if it would really work any better in practise, but I would
like to propose for consideration a 3 level model of kernel development.

You have 3 kernel trees

2.4.x: the stable kernel
2.5.x: the development area for our 2.6 candidate
Experimental: the real development area

The basic model of development is that code gets developed and tested in
experimental.
The only thing stuff that gets into 2.5 is code that has been in
experimental for a while and generally considered stable.
The goal is that at any point in time, 2.5 should be a fairly reasonable
candidate for 2.6.
Every so often when there's general agreement, 2.5 gets promoted to 2.6
and we start again
We don't have the great quandry of how to stabilise 2.5 enough to be
ready for a stable kernel. Its always more or less ready. So we can have
a much quicker cycle time.

The only stuff what would go into 2.4 is clear bug fixes and
occasionally stable code (eg drivers) from 2.5 which have been
backported.


People have been sort of using this kind of scheme unofficially anyway.
Alan's AC kernels and Andrea's AA kernels have been sort of fulfulling
this role. I am suggesting that we formalise this arrangement.



--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
