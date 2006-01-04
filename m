Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWADQiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWADQiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWADQiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:38:22 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:1245 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751589AbWADQiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:38:21 -0500
Date: Wed, 4 Jan 2006 08:38:44 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Gottfried Haider <gohai@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-ID: <20060104163844.GA1328@suse.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051222011320.GL3917@stusta.de> <20051222005209.0b1b25ca.akpm@osdl.org> <20051222135718.GA27525@stusta.de> <941ACB1D5BFA46A7A2F170BB3C48C9B0@Fibonacci> <20060102160031.GF17398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102160031.GF17398@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 05:00:31PM +0100, Adrian Bunk wrote:
> On Fri, Dec 23, 2005 at 12:50:22PM +0100, Gottfried Haider wrote:
> > >>From: "Gottfried Haider" <gohai@gmx.net>
> > >>Subject: [2.6.15-rc2] 8139too probe fails (pci related?)
> > >According to the report perhaps not a post-2.6.14 regression.
> > >But anyways, this should be better debugged.
> > >
> > >@Gottfried:
> > >Does it work with kernel 2.6.14.4?
> > >Does it work with kernel 2.6.15-rc6?
> > >If it stil fails, can you send a complete dmesg for 2.6.15-rc6?
> > I recently played around with this particular system, and it turned out 
> > that moving the 8139b-card to another PCI slot fixed it. (works now in both 
> > 2.6.15-rc2 and rc6-git2)
> > So I guess it's just a particular oddity of this system, as noone else 
> > seems to hit this?
> > 
> > 
> > the original lines in kern.log were
> > -- snip --
> > PCI quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
> > PCI quirk: region ec00-ec3f claimed by ICH4 GPIO
> > PCI: Unable to handle 64-bit address for device 0000:01:0c.0
> > PCI: Transparent bridge - 0000:00:1e.0
> > (..)
> > PCI: Cannot allocate resource region 0 of device 0000:01:0c.0
> > PCI: Cannot allocate resource region 3 of device 0000:01:0c.0
> > pnp: 00:03: ioport range 0xe400-0xe47f could not be reserved
> > pnp: 00:03: ioport range 0xec00-0xec3f has been reserved
> > PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
> > PCI: Error while updating region 0000:01:0c.0/3 (fa800800 != 00000810)
> > PCI: Error while updating region 0000:01:0c.0/0 (0000d001 != 813910fc)
> > PCI: Bridge: 0000:00:1e.0
> > (..)
> > 8139too Fast Ethernet driver 0.9.27
> > PCI: Device 0000:01:0c.0 not available because of resource collisions
> > Trying to free nonexistent resource <0000d000-0000d003>
> > Trying to free nonexistent resource <fa800800-fa80080f>
> > 8139too: probe of 0000:01:0c.0 failed with error -22
> > -- snip --
> > .. on a ASUS CUSL2 (i815E) motherboard that was, no change when using 
> > pci=routeirq or pci=noacpi.
> 
> Greg, can you comment on this issue?

I have no idea, sorry.  Glad it's working for you now :)

greg k-h
