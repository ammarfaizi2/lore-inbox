Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUJOW1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUJOW1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJOW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:27:32 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:45745 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264443AbUJOWX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:23:28 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Jon Smirl <jonsmirl@gmail.com>
Date: Fri, 15 Oct 2004 15:22:51 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Message-ID: <416FEB4B.9875.2A1DBFE@localhost>
In-reply-to: <9e4733910410151319159482ce@mail.gmail.com>
References: <416FB275.6425.1C3D985@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

> The plan for this in 2.6 is to first write a VGA device driver.
> This driver is responsible for identifying all of the VGA devices
> in a system and ensuring only one of them gets enabled a time. I
> started writing this but I haven't finished. This driver would be
> compiled into the kernel. I can send source if you are interested.

I am interested but I probably wouldn't have the time to look at it right 
now.

> I have added hooks to the PCI subsystem to record the boot video
> device. If the VGA driver finds VGA devices other than the boot
> one it will generate hotplug events on them. Initramfs should
> contain a reset program for using X86 mode to reset these cards. To
> do this you need two things from the kernel: 1) a way to make sure
> only a single VGA device is active (VGA driver, allow you to
> disable the current VGA device, reset the card, restore the active
> VGA device) and 2) a way to get the ROM image. There is a patch in
> -mm that makes the ROMs visible in sysfs that should be in the
> kernel shortly. 
> 
> So, when you first boot you have two choices, 1) use a display the
> boot ROM setup, such as VGAcon or PROMcon. or 2) have no display.
> People want this both ways. VGAcon/PROMcon will let you get output
> very early in the boot process. 

What about non-x86 platforms such as PowerPC and MIPS embedded devices 
that want video (TiVo type platforms, media players etc). How would these 
fit into the picture? Would this require the boot loader (ie: U-Boot or 
whatever) to have the ability to POST the card? 

Or perhaps the VideoBoot module would be a useful addition to the VGA 
boot driver compiled into the kernel to bring up the video card into a 
sane state on any system (even a dumb framebuffer linear mode) so a fully 
accelerated console driver in user space can take over later on?

> Right now I am working on a merged fbdev/DRM that supports
> multi-head adapters. It's turning out to be much more work than I
> though because neither DRM or fbdev handle multihead at the device
> driver level. You can get snapshots of the code at
> mesa3d.bkbits.net but it doesn't work right yet. This driver is
> designed to run after the VGAdriver has reset the hardware. 

Sounds interesting!

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


