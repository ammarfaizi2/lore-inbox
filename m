Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270342AbTG1Qrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270345AbTG1Qrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:47:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:52414 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270342AbTG1Qrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:47:41 -0400
Date: Mon, 28 Jul 2003 10:03:09 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030728170308.GA4839@kroah.com>
References: <200307262036.13989.arvidjaar@mail.ru> <20030726165056.GA3168@kroah.com> <200307282044.43131.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307282044.43131.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 08:44:43PM +0400, Andrey Borzenkov wrote:
> On Saturday 26 July 2003 20:50, Greg KH wrote:
> > On Sat, Jul 26, 2003 at 08:36:13PM +0400, Andrey Borzenkov wrote:
> > > So apparently I cannot rely on sysfs to get reliable persistent
> > > information about physical location of devices.
> >
> > That is correct, but you can get pretty close :)
> >
> 
> sure, I know. The more annoying is how difficult is to step over this "close" 
> :)

The kernel isn't going to do this.  It's a user space issue.

> > > the point is - I want to create aliases that would point to specific
> > > slots. I.e. when I plug USB memory stick in upper slot on front panel I'd
> > > like to always create the same device alias for it.
> >
> > Look at the udev announcement I posted to linux-kernel yesterday to see
> > how to do this.
> >
> 
> I know udev.
> 
> udev does not answer my question. It operates on logical device (bus) numbers. 
> My question was how to name devices based on physical position 
> *independently* of logical numbers they get.

You don't know udev then :)
This is exactly what udev solves.  Please read the paper I posted a link
to, it should answer your questions.

> Question: how to configure udev so that "database" always refers to LUN 0 on 
> target 0 on bus 0 on HBA in PCI slot 1.

If you can't rely on scsi position, then you need to look for something
that uniquely describes the device.  Like a filesystem label, or a uuid
on the device.  udev can handle this (well I'm still working on the
filesystem label, but others have already done the hard work for that to
be intregrated easily.)

thanks,

greg k-h
