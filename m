Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266121AbUGTT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbUGTT1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUGTTYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:24:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63911 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266158AbUGTTXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:23:45 -0400
Date: Tue, 20 Jul 2004 21:23:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nathan Bryant <nbryant@optonline.net>, linux-scsi@vger.kernel.org,
       random1@o-o.yi.org, Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
Message-ID: <20040720192341.GB9461@atrey.karlin.mff.cuni.cz>
References: <40FD38A0.3000603@optonline.net> <20040720155928.GC10921@atrey.karlin.mff.cuni.cz> <40FD4CFA.6070603@optonline.net> <20040720174611.GI10921@atrey.karlin.mff.cuni.cz> <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston> <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090350609.2003.9.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 2 comments here:
> > > 
> > >  - The low level bus state (PCI D state for example) and the "linux"
> > > state should be 2 different entities.
> > > 
> > >  - For PCI, we probably want a hook so the arch can implement it's own
> > > version of pci_set_power_state() so that ACPI can use it's own trickery
> > > there.
> > 
> > Ok, so the takeaway message for driver writers is to treat the 
> > pci_dev->suspend() state parameter as an opaque value as far as 
> > possible, and just pass it on to the other layers
> 
> NO ! The exact opposite in fact. I'll work on cleaning that up and
> write some doco this week with Pavel.

Agreed. I do not have strong opinion about Sx or Dx, but it should
be enum or equivalent so it is hard to get wrong. [And not "really
easy to get wrong because noone knows for sure", as it is now].

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
