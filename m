Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRAJIWT>; Wed, 10 Jan 2001 03:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRAJIWJ>; Wed, 10 Jan 2001 03:22:09 -0500
Received: from [216.161.55.93] ([216.161.55.93]:57075 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130130AbRAJIWC>;
	Wed, 10 Jan 2001 03:22:02 -0500
Date: Wed, 10 Jan 2001 00:24:30 -0800
From: Greg KH <greg@wirex.com>
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards for x86/uhci in 2.4- kernels?
Message-ID: <20010110002430.A26680@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Benson Chow <blc@q.dyndns.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org>; from blc@q.dyndns.org on Tue, Jan 09, 2001 at 11:55:14PM -0700
X-Operating-System: Linux 2.4.0 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 11:55:14PM -0700, Benson Chow wrote:
> Anyone tried using these beasts on a x86?
> 
> Anyway, what's happening:   In BIOS my USB keyboard works really poorly -
> it almost seems scancodes get dropped left and right.  Ok, so I don't mind
> too much, i'm sure BIOS has a very limited driver.  After booting
> Microsoft's offerring, it would work fine after it installs its driver.
> I also tried this same keyboard on a HPUX Visualize C3600 workstation and
> it also works nicely.
> 
> However linux would never fix  this "scancode drop" syndrome even after
> loading the hid or usbkbd driver.  Both my Via uhci USB motherboard and
> PIIX3 USB motherboard exhibit this usb keyboard strangeness
> with the hid or usbkbd driver is installed.  I think the PIIX3
> motherboard's bios doesnt handle USB properly so it doesn't even work in
> BIOS setup.  Any idea what's going on?  Is there some other driver or
> utility I need to install/run to get it working?  Maybe just my bad bios?

Try turning off the BIOS support for keyboards.  Kinda sounds like Linux
isn't taking over the USB controller properly.  Does the keyboard work
without _any_ usb modules loaded?  If so, then that's probably the
problem.

> BTW: my USB Mouse, and USB Printer seem to work nicely in 2.4.0-release.

But then again, if these are working at the same time as your keyboard,
it looks like Linux took over the controller nicely.

Sorry, I guess this wasn't much help.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
