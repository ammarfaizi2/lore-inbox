Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVH1OC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVH1OC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 10:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVH1OC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 10:02:26 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:49133 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750899AbVH1OC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 10:02:26 -0400
Date: Sun, 28 Aug 2005 10:03:42 -0400
From: Bob Picco <bob.picco@hp.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Alex Williamson <alex.williamson@hp.com>, robert.picco@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: HPET drift question
Message-ID: <20050828140342.GW8919@localhost.localdomain>
References: <88056F38E9E48644A0F562A38C64FB60058CAF33@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60058CAF33@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:	[Fri Aug 26 2005, 08:53:35PM EDT]
> 
> Yes. Looks like "ti->drift = HPET_DRIFT;" is right here. However, I
> would 
> like to double check this with Bob.
> 
> Thanks,
> Venki
> 
> >-----Original Message-----
> >From: Alex Williamson [mailto:alex.williamson@hp.com] 
> >Sent: Thursday, August 25, 2005 8:17 AM
> >To: Pallipadi, Venkatesh
> >Cc: robert.picco@hp.com; linux-kernel@vger.kernel.org
> >Subject: HPET drift question
> >
> >Hi Venki,
> >
> >   I'm confused by the calculation of the drift value in the hpet
> >driver.  The specs defines the recommended minimum hardware
> >implementation is a frequency drift of 0.05% or 500ppm.  However, the
> >drift passed in when registering with the time interpolator is:
> >
> >ti->drift = ti->frequency * HPET_DRIFT / 1000000;
> >
> >Isn't that absolute number of ticks per second drift?  The time
> >interpolator defines the drift in parts per million.  Shouldn't this
> >simply be:
> >
> >ti->drift = HPET_DRIFT;
> >
> >The current code seems to greatly penalize any hpet timer with greater
> >than a 1MHz frequency.  Thanks,
> >
> >	Alex
> >
> >-- 
> >Alex Williamson                             HP Linux & Open Source Lab
> >
> >
Hi Venki:

Alex and I had an earlier IRC discussion where we agreed that HPET_DRIFT
should be the value.  We were just verifying with you.

thanks,

bob
