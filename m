Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVFPWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVFPWSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFPWSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:18:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:39617 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261819AbVFPWSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:18:44 -0400
Date: Fri, 17 Jun 2005 00:24:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       davidm@hpl.hp.com, eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in
 efi_range_is_wc()
In-Reply-To: <200506162348.38423.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0506170014440.2477@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506162219040.2477@dragon.hyggekrogen.localhost>
 <20050616134126.264d6bd5.akpm@osdl.org> <Pine.LNX.4.62.0506162254480.2477@dragon.hyggekrogen.localhost>
 <200506162348.38423.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Arnd Bergmann wrote:

> On Dunnersdag 16 Juni 2005 23:02, Jesper Juhl wrote:
> > On Thu, 16 Jun 2005, Andrew Morton wrote:
> > > There are surely many warnings in the tree, hence I'm not really interested
> > > in patches which only fix `gcc -W' warnings.
> > > 
> > 
> > Ok, in that case I won't bother you directly with such patches any more 
> > but instead let them trickle into maintainers trees when they will take 
> > them.
> > 
> > And yes, I know it's very trivial stuff and it doesn't make much of a 
> > difference to the "big picture", but my attitude towards that is that no 
> > issue is too small to be addressed, and since I'm not able to adress many 
> > of the larger issues I try to address the smaller ones that I'm able to 
> > handle, and when I run out of those I start nitpicking with the really 
> > trivial stuff (like gcc -W warnings) - all with the purpose of helping our 
> > kernel be the very best it can, even if my contribution might be very 
> > minor in some cases.
> 
> I have a patch that optionally enables some of the interesting warnings
> that gcc supports (e.g. -Wmissing-format-attribute -Wmissing-declarations
> -Wundef -Wwrite-strings).
> 
> It has four different levels:
> 
> - quiet (current warnings minus -Wdeprecated-declarations)
> - normal (some interesting ones added that are not too noisy)
> - more (all interesting ones, including some noisier ones like 
>   -Wmissing-declarations)
> - overkill (-W and some more that only make sense for statistic
>   analysis)
> 
> I have the base patch and some more patches that fix the most annoying 
> warnings. I find them more useful than the signed vs unsigned comparison
> fixes you are doing right now, but don't have the time to split my
> patches up into obvious chunks.
> 
> Jesper, are you interested in my stuff

Certainly.


> and willing to continue that work?

To the best of my abilities, yes. I'd like to take a look at those 
patches. 
If nothing else it sounds like a good way for me to cut my current 
(extra warning enabled) build logs down to size and focus on the more 
relevant of the issues. And perhaps, if I can find the time for it, I can 
split the other patches you have into some sane chunks and start 
submitting them to the relevant maintainers.


> I'd suggest to fix the warnings at 'normal' level first and then
> integrate the patch for configurable warning levels into -mm.
> 
Sounds like a resonable plan to me.  Send your stuff along and I'll put 
some time into it when and where I can find it :-)


--
Jesper 


