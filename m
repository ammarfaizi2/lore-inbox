Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVC2Gfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVC2Gfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVC2Gf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:35:29 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:61796 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262278AbVC2GeB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:34:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] Re: [RFC] Some thoughts on device drivers and sysfs
Date: Tue, 29 Mar 2005 01:33:58 -0500
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, Adam Belay <abelay@novell.com>,
       linux-kernel@vger.kernel.org
References: <1111951499.3503.87.camel@localhost.localdomain> <20050329050345.GB7937@kroah.com>
In-Reply-To: <20050329050345.GB7937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503290133.59002.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 00:03, Greg KH wrote:
> On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> > One of the original design goals of sysfs was to provide a standardized
> > location to keep driver configuration attributes.  Although sysfs
> > handles this very well for bus devices and class devices, there isn't
> > currently a method to export attributes for device drivers and their
> > specific bound device instances to userspace.
> 
> Hm, what's device_create_file(), device_remove_file(), and DEVICE_ATTR()
> for?  A number of drivers use these functions today to add their own
> driver specific attributes to a device they control.
> 
> Then, userspace can just do a simple:
>         ls /sys/bus/pci/drivers/my_foo_driver/
> to see all devices on the PCI bus that are controlled by that driver.
> Then it can go into those directories and cat out the specific
> information if needed.

It probably would be nice if all driver-specific device attributes would be
grouped under /sys/devices/.../<blah_device>/drvattr/* so their names would
not clash with names of driver core attributes.

Unfortunately that would mean we are breaking userspace again...

-- 
Dmitry
