Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTKDUWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTKDUWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:22:20 -0500
Received: from smtp-4.hut.fi ([130.233.228.94]:55183 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id S262131AbTKDUWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:22:18 -0500
Date: Tue, 4 Nov 2003 22:21:05 +0200
From: Pasi Savolainen <pasi.savolainen@hut.fi>
To: Tony Lindgren <tony@atomide.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       clepple@ghz.cc
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104202104.GA408936@kosh.hut.fi>
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031104191504.GB1042@atomide.com>
User-Agent: Mutt/1.4i
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-4.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [031104 21:24]:
> * john stultz <johnstul@us.ibm.com> [031104 10:43]:
> > On Mon, 2003-11-03 at 16:22, Tony Lindgren wrote:
> > > After a year of not having access to my dual athlon box I finally ran
> > > apt-get dist-upgrade on it :)
> > > 
> > > I also did some cleanup on the amd76x_pm to make the amd76x_pm to load as 
> > > module, and to remove some unnecessary PCI code.
> > 
> > I've received some reports that this patch causes time problems.
> > 
> > Have those issues been looked into further, or addressed? 
> 
> I've heard of timing problems if it's compiled in, but supposedly they don't
> happen when loaded as module.

Not happening since 2.6.0-test9. Don't know what really fixed it, but
they're just not there anymore.
 
> Then the 2.4 version does not load if i2c-amd756 is loaded, but this may
> have been already fixed by this patch, I have not verified it yet though.

Most probably caused by the same thing that prevented it loading under
amd_k7_agp, that is indeed sorted out.

> I have problem where my S2460 goes into sleep for a while if compiled in, 
> but this does not happen when loaded as module.

Could you have some AMD_76X -define left over? I skimmed through MP &
MPX AMD documents, but found nothing incriminating.
Could it be ACPI doing it's things with S -states? (it does check for
SMP, but does report S -states as supported). And if ACPI isn't
enabled, could you toggle it on, or vice-versa.


-- 
Psi -- <http://www.iki.fi/pasi.savolainen>
