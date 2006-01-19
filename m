Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWASHJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWASHJD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWASHJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:09:02 -0500
Received: from [202.125.80.34] ([202.125.80.34]:53714 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1161056AbWASHJB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:09:01 -0500
Subject: RE: clarity on kref needed.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 19 Jan 2006 12:30:40 +0530
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B28BF3C@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clarity on kref needed.
Thread-Index: AcYcuVQcIv9WWkYVSZi4eTJnrpJ8+gADIMBg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you give me some pointers & documentation links for HOWTO using libusb/usbfs instead of a kernel driver.

Regards,
Mukund Jampala

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Thursday, January 19, 2006 11:03 AM
> To: Mukund JB.
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: clarity on kref needed.
> 
> 
> On Thu, Jan 19, 2006 at 10:35:37AM +0530, Mukund JB. wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Thursday, January 19, 2006 10:33 AM
> > > To: Mukund JB.
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: Re: clarity on kref needed.
> > > 
> > > 
> > > On Thu, Jan 19, 2006 at 10:15:51AM +0530, Mukund JB. wrote:
> > > > 
> > > > > > I have gone through kref and am planning to implement then 
> > > > > in my usb driver.
> > > > > 
> > > > > What kind of usb driver?
> > > > It is a finger print authentication USB driver. it 
> doesn ot do the
> > > > authgentication but transports data to the application 
> which really
> > > > does some processing.
> > > 
> > > You shouldn't need a kernel driver for this, it can be done 
> > > in userspace
> > > with libusb/usbfs, right?
> > 
> > I mean I will register a char driver. I will just write a 
> simple char
> > kernel module to read data from the USB device and zero 
> copy it to the
> > userspace application. I guess that is the minimum work we 
> need to do.
> 
> You can do that from userspace with libusb/usbfs with no kernel driver
> needed.  Why not do that instead?
> 
> > Is there any other way using libusb/usbfs in which we can do this
> > without a need of USB kernel driver?
> 
> Yes, use libusb/usbfs :)
> 
> > > > No, I did not find any Documentation/kref.txt.
> > > > But I have read about kred in the link below:
> > > > 
> > > http://developer.osdl.org/dev/robustmutexes/src/fusyn.hg/Docum
> > entation/kref.txt
> > > >
> > > >Is kref depricated because I find nothing related to it 
> in linux/Documentation/?
> > 
> > > What kernel version are you looking at?  Look in the 
> kernel source tree
> > > from kernel.org.  What kernel tree are you building your 
> driver against.
> > 
> > I am planning it for 2.6.11.12.
> 
> That's a pretty old kernel version, why not use the latest version?
> 
> thanks,
> 
> greg k-h
> 
