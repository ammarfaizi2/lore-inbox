Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUBIW3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUBIW3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:29:46 -0500
Received: from OPEN-BOOZEWARE.MIT.EDU ([18.18.1.109]:44477 "EHLO
	open-boozeware.mit.edu") by vger.kernel.org with ESMTP
	id S265211AbUBIW3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:29:35 -0500
Date: Mon, 9 Feb 2004 17:29:31 -0500
From: Alex <akhripin@mit.edu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alex <akhripin@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: More mouse wheel problems
Message-ID: <20040209222930.GX18567@open-boozeware.mit.edu>
References: <20040209172448.GV18567@open-boozeware.mit.edu> <20040209220523.GA827@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209220523.GA827@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mouse is in USB in both cases. I'll see if I can dig up my USB <-> PS/2
converter and try the mouse in PS/2 mode. But in this case, the mouse stayed
plugged into USB the whole time.
-Alex

On Mon, Feb 09, 2004 at 11:05:23PM +0100, Vojtech Pavlik wrote:
> On Mon, Feb 09, 2004 at 12:24:48PM -0500, Alex wrote:
> > Hi,
> > I know mouse wheel problems have been discussed, but I am still having them
> > even with the proper fixes. I have a generic-looking IBM optical wheel USB
> > mouse, Model Number MO28B0 (O's could be zeros and vice versa).
> > 
> > In the 2.4 kernels, the USB mouse would register with the following message:
> > Nov  4 03:53:16 localhost kernel: usb.c: registered new driver usbmouse
> > Nov  4 03:53:16 localhost kernel: input0: ARROW STRONG USB 3D Mouse on usb1:3.0
> > Nov  4 03:53:16 localhost kernel: usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
> > 
> > Once I upgraded to 2.6.2, the mouse is identified as follows:
> > Feb  4 12:29:07 localhost kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> 
> You moved the mouse from USB to PS/2 between the kernel upgrade? Where
> the mouse doesn't work properly - on USB or PS/2? They're wildly
> different interfaces and the mouse is using a different protocol on
> either.
> 
> > 
> > The problem is that the mouse wheel does not work. My XF86Config-4 contains:
> > Section "InputDevice"
> >         Identifier      "Configured Mouse"
> >         Driver          "mouse"
> >         Option          "CorePointer"
> >         Option          "Device"                "/dev/input/mouse0"
> >         Option          "Protocol"              "ImPS/2"
> >         Option          "ZAxisMapping"          "4 5"
> > EndSection
> > 
> > I have tried with ExplorerPS/2 as suggested before, as well as with /dev/input/mice.
> > 
> > Trying to perform some diagnostics, I used hexdump and cat to look at the
> > output of /dev/input/mouse0 and /dev/input/mice. In both cases, the devices
> > produced quite a lot of output for mouse movement and button presses - for
> > all three buttons - but no output whatsoever for wheel movements. Does this
> > mean that the problem is with the kernel?
> > 
> > Thanks for your time,
> > Alex Khripin
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
