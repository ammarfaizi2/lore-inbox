Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSFYQWp>; Tue, 25 Jun 2002 12:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSFYQWo>; Tue, 25 Jun 2002 12:22:44 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3996 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315544AbSFYQWn>;
	Tue, 25 Jun 2002 12:22:43 -0400
Date: Tue, 25 Jun 2002 09:17:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <200206220629.XAA21506@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0206250908080.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	One thing that is very confusing about the current
> drivers/base code is that "struct bus' really has nothing to do
> with a bus.  It should be called "struct device_type."  For example,
> sd_mod (scsi disk), sr_mod (scsi cdrom), and sg (scsi generic) are
> all drivers for arbitrary scsi devices, regardless of whether
> they are connected by scsi ribbon cable, usb, or whatever.

I assume you're talking about 'struct bus_type'. They're there to 
represent types of buses. There is one or each type of bus. There should 
be one for SCSI, but it doesn't care about what the device type is. 

'struct device_class', which is coming soon, is used to represent types of 
devices, like disks, cdroms, etc. Device classes don't care what bus a 
device resides on. It's the logical interface to the device.

	-pat

