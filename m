Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWIVWrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWIVWrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWIVWrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:47:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965251AbWIVWrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:47:36 -0400
Date: Sat, 23 Sep 2006 00:47:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060922224735.GB5566@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922223859.GB21772@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 03:38:59PM -0700, Greg KH wrote:
> On Sat, Sep 23, 2006 at 12:23:00AM +0200, Adrian Bunk wrote:
> > Andrew Burri:
> >       V4L/DVB: Add support for Kworld ATSC110
> > 
> > Curt Meyers:
> >       V4L/DVB: KWorld ATSC110: implement set_pll_input
> >       V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
> >       V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load
> > 
> > Giampiero Giancipoli:
> >       V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card
> > 
> > Hartmut Hackmann:
> >       V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
> >       V4L/DVB: Added PCI IDs of 2 LifeView Cards
> >       V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
> >       V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
> >       V4L/DVB: TDA10046 Driver update
> >       V4L/DVB: TDA8290 update
> > 
> > Peter Hartshorn:
> >       V4L/DVB: Added support for the Tevion DVB-T 220RF card
> 
> Hm, all of these patches seems like these are new features being
> backported to the 2.6.16.y kernel, which is not really allowed under the
> current -stable rules.
> 
> Or are these patches just bugfixes that fix with the current -stable
> rules?

They add support for additional hardware to the saa7134 driver.

If you look at the actual diff there's not much that could cause any 
regression since nearly all of these change don't change anything for 
the already supported cards.

As long as there's not a serious risk of regressions, such additions are 
welcome in 2.6.16.

"is not really allowed under the current -stable rules" is a bit hard to 
answer, but considering that "Missing PCI id update for VIA IDE" was OK 
for 2.6.17.12 I'd say it's consistent with what you are doing.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

