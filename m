Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311220AbSCQA0D>; Sat, 16 Mar 2002 19:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311221AbSCQAZy>; Sat, 16 Mar 2002 19:25:54 -0500
Received: from 12-249-40-19.client.attbi.com ([12.249.40.19]:30995 "EHLO
	rekl.dyn.dhs.org") by vger.kernel.org with ESMTP id <S311220AbSCQAZj>;
	Sat, 16 Mar 2002 19:25:39 -0500
Date: Sat, 16 Mar 2002 18:25:30 -0600 (CST)
From: rob1@rekl.yi.org
X-X-Sender: rob1@rekl.dyn.dhs.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IP Autoconfig doesn't work for USB network devices
In-Reply-To: <20020315230131.GC5563@kroah.com>
Message-ID: <Pine.LNX.4.40.0203161810290.16559-100000@rekl.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You don't mention which kernel version you are using, what one are you
> using?

2.4.18.

I tried the suggestion in this thread:
   http://marc.theaimsgroup.com/?l=linux-kernel&m=100912381726661&w=2

It made no difference.  I also looked through the messages on
linux-usb-devel, but they seem to be more related to having USB floppies
or USB hard drives recognized, instead of network cards, which I believe
is my problem.  The kernel decides that there aren't any network devices,
so it doesn't do IP autoconfiguration, which is how it does NFS root in my
case.

In the output while booting, after it says:

Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Insert root floppy and press ENTER
hub.c: USB new device connect on bus2/1, assigned device number 2
pegasus.c: eth0: D-Link DSB-650


There is no perceptible delay between these messages, so it seems like the
code to detect the USB devices executes after the IP autoconfig section,
which is what is preventing this from working.

Is this a topic that should be discussed on one of the linux-usb lists
instead of linux-kernel?

Thanks.


On Fri, 15 Mar 2002, Greg KH wrote:

> On Thu, Mar 14, 2002 at 08:29:54PM -0600, rob1@rekl.yi.org wrote:
> >
> > Is there any way to get the USB network device recognized before IP
> > autoconfig is executed?
>
> You don't mention which kernel version you are using, what one are you
> using?
>
> You might try the patches mentioned in this thread:
> 	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101501210231463
> as it seems that the problem is your device is not seen by the USB
> subsystem before the network code starts up.
>
> greg k-h
>

