Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311879AbSCOAug>; Thu, 14 Mar 2002 19:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311882AbSCOAu0>; Thu, 14 Mar 2002 19:50:26 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:41398 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S311879AbSCOAuV>; Thu, 14 Mar 2002 19:50:21 -0500
Message-Id: <200203150050.g2F0oR615927@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Greg KH <greg@kroah.com>
Subject: Re: USB-Storage in 2.4.19-pre
Date: Fri, 15 Mar 2002 02:50:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il> <200203142321.g2ENL1632499@lmail.actcom.co.il> <20020314152617.B3109@kroah.com>
In-Reply-To: <20020314152617.B3109@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 01:26 am, Greg KH wrote:
> On Fri, Mar 15, 2002 at 01:20:49AM +0200, Itai Nahshon wrote:
> > No go. I still get that device not responding (error=-84).
> > If I understand your patch, disabling hotplug and loading
> > usb-storage manually shoud work. It isn't. Actually
> > I believe that it never got to call hotplug.
> > usbview does not see the device.
>
> No the main problem is that usbmodules starts talking to the device
> before it is initialized properly by the kernel driver, causing both
> programs to get messed up, and then the device is usually in a
> uninitialized state.
>
> > I forgot to say. On one of those computers where I do the testing
> > I have a USB mouse - which is working just fine.
>
> Does that mouse work if you plug it into the same port that you are
> plugging the drive into?  I have noticed a lot more errors from flaky
> hubs with the new code.
>
> thanks,
>
> greg k-h

That's on an ASUS CUV4X with 4 USB ports on the main board. Moving
things between ports do not make a difference - the mouse still works
and the disk does not. Perhaps the the flaky part i s the USB port in the
disk side. I could never make it work thru a hub - but then
it initialized correctly and failed only during data transfer.

I just put a scanner on he same system. The scanner is working OK
where the disk has failed.

Again, I do not see the disk usind usbview (or in /proc/bus/usb/devices)
so I believe the problem is more with detection than with initialization.

-- Itai



