Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSFXRgK>; Mon, 24 Jun 2002 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSFXRgJ>; Mon, 24 Jun 2002 13:36:09 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:11596 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S314529AbSFXRgH>; Mon, 24 Jun 2002 13:36:07 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'David Brownell'" <david-b@pacbell.net>
Cc: "'Nick Bellinger'" <nickb@attheoffice.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: RE: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map
	)
Date: Mon, 24 Jun 2002 10:35:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Brownell [mailto:david-b@pacbell.net] 
> > Is the device PHYSICALLY hooked up to the computer? If not, 
> it shouldn't be
> > in devicefs.
> What's "devicefs" -- some new filesystem?  Or a mis/re-naming 
> of "driverfs"?
> I assume you don't mean "devfs".

Yep I meant driverfs. Oops.

> > The device tree (for which devicefs is the fs 
> representation) was originally
> > meant to enable good device power management and configuration. 
> 
> Surely a driver using IP-over-wire like iSCSI is no less 
> deserving of appearing
> in "driverfs" than one whose driver uses 
> custom-protocol-over-a-"wire" like USB,
> FireWire, FC, IR, SCSI, or Bluetooth?  I don't see why some 
> disks (for example)
> should deserve to be "more equal than others" -- and approved 
> to be in driverfs.

It's a matter of where to draw the line. Obviously when we're talking
physical devices, my tcpip connection to www.yahoo.com is not one. My PS/2
port is. I actually think keeping in mind that driverfs is for power
management can help delineate what should be in driverfs and what shouldn't.
With technologies like USB, infiniband, NFS, iSCSI, and 1394, it's tough,
but the main question should be:

"If my computer suspends, should this device be turned off?" Which is
another way of asking is the use of a device exclusive to a particular
machine.

If a device can be accessed by multiple machines concurrently, it should not
be in driverfs.

> No, of course driverfs isn't for everything.  But if it's not 
> for all drivers,
> then what's it for -- just power management?

"Just" power management??? Like power management isn't important enough???
;-)

We need a device tree to do PM. If driverfs's PM capabilities are hurt
because it doesn't stay true to that, then the featureitis has gone too far.

Regards -- Andy
