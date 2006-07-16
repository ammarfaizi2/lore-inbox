Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWGPTmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWGPTmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGPTmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:42:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57869 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750834AbWGPTmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:42:07 -0400
Date: Sun, 16 Jul 2006 20:41:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, dwmw2@infradead.org,
       arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060716194150.GB17172@flint.arm.linux.org.uk>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, dwmw2@infradead.org,
	arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com> <6C943713-549B-453C-A0B2-1286764FFE13@mac.com> <787b0d920607161138l4b6dc25dycaeaaea5e948c769@mail.gmail.com> <20060716185314.GA17172@flint.arm.linux.org.uk> <787b0d920607161222o55cd8837g6545bfd00e50d452@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607161222o55cd8837g6545bfd00e50d452@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 03:22:01PM -0400, Albert Cahalan wrote:
> On 7/16/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >On Sun, Jul 16, 2006 at 02:38:45PM -0400, Albert Cahalan wrote:
> >> On 7/16/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> >> >On Jul 15, 2006, at 17:09:28, Albert Cahalan wrote:
> >>
> >> >You realize that on a couple architectures it's fundamentally
> >> >impossible to get atomic ops completely in userspace, right?
> >>
> >> Sure. Those architectures don't need to drag down the rest.
> >> Plenty of headers are only exported for some architectures.
> >
> >Wrong perspective.  The problem is that they may _appear_ to work as
> >described, but not actually work in the intended way.  That's a bug,
> >and it's a _hard_ bug to locate.
> 
> Again:
> 
> Plenty of headers are only exported for some architectures.

So?  I don't see the relevance of this statement.

> In other words, for all architectures where things work.

And this doesn't make sense (it doesn't contain a verb for a start.)

> >Cloud cuckoo land.  In the embedded world, there are folk still want
> >to have the security aspects as well.  Moreover, there are far more
> >folk who do _NOT_ want to have things like "disable the scheduler" -
> >think the realtime folk.
> 
> Now you are really wrong. :-)

ARM is heavily embedded, and I've never ever had any requests concerning
"can we disable the scheduler from userspace" from anyone...

> >> It's not as if the app developers would care to support
> >> those architectures anyway.
> >
> >That's actually more of a reason to take away the toys they shouldn't
> >be playing with in the first place - the only reason these (wrong)
> >interfaces are being used is because they're easily accessible.
> 
> No. The normal interfaces are dreadful.
> 
> App developers will just cut-and-paste the i386 kernel
> code if you take away the header files. They do that
> often enough already.

And by that statement you just agreed with the part of my mail that you
conveniently cut.

> So all you succeed in doing is eliminating any hope of portability
> to ppc and similar.  This is not an improvement.

I tend to disagree.  In reality folk work towards removing such
dependencies.  We saw it with the old minix tools - they're now fixed.
We've seen it with others, which also eventually got fixed.

The general trend has been to be to fix up these problems as they're
found.

Yes, there are some subborn userspace developers out there, but they'll
continue to be stubborn all the time that their way works.

And finally, bear in mind that we have almost 175 ARM platform designs
registered so far this year, most of them embedded.  So it's a _very_
active space.  Couple that with the lack of folk reporting the problem
you're alluding to... despite ARM atomic ops being protected by
__KERNEL__ and use of ARM kernel bitops in userspace would cause link
errors.

My experience has been obviously different from yours, and therefore I
hold different views.  I don't see the problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
