Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDEBAd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTDEBAd (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:00:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15813 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261605AbTDEBAc (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:00:32 -0500
Date: Fri, 4 Apr 2003 17:14:14 -0800
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl, phil@netroedge.com
Subject: Re: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030405011414.GA5697@kroah.com>
References: <20030404021152.GE466@zip.com.au> <20030404171424.GA1380@kroah.com> <20030405005950.GA464@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405005950.GA464@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 10:59:50AM +1000, CaT wrote:
> On Fri, Apr 04, 2003 at 09:14:24AM -0800, Greg KH wrote:
> > So if you disable the I2C config items, everything works just fine?
> 
> Yup.
> 
> > I did send out a bugfix for the i2c code for a problem in 2.5.66, it's
> > now included in the latest -bk tree.  Could you grab that patch and see
> > if it fixes your problem?
> 
> Ok. Running -bk10. Where, umm, is the userspace interface to it? I can't
> find anything in /proc or /sys so I can't see if it's actually working.
> Incase they're useful here are snippets from .config and dmesg:

To a:
	tree /sys/bus/i2c/devices/
to see all of the i2c devices in your system.
Then go in to the directories of those devices to see the sensor values
for the devices.

libsensor support will be forthcoming soon for these changes.

> One question. Will I need ISA support in the kernel for this?

Depends, did you need it before?  :)
I didn't change any of that logic, just where the information the
sensors report has moved locations.

thanks,

greg k-h
