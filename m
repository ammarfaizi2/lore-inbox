Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSITHjN>; Fri, 20 Sep 2002 03:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbSITHjN>; Fri, 20 Sep 2002 03:39:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45033 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261264AbSITHjM>;
	Fri, 20 Sep 2002 03:39:12 -0400
Date: Fri, 20 Sep 2002 09:44:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Meelis Roos <mroos@linux.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: compile error in pre7-ac2: usb & input
Message-ID: <20020920094407.A79476@ucw.cz>
References: <Pine.LNX.4.44.0209191555240.1928-100000@ondatra.tartu-labor> <200209200709.20787.bhards@bigpond.net.au> <20020920090955.B79295@ucw.cz> <200209201727.10324.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209201727.10324.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Fri, Sep 20, 2002 at 05:27:10PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 05:27:10PM +1000, Brad Hards wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 20 Sep 2002 17:09, Vojtech Pavlik wrote:
> > On Fri, Sep 20, 2002 at 07:09:20AM +1000, Brad Hards wrote:
> > > On Thu, 19 Sep 2002 23:54, Vojtech Pavlik wrote:
> > > > On Thu, Sep 19, 2002 at 04:04:08PM +0300, Meelis Roos wrote:
> > > > > drivers/usb/usbdrv.o: In function `hidinput_hid_event':
> > > > > drivers/usb/usbdrv.o(.text+0x11573): undefined reference to
> > > > > `input_event' drivers/usb/usbdrv.o(.text+0x115ee): undefined
> > > > > reference to `input_event' drivers/usb/usbdrv.o(.text+0x11600):
> > > > > undefined reference to `input_event'
> > > > > drivers/usb/usbdrv.o(.text+0x11641): undefined reference to
> > > > > `input_event' drivers/usb/usbdrv.o(.text+0x11664): undefined
> > > > > reference to `input_event' drivers/usb/usbdrv.o(.text+0x11682): more
> > > > > undefined references to `input_event' follow drivers/usb/usbdrv.o: In
> > > > > function
> > > > > `hidinput_connect':
> > > > > drivers/usb/usbdrv.o(.text+0x118d4): undefined reference to
> > > > > `input_register_device' drivers/usb/usbdrv.o: In function
> > > > > `hidinput_disconnect':
> > > > > drivers/usb/usbdrv.o(.text+0x118f3): undefined reference to
> > > > > `input_unregister_device'
> > > >
> > > > Well, you enabled HID as built-in and Input as modular. HID needs
> > > > Input.
> > >
> > > Not quite. CONFIG_USB + CONFIG_USB_HIDDEV doesn't need input.
> > > Unfortunately CONFIG_USB_HIDINPUT does, and it is a dep_bool.
> > > The only clean way I can see is to build HID as three seperate modules -
> > > a core, the input interface, and the hiddev interface.  Even that is
> > > pretty ugly.
> >
> > More modules, oh no!
> Hmmm. You could always build part of the input layer into the kernel 
> unconditionally (like the old keyboard handling code?). Not nice on some 
> embedded applications, though you could probably build an "input.o" that is a 
> bit smaller.
> Or a version of the "unconditional build" based on some setup determined after 
> the config step.
> I'm still looking for a better idea - got any?

As of current 2.5 input.o is always built in. (Since CONFIG_INPUT is defined to Y).

-- 
Vojtech Pavlik
SuSE Labs
