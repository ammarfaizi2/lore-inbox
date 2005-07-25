Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVGYKMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVGYKMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVGYKMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:12:37 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:62342 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261183AbVGYKMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:12:35 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 25 Jul 2005 03:11:58 -0700
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050610-1
Message-ID: <20050725101157.GF5837@atomide.com>
References: <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com> <20050610091515.GH4173@elf.ucw.cz> <20050610151707.GB7858@atomide.com> <20050610221501.GB7575@atomide.com> <20050618033419.GA6476@hugang.soulinfo.com> <1119076233.18247.27.camel@gaston> <20050719065122.GA5913@hugang.soulinfo.com> <1121781115.14393.59.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121781115.14393.59.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [050719 06:55]:
> On Tue, 2005-07-19 at 14:51 +0800, hugang@soulinfo.com wrote:
> > On Sat, Jun 18, 2005 at 04:30:32PM +1000, Benjamin Herrenschmidt wrote:
> > > 
> > > > I'm try to port it powerpc, Here is a patch.
> > > > 
> > > >  Port Dynamic Tick Timer to new platform is easy. :)
> > > >   1) Find the reprogram timer interface.
> > > >   2) do a hook in the idle function.
> > > > 
> > > > That worked on my PowerBookG4 12'.
> > > 
> > > Did you get a measurable gain on power consumption ?
> > > 
> > > Last time I toyed with this, I didn't.
> > 
> > Today I do a measurable about it. 
> > 
> > First I using 2.6.12 without dynamic enable and unplug the AC power,
> > I check the /proc/pmu/battery_0, like this.
> > --
> >  flags      : 00000011
> >  charge     : 907
> >  max_charge : 2863
> >  current    : -987
> >  voltage    : 10950
> >  time rem.  : 3600
> > --
> > I only intresting with current, that show the system power load. 
> > 
> > When I enable dynamic, The current can low at -900.
> 
> The numbers are repeatable ? I mean, if you actually let it settle down
> in both cases ? Also, you should be careful about "parasites" in the
> measurement, like pbbuttons dimming the backlight, the hard disk going
> to sleep etc...
> 
> >From your numbers you get something like 10% improvement, which isn't
> too bad.

Just quick update here, I'm back from vacation and will try to
post updated dyn-tick patch soon with the PPC patch integrated.

Tony
