Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273057AbSISVKi>; Thu, 19 Sep 2002 17:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273175AbSISVKi>; Thu, 19 Sep 2002 17:10:38 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:7384 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S273057AbSISVKh>; Thu, 19 Sep 2002 17:10:37 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>
Subject: Re: compile error in pre7-ac2: usb & input
Date: Fri, 20 Sep 2002 07:09:20 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209191555240.1928-100000@ondatra.tartu-labor> <20020919155452.A75192@ucw.cz>
In-Reply-To: <20020919155452.A75192@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209200709.20787.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 19 Sep 2002 23:54, Vojtech Pavlik wrote:
> On Thu, Sep 19, 2002 at 04:04:08PM +0300, Meelis Roos wrote:
> > drivers/usb/usbdrv.o: In function `hidinput_hid_event':
> > drivers/usb/usbdrv.o(.text+0x11573): undefined reference to `input_event'
> > drivers/usb/usbdrv.o(.text+0x115ee): undefined reference to `input_event'
> > drivers/usb/usbdrv.o(.text+0x11600): undefined reference to `input_event'
> > drivers/usb/usbdrv.o(.text+0x11641): undefined reference to `input_event'
> > drivers/usb/usbdrv.o(.text+0x11664): undefined reference to `input_event'
> > drivers/usb/usbdrv.o(.text+0x11682): more undefined references to
> > `input_event' follow drivers/usb/usbdrv.o: In function
> > `hidinput_connect':
> > drivers/usb/usbdrv.o(.text+0x118d4): undefined reference to
> > `input_register_device' drivers/usb/usbdrv.o: In function
> > `hidinput_disconnect':
> > drivers/usb/usbdrv.o(.text+0x118f3): undefined reference to
> > `input_unregister_device'
>
> Well, you enabled HID as built-in and Input as modular. HID needs Input.
Not quite. CONFIG_USB + CONFIG_USB_HIDDEV doesn't need input. Unfortunately 
CONFIG_USB_HIDINPUT does, and it is a dep_bool.
The only clean way I can see is to build HID as three seperate modules - a 
core, the input interface, and the hiddev interface.  Even that is pretty 
ugly.

Brad


- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ij0AW6pHgIdAuOMRAhrHAKCrAJBtMibDOX7nsvAcAArVA3ez6wCfddCe
gh5T86EFQGs5BxasZ51VMIM=
=4DeK
-----END PGP SIGNATURE-----

