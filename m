Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269695AbTGJXYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269699AbTGJXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:24:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:46009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269695AbTGJXXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:23:24 -0400
Date: Thu, 10 Jul 2003 16:38:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
In-Reply-To: <1057879835.584.7.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0307101632100.5091-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2003, Felipe Alfaro Solana wrote:
> 
> Is there any expected or planned timeframe to finalize the pre-2.6
> series and end up with a stable 2.6.0 kernel?

It's a bit hard to plan, since it depends on just how well the pre-series 
ends up working for people. There are now people starting to use the 
current 2.5.x kernels for production use, and indicators look pretty good 
in general, but who can tell? 

So if I were to guess at a couple of months, then that's still just a 
guess.

> I'm worried about the current status of the 2.5 kernel scheduler. I know
> that Con is working hard to nail down all the problems that some people
> like me are having. I don't still feel comfortable with it, and although
> Con patches are several orders of magnitude better than stock scheduler,
> there are minor problems.

Quite frankly, I worry a lot more about device drivers etc than I do about 
the scheduler.

We'll never have "The Perfect Scheduler" (tm), since I don't think such a 
thing exists, but more importantly, I could live even with the current 
one, and I'm sure Con's will be better without having any huge stability 
issues.

> Sometime ago, I made down a combo patch and, sincerely, it's the one I'm
> using the most for my desktop boxes as it's the one that gets better
> response times and interactive feeling. For my server boxes, neither my
> combo patch, neither Con or stock do feel good when the system is under
> heavy load. It suffers from starvation. Simply doing a "tar jxvf" makes
> logging into the system a PITA.

And this one is almost certainly not a process scheduler issue, but an IO
scheduler one. 2.5.75 may help that a bit - anticipatory IO scheduling
from the -mm tree, and a much simpler (and in my tests, noticeably faster
and more robust) executable mmap prefetcher.

But as with process scheduling, I don't believe in "perfect". It will just 
have to be "good enough for a lot of people". 

			Linus

