Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSIKCOg>; Tue, 10 Sep 2002 22:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSIKCOg>; Tue, 10 Sep 2002 22:14:36 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:1028 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318282AbSIKCOg>;
	Tue, 10 Sep 2002 22:14:36 -0400
Date: Tue, 10 Sep 2002 19:16:10 -0700
From: Greg KH <greg@kroah.com>
To: Nicholas Miell <nmiell@attbi.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: the userspace side of driverfs
Message-ID: <20020911021610.GA24844@kroah.com>
References: <1031707119.1396.30.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031707119.1396.30.camel@entropy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 06:18:37PM -0700, Nicholas Miell wrote:
> - "name" isn't particularly consistent. Sometimes it requires parsing to
> be useful ("PCI device 1234:1234", "USB device 1234:1234", etc.",
> sometimes it's the actual device name, sometimes it's something strange
> like "Hub/Port Status Changes".

The "Hub/Port..." thing will change, I have a large "struct
device_driver" patch for the USB code that is still being worked on
before going into the kernel, and this is changed in that patch..  For
all other "name" files, it's something that makes sense for the device,
and can be parsed by a human.  For some USB devices, they provide device
and manufacturer strings, so that information is provided.  Other
devices do not, so we guess the best that we can.

thanks,

greg k-h
