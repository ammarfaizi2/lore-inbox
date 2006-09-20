Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWITCar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWITCar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWITCar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:30:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:6070 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750740AbWITCaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:30:46 -0400
Date: Tue, 19 Sep 2006 19:28:32 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1: networking breakage on HPC nx6325 + SUSE 10.1
Message-ID: <20060920022832.GA24577@kroah.com>
References: <20060919133606.f0c92e66.akpm@osdl.org> <20060919.150629.109607267.davem@davemloft.net> <20060919223015.GA23088@kroah.com> <200609200056.57858.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609200056.57858.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 12:56:57AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, 20 September 2006 00:30, Greg KH wrote:
> > On Tue, Sep 19, 2006 at 03:06:29PM -0700, David Miller wrote:
> > > From: "Rafael J. Wysocki" <rjw@sisk.pl>
> > > Date: Wed, 20 Sep 2006 00:06:52 +0200
> > > 
> > > > I _guess_ the problem is caused by
> > > > gregkh-driver-network-class_device-to-device.patch, but I can't verify this,
> > > > because the kernel (obviously) doesn't compile if I revert it.
> > > 
> > > Indeed.
> > > 
> > > I thought we threw this patch out because we knew it would cause
> > > problems for existing systems?  I do remember Greg making an argument
> > > as to why we needed the change, but that doesn't make breaking people's
> > > systems legitimate in any way.
> > 
> > It's now thrown out, and I think Andrew already had a patch in his tree
> > that reverted this.
> > 
> > I'll be bringing it back eventually, but first we are going to work out
> > all the kinks by probably putting these changes in the next few SuSE
> > alpha releases to see what shakes out in userspace that we need to go
> > fix.
> > 
> > It's not 2.6.19 material at all, so don't worry :)
> 
> Please note, however, that by including such changes in -mm we make _other_
> things be not tested.
> 
> For example, if I can't install a new kernel and use it on my system without
> replacing some other pieces of software, I just won't be using it, because I
> have no time for playing with udev, hal, powersaved, acpid, ...
> Then, if there are any bugs in it that would have shown up on my system,
> we won't know about them unless they show up on someone else's system,
> which may not happen.
> 
> The more changes that break existing setups are there in -mm, the less
> people will acutally try to use -mm kernels and that will result in buggier
> -rc kernels and more bugs propagating to the "stable" ones.  Do we really
> want that to happen?

When it comes back, I will have updates for all versions of broken udev
packages so that it will not break older distros.  Then it will be able
to be tested.

thanks,

greg k-h
