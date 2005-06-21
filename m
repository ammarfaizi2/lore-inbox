Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVFUBdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVFUBdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVFUBbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:31:45 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:27284 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261866AbVFUB27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:28:59 -0400
Date: Mon, 20 Jun 2005 18:28:25 -0700
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: hugang@soulinfo.com, Tony Lindgren <tony@atomide.com>,
       linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050610-1
Message-ID: <20050621012825.GA30990@muru.com>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com> <20050610091515.GH4173@elf.ucw.cz> <20050610151707.GB7858@atomide.com> <20050610221501.GB7575@atomide.com> <20050618033419.GA6476@hugang.soulinfo.com> <1119076233.18247.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119076233.18247.27.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 04:30:32PM +1000, Benjamin Herrenschmidt wrote:
> 
> > I'm try to port it powerpc, Here is a patch.
> > 
> >  Port Dynamic Tick Timer to new platform is easy. :)
> >   1) Find the reprogram timer interface.
> >   2) do a hook in the idle function.
> > 
> > That worked on my PowerBookG4 12'.

Cool :)

> Did you get a measurable gain on power consumption ?
> 
> Last time I toyed with this, I didn't.

Just dyntick alone probably does not do much for power savings. The
trick is to figure out what all can be turned off for the longer idle
periods. And try to make the idle periods longer by cutting down on
polling.

Tony
