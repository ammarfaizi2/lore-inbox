Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281640AbRKPXEd>; Fri, 16 Nov 2001 18:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281641AbRKPXEO>; Fri, 16 Nov 2001 18:04:14 -0500
Received: from ns.suse.de ([213.95.15.193]:16904 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281640AbRKPXEF>;
	Fri, 16 Nov 2001 18:04:05 -0500
Date: Sat, 17 Nov 2001 00:04:04 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jeff Golds <jgolds@resilience.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <3BF5952E.E73BB648@resilience.com>
Message-ID: <Pine.LNX.4.30.0111162353140.32578-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Jeff Golds wrote:

> So the MP has the SMP capable bit set and the XP does not?

Yes.

> If so, I'm not convinced this is the correct way to approach this
> issue.  My reasoning is based on the fact that AMD is not exactly a
> impartial source of information.  AMD wants to sell more MP chips, so
> they can say that only MP chips are SMP capable even if XP chips work
> just fine.

Whats probably closer to the truth is..

  make cpu
     |
  smp tests run ok ? ------> No, sell as XP
     |
  yes, sell as MP

The same as tests are done to test if they can run at 2GHz. If any
test fails, its tried as at 1.9Ghz, and 1.8Ghz until the tests pass.
One chip yield may run at certain speeds fine, whilst others don't.
How is this relevant ?
Well, overclockers found that the sample of a yield wasn't true of
all cpu silicon from that yield, and that some 1800's run at 1900 with no
problem.  Just as SOME XP users are reporting problems in SMP whilst
some are not.

Burning out a fuse to make the switch from MP->XP may affect more
than just the cpuid capabilities. The fact is _we don't know_

> The way I'd prefer to see this handled is that things are assumed to
> work until proven otherwise.  Sort of like the SMP Celeron systems
> people have been using: Is there _any_ reason to believe that Celeron's
> can't do SMP?

I've yet to see a socket 370 dual processormotherboard that
I'd put faith in for a mission critical environment.
"I had no problems" means _nothing_ when theres as few as 1 other
user reporting SMP related problems with the same setup.

> P.S.  BTW, I don't know all the Athlon steppings, but it sure looks like
> _a lot_ of older Athlons/Durons are SMP capable.

>From my original message:

> > The only older models certified as safe for SMP are.
> >  Athlon model 6, stepping 0 CPUID = 660
> >  Athlon model 6, stepping 1 CPUID = 661
> >  Duron  model 7, stepping 0 CPUID = 670

Three models. There are considerably more out there.
Note, that model 6 isn't really 'old', a thunderbird for eg is
model 4. "old" was used relatively in my original mail.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

