Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWGORjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWGORjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWGORjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:39:47 -0400
Received: from [83.101.158.20] ([83.101.158.20]:41224 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750729AbWGORjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:39:46 -0400
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Sat, 15 Jul 2006 20:39:58 +0300
User-Agent: KMail/1.5
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <200607112257.22069.a1426z@gawab.com> <1152966159.3114.19.camel@laptopd505.fenrus.org> <200607151709.45870.a1426z@gawab.com>
In-Reply-To: <200607151709.45870.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607152039.58733.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2006-07-15 at 17:09 +0300, Al Boldi wrote:
> > Arjan van de Ven wrote:
> > > On Sat, 2006-07-15 at 14:29 +0300, Al Boldi wrote:
> > > > Arjan van de Ven wrote:
> > > > > > BTW, why does randomize_stack_top() mod against (8192*1024)
> > > > > > instead of (8192) like arch_align_stack()?
> > > > >
> > > > >  because it wants to randomize for 8Mb, unlike arch_align_stack
> > > > > which wants to randomize the last 8Kb within this 8Mb ;)
> > > >
> > > > Randomizing twice?
> > >
> > > a VMA can only be randomized in 4Kb (well page size) granularity, so
> > > the 8Mb randomization can only work in that 4Kb unit, the "second"
> > > randomization can work in 16 byte granularity.
> > >
> > > > There is even a case where a mere rename or running through an extra
> > > > shell causes a slowdown.  And that's with randomization turned off.
> > >
> > > randomization off will slow stuff down yes... you get cache alias
> > > contention that way.
>
> a question.. do you have prelink installed/active on your system? that
> may very well mess with timings...

No, not that I am aware of.  How can I find out?
I confirmed this on a standard rhel4 virgin-install.  Does rhel4 have prelink 
enabled by default?

But even so, I don't think this is a timing issue, as the slowdowns are so 
huge it is obvious even without timing.

And 2.4.31 doesn't have this problem.

Did you try it?

Thanks!

--
Al

