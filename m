Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbULPVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbULPVMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbULPVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:12:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:62344 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262028AbULPVMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:12:02 -0500
Date: Thu, 16 Dec 2004 13:11:37 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 start_udev very slow
Message-ID: <20041216211137.GA9475@kroah.com>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <200411171932.47163.andrew@walrond.org> <20041216155643.GB27421@kroah.com> <200412162057.25244.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412162057.25244.andrew@walrond.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 08:57:25PM +0000, Andrew Walrond wrote:
> On Thursday 16 Dec 2004 15:56, Greg KH wrote:
> > On Wed, Nov 17, 2004 at 07:32:47PM +0000, Andrew Walrond wrote:
> > > I noticed that when upgrading from 2.6.8.1 to rc2, start_udev now takes
> > > 10-15s after printing
> > >
> > > "Creating initial udev device nodes:"
> >
> > udevstart should be used instead of start_udev.  It goes a lot faster
> > and fixes odd startup dependancies that are needed.
> 
> I'm using 048 at the moment. Works great, but if I replace start_udev with 
> udevstart in my init scripts as you suggest, it all goes horribly wrong...
> 
> udevstart is just a symlink to udev, but start_udev is a script which:
>  - mounts ramfs
>  - runs udevstart
>  - makes some extra nodes not exported by sysfs (stdin/out/err)

Then I don't really know what to recommend.  As the udev startup logic
is very tightly tied to how the distro is set up, I recommend using
whatever they do, and ignore what I say :)

> So I guess I need to migrate this functionality to my init system before I can 
> call udevstart directly.

I'd suggest just leaving it alone.

> 
> Is that list of  'extra nodes not exported by sysfs likely to change?'

What does that list contain?

thanks,

greg k-h
