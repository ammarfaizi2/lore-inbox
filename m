Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbSLRIvx>; Wed, 18 Dec 2002 03:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbSLRIvx>; Wed, 18 Dec 2002 03:51:53 -0500
Received: from poup.poupinou.org ([195.101.94.96]:64523 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S267206AbSLRIvw>; Wed, 18 Dec 2002 03:51:52 -0500
Date: Wed, 18 Dec 2002 09:59:02 +0100
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] S4bios for 2.5.52.
Message-ID: <20021218085902.GD1012@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1@orsmsx119.jf.intel.com> <Pine.LNX.4.44.0212171611460.21707-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212171611460.21707-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 04:14:41PM -0600, Kai Germaschewski wrote:
> On Tue, 17 Dec 2002, Grover, Andrew wrote:
> 
> > > From: Ducrot Bruno [mailto:poup@poupinou.org] 
> > > This patch add s4bios support for 2.5.52.
> 
> > > echo 4 > /proc/acpi/sleep is for swsusp;
> > > echo 4b > /proc/acpi/sleep is for s4bios.
> > 
> > I still am not clear on why we would want s4bios in 2.5.x, since we have S4.
> > Like you said, S4bios is easier to implement, but since Pavel has done much
> > of the heavy lifting required for S4 proper, I don't see the need.
> 
> Let me counter this, I have to admit that I didn't try the patch yet, but
> my laptop does S4 BIOS, and I'd definitely prefer that to swsusp, since
> it's much faster and also I somewhat have more faith into S4 BIOS than
> swsusp (as in: after resuming, it'll most likely either work or crash, but
> not cause any weird kinds of corruption). Since it does not need not much
> more to support it than S3, I don't see why you wouldn't want to give
> users the option?
> 

In fact, I agree with Andrew.  But Pavel insist and want it,
and since it is really straightforward to have it in 2.5
because Pavel have already done all the work, why not giving
him a little gift for Christmas ?

A final word:  S4bios is way much _slower_ by nature than S4OS, especially
at suspend path, which is what we don't want if we have to go to S4 due
to an emergency.

Kai, if you see that S4OS is slower, it is probably a bug that have to be
fixed in swsusp.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
