Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTKDUzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTKDUzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:55:53 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:2579
	"EHLO muru.com") by vger.kernel.org with ESMTP id S262540AbTKDUzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:55:52 -0500
Date: Tue, 4 Nov 2003 12:55:48 -0800
To: Pasi Savolainen <pasi.savolainen@hut.fi>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       clepple@ghz.cc
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104205547.GE1042@atomide.com>
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com> <20031104202104.GA408936@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104202104.GA408936@kosh.hut.fi>
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pasi Savolainen <pasi.savolainen@hut.fi> [031104 12:21]:
> * Tony Lindgren <tony@atomide.com> [031104 21:24]:
> > * john stultz <johnstul@us.ibm.com> [031104 10:43]:
> > > On Mon, 2003-11-03 at 16:22, Tony Lindgren wrote:
> > > I've received some reports that this patch causes time problems.
> > > 
> > > Have those issues been looked into further, or addressed? 
> > 
> > I've heard of timing problems if it's compiled in, but supposedly they don't
> > happen when loaded as module.
> 
> Not happening since 2.6.0-test9. Don't know what really fixed it, but
> they're just not there anymore.

Weird, John, is this true on your S2460 also?

> > Then the 2.4 version does not load if i2c-amd756 is loaded, but this may
> > have been already fixed by this patch, I have not verified it yet though.
> 
> Most probably caused by the same thing that prevented it loading under
> amd_k7_agp, that is indeed sorted out.

OK

> > I have problem where my S2460 goes into sleep for a while if compiled in, 
> > but this does not happen when loaded as module.
> 
> Could you have some AMD_76X -define left over? I skimmed through MP &
> MPX AMD documents, but found nothing incriminating.
> Could it be ACPI doing it's things with S -states? (it does check for
> SMP, but does report S -states as supported). And if ACPI isn't
> enabled, could you toggle it on, or vice-versa.

Well, I think I had this problem originally in amd-smp-idle.c before there 
was any ACPI support in the module. It's probably related to some ACPI
register though.

Tony
