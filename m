Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312405AbSCaUpk>; Sun, 31 Mar 2002 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312425AbSCaUp3>; Sun, 31 Mar 2002 15:45:29 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:51471 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312405AbSCaUpX>;
	Sun, 31 Mar 2002 15:45:23 -0500
Date: Sun, 31 Mar 2002 12:44:39 -0800
From: Greg KH <greg@kroah.com>
To: roms@lpg.ticalc.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subject: kernel 2.5.7, tiusb: SilverLink cable driver for TI graphing calculators
Message-ID: <20020331204439.GA27174@kroah.com>
In-Reply-To: <3CA6E759.CE70B34D@free.fr> <20020331180800.GE26801@kroah.com> <3CA7721B.6D28983D@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 03 Mar 2002 17:26:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 10:31:23PM +0200, Romain Liévin wrote:
> Hi,
> 
> > > this is a new driver for handling a TI-GRAPH LINK USB (aka SilverLink)
> > > cable
> > > designed to connect a Texas Instruments graphing calculators to a
> > > computer/workstation through USB.
> > >
> > > This driver has an official device number.
> > 
> > Do you want to add this driver to the drivers/usb/ directory with the
> > rest of the kernel USB drivers?  If so, please send me a patch.
> 
> Yes, I would like to add it. You will find the complete patch below.

The patch has lines wrapped, so it will not apply.  Can you fix this and
send it again?

> I do not know whether it's the best thing to do. The 2 others use the
> same bit-banging scheme and could be grouped under a sub-system (such as
> I2C). The USB module is different. Maybe it's better to register it
> under the USB sub-system...

It's up to you.  But in looking at the driver some more, is there any
reason it has to be in kernel space?  Can't you do everything you need
from userspace and use usbfs (or libusb) to talk to the device?

thanks,

greg k-h
