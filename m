Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbQKFXyf>; Mon, 6 Nov 2000 18:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130297AbQKFXy1>; Mon, 6 Nov 2000 18:54:27 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:529 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130211AbQKFXyN>; Mon, 6 Nov 2000 18:54:13 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC46@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: USB init order dependencies.
Date: Mon, 6 Nov 2000 15:53:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> > While Jeff and I basically agree on the short-term
> > solution (if one is still needed, altho I'm not aware of
> > any init order problems in USB in 2.4.0-test10), my
> > recollection of Linus's preference (without
> > looking it up) is to remove the calls from init/main.c
> > and to use __initcalls.
> 
Russell King wrote:
> The problem for ARM is that Linux does a lot of the initialisation for
> some machines,

but not for ARM ?

> which basically means the hardware isn't setup 
> for access
> to the USB device if the USB initialisation was placed in init/main.c
> (this initialisation is done by the very first initcall on 
> ARM).  However,
> that said, we may be able to get away with only adding 
> hw_sa1100_init()
> before the USB call, but this is only one family of the ARM 
> machine types.

I'm not following your argument very well.  I've read it
and reread it several times.
Does adding a call to usb_init() in init/main.c cause
USB to be init 2 times?
I'm not complaining or arguing against you, just
trying to understand better.

> BTW, I've long lost track of what the original problem that 
> sparked off
> this thread was, does someone have a quick reference to it?  (please
> reply in private mail).  Thanks.

There were several threads but I can't find the
"original" one right now.  IIRC, it was simply that
CONFIG_USB=y and CONFIG_USB_*=m (any USB except usbcore
built as modules) caused depmod problems, but that could
be incorrect also.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
