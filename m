Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVABXDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVABXDR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 18:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVABXDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 18:03:17 -0500
Received: from mail.dif.dk ([193.138.115.101]:48023 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261338AbVABXDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 18:03:08 -0500
Date: Mon, 3 Jan 2005 00:14:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <41D87A64.1070207@tmr.com>
Message-ID: <Pine.LNX.4.61.0501030004070.3494@dragon.hygekrogen.localhost>
References: <20050102214211.GM29332@holomorphy.com><20050102214211.GM29332@holomorphy.com>
 <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Bill Davidsen wrote:

> Adrian Bunk wrote:
> > On Sun, Jan 02, 2005 at 01:42:11PM -0800, William Lee Irwin III wrote:
> > 
> > > This is not optimism. This is experience. Every ``stable'' kernel I've
> > > seen is a pile of incredibly stale code where vi'ing any file in it
> > > instantly reveals numerous months or years old bugs fixed upstream.
> > > What is gained in terms of reducing the risk of regressions is more
> > > than lost by the loss of critical examination and by a long longshot.
> > 
> > 
> > The main advantage with stable kernels in the good old days (tm) when 4 and
> > 6 were even numbers was that you knew if something didn't work, and
> > upgrading to a new kernel inside this stable kernel series had a relatively
> > low risk of new breakages. This meant one big migration every few years and
> > relatively easy upgrades between stable series kernels.
> > 
> > Nowadays in 2.6, every new 2.6 kernel has several regressions compared to
> > the previous one, and additionally obsolete but used code like ipchains and
> > devfs is scheduled for removal making upgrades even harder for many users.
> 
> And there you have my largest complaint with the new model. If 2.6 is stable,
> it should not have existing features removed just because someone has a new
> wet dream about a better but incompatible way to do things. I expect working
> programs to be deliberately broken in a development tree, but once existing
> features are removed there simply is no stable set of features.
> > 
> > There's the point that most users should use distribution kernels, but
> > consider e.g. that there are poor souls with new hardware not supported by
> > the 3 years old 2.4.18 kernel in the stable part of your Debian
> > distribution.
> 
> The stable and development kernel model worked for a decade, partly because
> people could build on a feature set and not have that feature just go away,
> leaving the choice of running without fixes or not running. Since we manage to
> support 2.2 and 2.4 (and perhaps even 2.0?) I don't see why the definition of
> "stable" can't simply mean "no deletions from the feature set" and let new
> features come in for those who want them. Absent that 2.4 will be the last
> stable kernel, in the sense that features won't be deliberately broken or
> removed.
> 

The new model has some good aspects to it, mainly that new fixes and 
features make it into the "stable" kernel a lot faster these days. But, it 
is not as stable/static as previous stable series.

Personally I think a lot of the problems could go away if the -mm tree was 
utilized more. 

How does something like this sound? 

2.6.x being stable means that :
 a) features are not removed
 b) patches applied to 2.6 have spend a minimum of time in -mm first (one 
    -mm release minimum? -mm release frequency would probably need to go 
    up a bit)
 c) interfaces do not change unless to fix a serious bug

That would make it a stable series in my book.

Development can still be rapid since -mm would be open to all the 
experimental stuff, and features could be removed in -mm etc.

If *all* patches go through -mm (critical security fixes possibly being 
the excetion) before ending up in mainline, then -mm won't get out of sync 
with mainline with regard to bugfixes - main differences would be new 
experimental stuff and removed features.

When should 2.7 open then?  Well, probably when -mm has diverged so much 
that it becomes a pain to maintain against 2.6 mainline, then it could be 
renamed 2.7.0 and work could start on stabilizing all the experimental 
stuff in it etc.


Does that sound completely insane or as something that could work?
I think it's not so far from what we have now.


-- 
Jesper Juhl


