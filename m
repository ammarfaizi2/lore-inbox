Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263958AbUKZUUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbUKZUUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUKZUUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:20:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51465 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263958AbUKZT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:56:30 -0500
Date: Thu, 25 Nov 2004 16:56:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
Message-ID: <20041125155614.GD3537@stusta.de>
References: <20041121220251.GE13254@stusta.de> <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de> <1101140745.9784.7.camel@uganda> <20041122165145.GH19419@stusta.de> <1101143109.9784.9.camel@uganda> <20041122171956.GI19419@stusta.de> <1101145020.9784.17.camel@uganda> <20041123002028.GN19419@stusta.de> <1101206052.9784.26.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101206052.9784.26.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 01:34:12PM +0300, Evgeniy Polyakov wrote:
> On Tue, 2004-11-23 at 01:20 +0100, Adrian Bunk wrote:
> > On Mon, Nov 22, 2004 at 08:37:00PM +0300, Evgeniy Polyakov wrote:
> > > 
> > > that should be follwing:
> > > 
> > > Kconfig:
> > > foo depends on ds9490r
> > > 
> > > obj-$() += foo.o
> > > foo-objs := foo_1.o foo_2.o
> > > 
> > > It just happened that ds9490r does not need any other parts but
> > > dscore.o.
> > > That is why ds9490r.o have only dscore.o in it's dependency.
> > 
> > If foo_1 or foo_2 is dscore, you get exactly the compile breakage I 
> > described.
> 
> foo_1 and foo_2 will not be dscore, since foo depends on ds9490 and thus
> dscore must be already built.
> It looks like you were confused by dscore vs. ds9490 names. Probably it
> was not a good idea to
> call it in a such way, but it was done and it works.

Is there a reason against simply renaming dscore.c to ds9490r.c ?

> > > > That drivers/w1/ contains many EXPORT_SYMBOL's with no in-kernel users 
> > > > is a different issue I might send a separate patch for (that besides 
> > > > proprietary modules there might come some day open source drivers using 
> > > > them is not a reason).
> > > 
> > > Why remove existing non disturbing set of exported functions?
> > > Are they violate some unknown issues?
> > 
> > If an export is currently unused, there's no need to export it.
> > 
> > If an export is only used for proprietary modules, that's a reason for 
> > an immediate removal of this export.
> 
> Sigh. It can be used by anyone who want to use it.

That's not the way it's handled in the Linux kernel.

Proprietary modules are allowed, but support code only required by them 
but not used by free software has to be removed.

> I will take more carefull look at it later, thank you.

Thanks.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

