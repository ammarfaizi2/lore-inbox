Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUBLBVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUBLBVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:21:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:25772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266293AbUBLBVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:21:23 -0500
Date: Wed, 11 Feb 2004 17:19:46 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 016 release
Message-ID: <20040212011946.GC15983@kroah.com>
References: <20040203201359.GB19476@kroah.com> <1075844602.7473.75.camel@nosferatu.lan> <20040211221324.GC14231@kroah.com> <1076538429.22542.12.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076538429.22542.12.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 12:27:09AM +0200, Martin Schlemmer wrote:
> On Thu, 2004-02-12 at 00:13, Greg KH wrote:
> > On Tue, Feb 03, 2004 at 11:43:22PM +0200, Martin Schlemmer wrote:
> > > On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> > > 
> > > Once again, patch to make logging a config option.
> > > 
> > > Reason for this (since you asked for it =):
> > > - In our setup it is easy (although still annoying) .. just
> > > edit the ebuild, add logging support (or remove it) and rebuild.
> > > For say a binary distro, having the logging is useful for debugging
> > > some times, but its more a once of, or rare thing, as you do not
> > > add or change config files every day.  Sure, we can have logging
> > > by default, but many do not want ~300 lines of extra debugging in
> > > their logs is not pleasant, and they will complain.  Rebuilding
> > > the package for that binary package (given the users it is targeted
> > > to) is usually not within most users grasp.
> > 
> > Ok, I applied this patch.
> > 
> > And then I went back and fixed it so it actually would work :(
> > 
> > Here's the changes I had to make to get everything to build properly,
> > and to let us have a boolean type for the config files.
> > 
> 
> Interest sake ... when did it actually fail?  (When linking with
> klibc maybe?  Been using here without problems).

Did you build udevinfo?  udevsend?  udevd?  None of those files ended up
including the udev_log_* variable.

Anyway, it's cleaner this way :)

thanks,

greg k-h
