Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUBIXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBIXH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:07:57 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:7808 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265353AbUBIXHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:07:55 -0500
Date: Tue, 10 Feb 2004 00:08:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alex <akhripin@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More mouse wheel problems
Message-ID: <20040209230824.GA236@ucw.cz>
References: <20040209172448.GV18567@open-boozeware.mit.edu> <20040209220523.GA827@ucw.cz> <20040209222930.GX18567@open-boozeware.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209222930.GX18567@open-boozeware.mit.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 05:29:31PM -0500, Alex wrote:
> The mouse is in USB in both cases. I'll see if I can dig up my USB <-> PS/2
> converter and try the mouse in PS/2 mode. But in this case, the mouse stayed
> plugged into USB the whole time.

Then you forgot to load the USB drivers and the BIOS is doing
emulation of a PS/2 mouse. That'd explain the wheel problem, too.
You need to load the USB (uhci/ohci-hcd, and hid) drivers.

> -Alex
> 
> On Mon, Feb 09, 2004 at 11:05:23PM +0100, Vojtech Pavlik wrote:
> > On Mon, Feb 09, 2004 at 12:24:48PM -0500, Alex wrote:
> > > Hi,
> > > I know mouse wheel problems have been discussed, but I am still having them
> > > even with the proper fixes. I have a generic-looking IBM optical wheel USB
> > > mouse, Model Number MO28B0 (O's could be zeros and vice versa).
> > > 
> > > In the 2.4 kernels, the USB mouse would register with the following message:
> > > Nov  4 03:53:16 localhost kernel: usb.c: registered new driver usbmouse
> > > Nov  4 03:53:16 localhost kernel: input0: ARROW STRONG USB 3D Mouse on usb1:3.0
> > > Nov  4 03:53:16 localhost kernel: usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
> > > 
> > > Once I upgraded to 2.6.2, the mouse is identified as follows:
> > > Feb  4 12:29:07 localhost kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> > 
> > You moved the mouse from USB to PS/2 between the kernel upgrade? Where
> > the mouse doesn't work properly - on USB or PS/2? They're wildly
> > different interfaces and the mouse is using a different protocol on
> > either.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
