Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWASFcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWASFcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWASFcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:32:52 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43165
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161134AbWASFcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:32:52 -0500
Date: Wed, 18 Jan 2006 21:33:03 -0800
From: Greg KH <greg@kroah.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clarity on kref needed.
Message-ID: <20060119053303.GA21467@kroah.com>
References: <3AEC1E10243A314391FE9C01CD65429B28BF15@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B28BF15@mail.esn.co.in>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:35:37AM +0530, Mukund JB. wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Thursday, January 19, 2006 10:33 AM
> > To: Mukund JB.
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: clarity on kref needed.
> > 
> > 
> > On Thu, Jan 19, 2006 at 10:15:51AM +0530, Mukund JB. wrote:
> > > 
> > > > > I have gone through kref and am planning to implement then 
> > > > in my usb driver.
> > > > 
> > > > What kind of usb driver?
> > > It is a finger print authentication USB driver. it doesn ot do the
> > > authgentication but transports data to the application which really
> > > does some processing.
> > 
> > You shouldn't need a kernel driver for this, it can be done 
> > in userspace
> > with libusb/usbfs, right?
> 
> I mean I will register a char driver. I will just write a simple char
> kernel module to read data from the USB device and zero copy it to the
> userspace application. I guess that is the minimum work we need to do.

You can do that from userspace with libusb/usbfs with no kernel driver
needed.  Why not do that instead?

> Is there any other way using libusb/usbfs in which we can do this
> without a need of USB kernel driver?

Yes, use libusb/usbfs :)

> > > No, I did not find any Documentation/kref.txt.
> > > But I have read about kred in the link below:
> > > 
> > http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Docum
> entation/kref.txt
> > >
> > >Is kref depricated because I find nothing related to it in linux/Documentation/?
> 
> > What kernel version are you looking at?  Look in the kernel source tree
> > from kernel.org.  What kernel tree are you building your driver against.
> 
> I am planning it for 2.6.11.12.

That's a pretty old kernel version, why not use the latest version?

thanks,

greg k-h
