Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWAMMYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWAMMYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWAMMYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:24:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53001 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422640AbWAMMX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:23:59 -0500
Date: Fri, 13 Jan 2006 13:23:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Jon Mason <jdmason@us.ibm.com>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060113122358.GH29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu> <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de> <1137105731.2370.94.camel@mindpipe> <20060113113756.GL5399@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113113756.GL5399@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 01:37:56PM +0200, Muli Ben-Yehuda wrote:
> On Thu, Jan 12, 2006 at 05:42:10PM -0500, Lee Revell wrote:
> > On Thu, 2006-01-12 at 23:00 +0100, Adrian Bunk wrote:
> > > CYBER5050 is discussed in ALSA bug #1293 (tester wanted).
> > 
> > OK I set that bug to FEEDBACK, but it's open 5 months now and no testers
> > are forthcoming.  I think if we don't find one as a result of this
> > thread we can assume no one cares about this hardware anymore.
> > 
> > I'm still not sure that just adding it to the ALSA driver and hoping it
> > works is the best solution.  Would we rather users see right away that
> > their hardware isn't supported, or have the driver load and get no sound
> > or hang the machine?
> 
> ... or use the known working OSS driver?
>...

In my experience with scheduling OSS drivers for removal, users simply 
use the OSS drivers unless you tell them very explicitely that the OSS 
driver will go.

It shouldn't be too hard to port the support to ALSA if someone with the  
hardware is willing to test patches.

The goal is to get people still using OSS drivers where ALSA drivers 
support the same hardware to use the ALSA drivers - and if there were 
bugs in the ALSA drivers preventing them to switch to ALSA, to report 
them to the ALSA bug tracking system.

This has the following advantages:
- better ALSA drivers
- get rid of some unmaintained code in the kernel
 
> Cheers,
> Muli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

