Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbSIYV57>; Wed, 25 Sep 2002 17:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbSIYV56>; Wed, 25 Sep 2002 17:57:58 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:39685 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S262103AbSIYV56>; Wed, 25 Sep 2002 17:57:58 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8C0@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: greg@kroah.com
cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: devicefs requests
Date: Wed, 25 Sep 2002 17:03:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 118CED171299169-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But what do you do with the usb_bus_type?  Why would your code use
> anything that is private to the driver core?

Fair enough.  I actually only need the 64-bit unique ID that the USB device
provides, and its parent PCI device.  EDD provides this info as x86 BIOS
sees it, so my code compares the two, and will make a symlink between the
two.  This lets the OS know which device BIOS thinks it is (i.e. to know
what disk you're booting from).

True, I don't (today) see a unique ID in struct usb_device.  Hopefully
that's something that can be added in the future.  Functions which expose
this info separate from exporting the bus type would be great.

SCSI has a different set of things that EDD needs exported (channel, id,
lun).  IDE still different (channel, number (master/slave)), plus parent PCI
device.

> Oh yeah, it's "driverfs" not "devicefs"  :)

Yes, my bad.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

