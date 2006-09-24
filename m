Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWIXQN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWIXQN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWIXQN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:13:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16650 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751197AbWIXQN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:13:59 -0400
Date: Sun, 24 Sep 2006 10:12:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060924101255.GA4813@ucw.cz>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922224735.GB5566@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Andrew Burri:
> > >       V4L/DVB: Add support for Kworld ATSC110
> > > 
> > > Curt Meyers:
> > >       V4L/DVB: KWorld ATSC110: implement set_pll_input
> > >       V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
> > >       V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load
> > > 
> > > Giampiero Giancipoli:
> > >       V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card
> > > 
> > > Hartmut Hackmann:
> > >       V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
> > >       V4L/DVB: Added PCI IDs of 2 LifeView Cards
> > >       V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
> > >       V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
> > >       V4L/DVB: TDA10046 Driver update
> > >       V4L/DVB: TDA8290 update
> > > 
> > > Peter Hartshorn:
> > >       V4L/DVB: Added support for the Tevion DVB-T 220RF card
> > 
> > Hm, all of these patches seems like these are new features being
> > backported to the 2.6.16.y kernel, which is not really allowed under the
> > current -stable rules.
> > 
> > Or are these patches just bugfixes that fix with the current -stable
> > rules?
> 
> They add support for additional hardware to the saa7134 driver.
> 
> If you look at the actual diff there's not much that could cause any 
> regression since nearly all of these change don't change anything for 
> the already supported cards.
> 
> As long as there's not a serious risk of regressions, such additions are 
> welcome in 2.6.16.

I believe you should not do that. Maybe risk of regression is small,
but risk of adding non-working driver is not, and goal of -stable is
to be stable, not to have feature-of-the-day.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
