Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271575AbSISQoa>; Thu, 19 Sep 2002 12:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271581AbSISQo3>; Thu, 19 Sep 2002 12:44:29 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:47113 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271575AbSISQo3>;
	Thu, 19 Sep 2002 12:44:29 -0400
Date: Thu, 19 Sep 2002 09:49:24 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Brad Hards <bhards@bigpond.net.au>, Duncan Sands <duncan.sands@wanadoo.fr>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.26 hotplug failure
Message-ID: <20020919164924.GB15956@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rvs3-0000uN-00@starship> <20020919074844.GC13487@kroah.com> <E17rwAI-0000vM-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17rwAI-0000vM-00@starship>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 09:55:57AM +0200, Daniel Phillips wrote:
> On Thursday 19 September 2002 09:48, Greg KH wrote:
> > On Thu, Sep 19, 2002 at 09:37:07AM +0200, Daniel Phillips wrote:
> > > On Wednesday 18 September 2002 18:55, Greg KH wrote:
> > > > Sorry, but I'm not going to put the file back.  I understand your
> > > > concerns.  We should have some kind of program (lsdev like) that shows
> > > > the system information present at that moment in time.  It will be able
> > > > to provide what the /proc/bus/usb/drivers file showed in the past.
> > > 
> > > How about calling it /proc/bus/usb/drivers?
> > 
> > Please go back and read what I wrote above what you snipped out and then
> > explain how this would be possible.
> 
> I don't get it.  What's the problem?  Not that I'm advocating that proc have
> functionality that can be done perfectly well in user space, but I fail to
> see why you couldn't do it in proc if you wanted to.

First of all, /proc/bus/usb/* is not a proc filesystem, usbfs is mounted
in that location :)

The main reason is this information is no longer available to the USB
core.  It isn't keeping a list of registered drivers anymore, only the
driver core is.  So there's no way that usbfs can get to that
information.  As the info is available in driverfs, duplication of it in
usbfs would be bloat.

thanks,

greg k-h
