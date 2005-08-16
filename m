Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbVHPWPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbVHPWPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHPWPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:15:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:50576 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750945AbVHPWPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:15:07 -0400
Date: Tue, 16 Aug 2005 15:14:50 -0700
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev-067 and 2.6.12?
Message-ID: <20050816221450.GA28520@kroah.com>
References: <200508162302.00900.s0348365@sms.ed.ac.uk> <20050816220544.GA28377@kroah.com> <200508162312.26972.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508162312.26972.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 11:12:26PM +0100, Alistair John Strachan wrote:
> On Tuesday 16 August 2005 23:05, Greg KH wrote:
> > On Tue, Aug 16, 2005 at 11:02:00PM +0100, Alistair John Strachan wrote:
> > > Hi,
> > >
> > > I just tried upgrading udev 053 to 067 on a 2.6.12 system and although
> > > the system booted, firmware_class failed to upload the firmware for my
> > > wireless card, prism54 was no longer auto loaded, etc. Even manually
> > > loading the driver didn't help.
> > >
> > > Any reason why 067 wouldn't work with 2.6.12? Do you have to do something
> > > special with hotplug prior to upgrading?
> >
> > What distro are you using?  What rules file are you using?
> >
> > 067 should work just fine for you, it is for a lot of Gentoo and SuSE
> > users right now, on 2.6.12.
> >
> 
> An LFS from April 05, with the stock 50-udev.rules, 25-lfs.rules (which 
> doesn't do anything suspicious, I think; certainly nothing related to my 
> problem).

There are no "stock" udev rules anymore.  That's probably the issue, all
of the distros made their own, so we provide them in the tarball.  I
suggest you talk to the LFS people about this.

> 25-lfs.rules does duplicate some of the things in 50-udev.rules, but I think 
> that's deliberate (they want to interfere with the stock install as little as 
> possible, and the overrides take precedence). I've put my /etc/udev directory 
> unmodified up here:
> 
> http://devzero.co.uk/~alistair/udev/

s/=/==/ for most of your rules and see if that works.

> If I reinstall 053 and reboot, everything that's broken on 067 works again. Do 
> you need a specific hotplug installed?

You shouldn't.

You also might want to take this to the linux-hotplug-devel mailing
list, as that's the proper place for udev issues.

good luck,

greg k-h
