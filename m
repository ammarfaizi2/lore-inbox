Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273730AbSISXBz>; Thu, 19 Sep 2002 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273732AbSISXBz>; Thu, 19 Sep 2002 19:01:55 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:26122 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273730AbSISXBy>;
	Thu, 19 Sep 2002 19:01:54 -0400
Date: Thu, 19 Sep 2002 16:06:44 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.26 hotplug failure
Message-ID: <20020919230643.GD18000@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com> <200209200656.23956.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209200656.23956.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 06:56:23AM +1000, Brad Hards wrote:
> On Fri, 20 Sep 2002 02:49, Greg KH wrote:
> > The main reason is this information is no longer available to the USB
> > core.  It isn't keeping a list of registered drivers anymore, only the
> > driver core is.  So there's no way that usbfs can get to that
> > information.  As the info is available in driverfs, duplication of it in
> > usbfs would be bloat.
> This doesn't follow. driverfs != driver core, just as usbfs != USB core.

I agree.  But the info is now in the driver core, it's not present in
the USB core at all anymore.  So since drverfs exports what's in the
driver core, that info shows up there.  usbfs doesn't have access to
this info, so it can't display it.

> I wasn't joking about putting back the /proc/bus/usb/drivers file. This is 
> really going to hurt us in 2.6. 

Is this file _really_ used?  All it did was show the USB drivers
registered.  Even so, that same information is now present in driverfs,
I haven't taken away anything, just moved it.  Lots of things are
starting to move to driverfs, this isn't the first, and will not be the
last.

thanks,

greg k-h
