Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317219AbSFBS5U>; Sun, 2 Jun 2002 14:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSFBS5T>; Sun, 2 Jun 2002 14:57:19 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:13328 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S317219AbSFBS5T>; Sun, 2 Jun 2002 14:57:19 -0400
Date: Sun, 2 Jun 2002 14:57:16 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Thunder from the hill <thunder@ngforever.de>
cc: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <Pine.LNX.4.44.0206021237440.29405-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206021441510.671-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Thunder from the hill wrote:

> On Sun, 2 Jun 2002, Sam Ravnborg wrote:
> > Again wrong approah. Extend kbuild-2.4 with the features, tweak them
> > until they actually meet the requirements and then on to the next step.
> > Obviously the dependency step is huge, but the point is that there is
> > steps before and after this.
> 
> You keep missing the fact that you have kbuild-2.4 and kbuild-2.5 in the 
> same tree. I told you I won't introduce bugs in order to fix them! I'm NOT 
> Microsoft!

And you keep missing the fact that having both in the tree doesn't solve 
anything. Bugs are not a problem in the development series, bugs are 
found and fixed.

However, having both in the tree can mean only one of a few things:

1. kbuild24 will slowly become unmaintained
2. kbuild25 will slowly become unmaintained
3. both will be partially broken for certain newly added targets (e.g. 
author FOO adds driver BAR and only adjusts only of the kbuilds for his 
driver, and you end up with kbuild24 building certain modules and 
kbuild25 building certain other modules, ugh)
4. everybody will have to put in double work to update both kbuilds, test 
changes, etc.

None of the above looks acceptable, IMNHO.

You need to break it up FEATURE BY FEATURE, that's the only way it will go
in. Then you add one feature to the existing kbuild, test, release, get 
bug reports, fix bugs, add the next feature, rinse, repeat.

Also, don't say 'well you need the core to do this and that', it only shows 
that you don't understand the core and you're treating it like a black box.
Once you do understand it, you'll see there are many ways to break it up 
feature-wise.

Ion [swearing this is his last reply in this thread]

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

