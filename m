Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVHPXJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVHPXJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVHPXJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:09:22 -0400
Received: from soundwarez.org ([217.160.171.123]:5076 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750719AbVHPXJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:09:21 -0400
Date: Wed, 17 Aug 2005 01:09:20 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: udev-067 and 2.6.12?
Message-ID: <20050816230920.GA11750@vrfy.org>
References: <200508162302.00900.s0348365@sms.ed.ac.uk> <20050816220544.GA28377@kroah.com> <200508162312.26972.s0348365@sms.ed.ac.uk> <20050816221450.GA28520@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816221450.GA28520@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 03:14:50PM -0700, Greg KH wrote:
> On Tue, Aug 16, 2005 at 11:12:26PM +0100, Alistair John Strachan wrote:
> > On Tuesday 16 August 2005 23:05, Greg KH wrote:
> > > On Tue, Aug 16, 2005 at 11:02:00PM +0100, Alistair John Strachan wrote:
> > > > Hi,
> > > >
> > > > I just tried upgrading udev 053 to 067 on a 2.6.12 system and although
> > > > the system booted, firmware_class failed to upload the firmware for my
> > > > wireless card, prism54 was no longer auto loaded, etc. Even manually
> > > > loading the driver didn't help.
> > > >
> > > > Any reason why 067 wouldn't work with 2.6.12? Do you have to do something
> > > > special with hotplug prior to upgrading?
> > >
> > > What distro are you using?  What rules file are you using?
> > >
> > > 067 should work just fine for you, it is for a lot of Gentoo and SuSE
> > > users right now, on 2.6.12.
> > >
> > 
> > An LFS from April 05, with the stock 50-udev.rules, 25-lfs.rules (which 
> > doesn't do anything suspicious, I think; certainly nothing related to my 
> > problem).
> 
> There are no "stock" udev rules anymore.  That's probably the issue, all
> of the distros made their own, so we provide them in the tarball.  I
> suggest you talk to the LFS people about this.
> 
> > 25-lfs.rules does duplicate some of the things in 50-udev.rules, but I think 
> > that's deliberate (they want to interfere with the stock install as little as 
> > possible, and the overrides take precedence). I've put my /etc/udev directory 
> > unmodified up here:
> > 
> > http://devzero.co.uk/~alistair/udev/
> 
> s/=/==/ for most of your rules and see if that works.
> 
> > If I reinstall 053 and reboot, everything that's broken on 067 works again. Do 
> > you need a specific hotplug installed?

Do you provide hooks for handling /etc/hotplug.d/? We are on the way of
getting rid of that directory and recent udev versions don't handle
that by default anymore. If you don't know, read the udev RELEASE-NOTES.

Kay
