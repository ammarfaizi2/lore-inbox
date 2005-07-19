Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVGSN56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVGSN56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVGSN4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:56:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:53134 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261362AbVGSNyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:54:46 -0400
Subject: Re: [PATCH] Dynamic tick for x86 version 050610-1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hugang@soulinfo.com
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <20050719065122.GA5913@hugang.soulinfo.com>
References: <20050602013641.GL21597@atomide.com>
	 <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com>
	 <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com>
	 <20050610091515.GH4173@elf.ucw.cz> <20050610151707.GB7858@atomide.com>
	 <20050610221501.GB7575@atomide.com>
	 <20050618033419.GA6476@hugang.soulinfo.com>
	 <1119076233.18247.27.camel@gaston>
	 <20050719065122.GA5913@hugang.soulinfo.com>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 23:51:54 +1000
Message-Id: <1121781115.14393.59.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 14:51 +0800, hugang@soulinfo.com wrote:
> On Sat, Jun 18, 2005 at 04:30:32PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > I'm try to port it powerpc, Here is a patch.
> > > 
> > >  Port Dynamic Tick Timer to new platform is easy. :)
> > >   1) Find the reprogram timer interface.
> > >   2) do a hook in the idle function.
> > > 
> > > That worked on my PowerBookG4 12'.
> > 
> > Did you get a measurable gain on power consumption ?
> > 
> > Last time I toyed with this, I didn't.
> 
> Today I do a measurable about it. 
> 
> First I using 2.6.12 without dynamic enable and unplug the AC power,
> I check the /proc/pmu/battery_0, like this.
> --
>  flags      : 00000011
>  charge     : 907
>  max_charge : 2863
>  current    : -987
>  voltage    : 10950
>  time rem.  : 3600
> --
> I only intresting with current, that show the system power load. 
> 
> When I enable dynamic, The current can low at -900.

The numbers are repeatable ? I mean, if you actually let it settle down
in both cases ? Also, you should be careful about "parasites" in the
measurement, like pbbuttons dimming the backlight, the hard disk going
to sleep etc...

>From your numbers you get something like 10% improvement, which isn't
too bad.

Ben.


