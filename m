Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316516AbSEUTmZ>; Tue, 21 May 2002 15:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSEUTmY>; Tue, 21 May 2002 15:42:24 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:51597 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316516AbSEUTmW>; Tue, 21 May 2002 15:42:22 -0400
Message-Id: <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 May 2002 12:41:39 -0700
To: greg KH <greg@kroah.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: RE: What to do with all of the USB UHCI drivers in the kernel ?
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

I'm gonna speak for Bluetooth USB devices.
I do have bunch of things like Kodak digi camera, Sony DV camcorder, CF 
reader, etc. But they don't
seem to care much about which HCD is used and work equally well with both 
usb-uhci and uhci drivers.

I used to be a uhci driver fan :). But starting somewhere from 2.4.16 or so 
Bluetooth devices work much better
with usb-uhci driver (not all devices but most of them). Even thought 
Bluetooth is pretty slow (about 700kbps)
performance difference is sometimes pretty significant 20-30% (ie usb-uhci 
driver is faster).

So basically I vote for usb-uhci. However some things will have to be 
fixed. We (Bluetooth folks) have couple
of devices that refuse to work with usb-uhci (I didn't test the latest 
usb-uhci though).

Thanks
Max

>Ok, now that 2.5.16 is out, we have a total of 4 different USB UHCI
>controller drivers in the kernel!  That's about 3 too many for me :)
>
>So what to do?  I propose the following:
>
>   From now until July 1, I want everyone to test out both the uhci-hcd
>   and usb-uhci-hcd drivers on just about every piece of hardware they
>   can find.  This includes SMP, UP, preempt kernels, big and little
>   endian machines, and loads of different types of USB devices.
>
>   (Note, for those who don't realize it, the uhci-hcd driver is based
>   off of the uhci.c driver, and the usb-uhci-hcd driver is based off of
>   the usb-uhci.c driver.  Both of these drivers now use the USB HCD
>   interface, hopefully reducing some code complexity and size because of
>   this.  So this means that the uhci.c and usb-uhci.c drivers are
>   going to go away, just like the usb-ohci.c driver did in 2.5.16.)
>
>   Let me (and the linux-usb-devel list) know about any thoughts you have
>   pertaining to liking one of the drivers over the other one.  Speed
>   tests, size tests, code pretty tests, comment spelling tests,
>   documentation tests, you name it, I want to know about it.  If you
>   don't want your comments to be public, send them to me directly and I
>   will not let anyone else know what you said, but will use the info to
>   try to pick which one should stay.
>
>   I will be doing the same thing (running speed tests, and hardware
>   tests) and will be publishing those results on the linux-usb-devel
>   list for others to verify.
>
>   Then, the week of July 1, I will be taking everyone's comments and
>   making a decision about which driver to keep.
>
>thanks,
>
>greg k-h



Max

http://bluez.sf.net
http://vtun.sf.net

