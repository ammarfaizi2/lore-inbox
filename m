Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCCLXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCCLXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVCCLPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:15:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261571AbVCCLNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:13:47 -0500
Date: Thu, 3 Mar 2005 12:13:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303111340.GL4608@stusta.de>
References: <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303021506.137ce222.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:15:06AM -0800, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > We need to not only produce a useful kernel, but also package it in a 
> >  way that is useful to the direct consumers of the kernel:  distros 
> >  [large and small] and power users.
> 
> This comes down to the question "what are we making"?  Is it an end
> product, or is it a technology which can be turned into an end product? 
> Because the two are different things.
> 
> I'd say that mainline kernel.org for the past couple of years has been a
> technology, not a product.
>...

Even-numbered kernels started becoming a product after the next 
odd-numbered kernel series started.

2.4 might have it's limitations, but today it's a pretty good product.

> But there's something else:
> 
> I would maintain that we're still fixing stuff faster than we're breaking
> stuff.  If you look at the fixes which are going into the tree (and there
> are a HUGE number of fixes), many of them are addressing problems which have
> been there for a long time.
> 
> So as long as we remain in this state, we don't need to do anything.  The
> technology gets closer to a product until we reach the stage where the
> fixage rate equals the breakage rate.   And we're not there yet.
> 
> (It's nice that patches are called "fix the frobnozzle gadget", but this
> analysis would be a lot easier if people would also label their patches
> "break the frobnozzle gadget" when that's what they do.  Oh well).
> 
> So I'd suspect that on average, kernel releases are getting more stable. 
> But the big big problem we have is that even though we fixed ten things for
> each one thing we broke, those single breakages tend to be prominent, and
> people get upset.  It's fairly bad PR that Dell Inspiron keyboards don't
> work in 2.6.11, for example...
> 
> And people will incorrectly (and even wildly) generalise as a result of
> such silly little isolated bugs.  We can wholly address such problems with
> a 2.6.x.y productisation series.

The point behind this is:

It's not the most important question for a user whether the total number 
of bugs has decreased or increased.

The most serious problems for users are regressions compared to the 
kernel before.

If a user who is happily using 2.6.8 learned that "stable" kernel 2.6.9 
broke driver A for him and "stable" kernel 2.6.10 broke driver B for 
him, he will not try any new "stable" kernel simply because it only 
causes trouble for him.

Bad luck, if he therefore misses some serious security fix.

And yes, there are many people out there who use for many different 
reasons self-compiled kernels.

> And something else:
> 
> I don't think 2.2 and 2.4 models are applicable any more.  There are more
> of us, we're better (and older) than we used to be, we're better paid (and
> hence able to work more), our human processes are better and the tools are
> better.  This all adds up to a qualitative shift in the rate and accuracy
> of development.  We need to take this into account when thinking about
> processes.
> 
> It's important to remember that all those kernel developers out there
> *aren't going to stop typing*.  They're just going to keep on spewing out
> near-production-quality code with the very reasonable expectation that
> it'll become publically available in less than three years.  We need
> processes which will allow that.
>...

The traditional solution was to have a development series for the 
developers who don't stop typing and a stable series with few 
regresssions.

Until now, it seems 2.6 has too many regressions in every new released 
kernel for being a really stable kernel.

And people aren't dumb - you can't fool them with any version number 
games. People have learned that a -rc by Linus is equivalent to a -pre 
release by Marcelo. And they will quickly learn that a 2.6.<even> 
kernel will be equivalent to a -pre releaese by Marcelo.

What about thinking instead how to get a 2.7 cycle that roughly fits 
everyones needs?

It took two years from 2.5.0 to 2.6.0 .
That was long. Let's try to shorten it.

Make the feature freeze half a year after the start of 2.5 instead of 
one year as was done in 2.5 . This cuts off half a year of the two 
years. Yes, it really cuts off half a year, because the first year of 
2.5 also included half a year of IDE changes where even the bravest 
kernel developer didn't dare to test the kernel.

Perhaps there are also ways how the more developers, better tools and 
processes can help in shortening the one year after halloween.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

