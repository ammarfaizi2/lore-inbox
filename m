Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTKDTPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTKDTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 14:15:46 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:55313
	"EHLO muru.com") by vger.kernel.org with ESMTP id S261276AbTKDTPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 14:15:45 -0500
Date: Tue, 4 Nov 2003 11:15:04 -0800
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, psavo@iki.fi, clepple@ghz.cc
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104191504.GB1042@atomide.com>
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067971295.11436.66.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* john stultz <johnstul@us.ibm.com> [031104 10:43]:
> On Mon, 2003-11-03 at 16:22, Tony Lindgren wrote:
> > After a year of not having access to my dual athlon box I finally ran
> > apt-get dist-upgrade on it :)
> > 
> > I also did some cleanup on the amd76x_pm to make the amd76x_pm to load as 
> > module, and to remove some unnecessary PCI code.
> 
> I've received some reports that this patch causes time problems.
> 
> Have those issues been looked into further, or addressed? 

I've heard of timing problems if it's compiled in, but supposedly they don't
happen when loaded as module.

Then the 2.4 version does not load if i2c-amd756 is loaded, but this may
have been already fixed by this patch, I have not verified it yet though.

I have problem where my S2460 goes into sleep for a while if compiled in, 
but this does not happen when loaded as module.

So it looks like there are some dependencies to other drivers that need to
be sorted out, or amd76x_pm needs to be loaded after some other
initializations.

Tony
