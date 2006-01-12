Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161383AbWALWqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbWALWqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161384AbWALWqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:46:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28676 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161383AbWALWqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:46:45 -0500
Date: Thu, 12 Jan 2006 23:46:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jiri Slaby <slaby@liberouter.org>,
       Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060112224645.GY29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu> <1137100539.2370.68.camel@mindpipe> <20060112215853.GW29663@stusta.de> <1137103614.2370.75.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137103614.2370.75.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:06:53PM -0500, Lee Revell wrote:
> On Thu, 2006-01-12 at 22:58 +0100, Adrian Bunk wrote:
> > On Thu, Jan 12, 2006 at 04:15:38PM -0500, Lee Revell wrote:
> > > On Thu, 2006-01-12 at 22:07 +0200, Muli Ben-Yehuda wrote:
> > > > On Thu, Jan 12, 2006 at 08:28:30PM +0100, Jiri Slaby wrote:
> > > > 
> > > > > You should change alsa driver (sound/pci/trident/trident.c), rather than this,
> > > > > which will be removed soon, I guess. And, additionally, could you change that
> > > > > lines to use PCI_DEVICE macro?
> > > > 
> > > > This driver is not up for removal soon, as it supports a device that
> > > > the alsa driver apparently doesn't (the INTERG_5050).
> > > 
> > > When were you going to report this?
> > 
> > I already reported this as ALSA bug #1293.
> > 
> > The problem is the lack of a tester, and I'm currently inclined to 
> > schedule this driver for removal although this PCI ID is still missing - 
> > either noone is using these settop boxes anymore or someone will 
> > volunteer to test patches.
> 
> Hmm, yeah, if the hardware was only used in set top boxes there's not a
> lot that can be done, unless someone wants to donate one to the ALSA
> project.
> 
> It might be as simple as adding the PCI IDs to the driver.

To the snd-trident ALSA driver or to the snd-ali5451 ALSA driver?

Seriously, if it would be _that_ trivial, I'd have sent such a patch 
instead of opening the ALSA bug.

There's a serious amount of 5050 specific code in the OSS driver, and 
I'd therefore prefer "unsopported in ALSA" over "blindly adding PCI ID 
and most likely non-working".

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

