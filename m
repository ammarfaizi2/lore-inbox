Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWGZQVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWGZQVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWGZQVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:21:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28114 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751057AbWGZQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:21:13 -0400
Date: Wed, 26 Jul 2006 09:16:47 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726161647.GA9675@kroah.com>
References: <20060725203028.GA1270@kroah.com> <44C6B881.7030901@s5r6.in-berlin.de> <20060726073132.GE6249@suse.de> <20060726112948.GA13490@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726112948.GA13490@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 05:29:48AM -0600, Matthew Wilcox wrote:
> On Wed, Jul 26, 2006 at 12:31:32AM -0700, Greg KH wrote:
> > I don't know enough about SCSI to say if this driver core patch will
> > help them out or not.  At first glance it does, but the device order
> > gets all messed up from what users are traditionally used to, so perhaps
> > the scsi core will just have to stick with their own changes.
> 
> Right.  Networking is in the same boat ... unless they're using udev
> or some other tool which renames network interfaces.  I'm not entirely
> comfortable with the kernel forcing you to use some other tool in order
> to maintain stable device names on a static setup.

I agree.

However, almost all distros now use persistant names for network devices
due to the PCI Hotplug issue, so it isn't probably as bad as you might
think.

> Perhaps we need either a CONFIG option or a boot option to decide
> whether to do parallel pci probes.

Oh yeah, it will be probably both of them :)

> I still think we need a method of renaming block devices, but haven't
> looked into it in enough detail yet.

That could get "interesting"...

But now that we all are using /dev/disk/ and it has persistant device
names for block devices, I really don't think it's that big of a deal.

thanks,

greg k-h
