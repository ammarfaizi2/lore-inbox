Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275784AbRI1BvD>; Thu, 27 Sep 2001 21:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275783AbRI1Bux>; Thu, 27 Sep 2001 21:50:53 -0400
Received: from host-029.nbc.netcom.ca ([216.123.146.29]:62223 "EHLO
	mars.infowave.com") by vger.kernel.org with ESMTP
	id <S275785AbRI1Buj>; Thu, 27 Sep 2001 21:50:39 -0400
Message-ID: <6B90F0170040D41192B100508BD68CA1015A81B1@earth.infowave.com>
From: Alex Cruise <acruise@infowave.com>
To: "'Randy.Dunlap'" <rddunlap@osdlab.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: apm suspend broken in 2.4.10
Date: Thu, 27 Sep 2001 18:50:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy.Dunlap [mailto:rddunlap@osdlab.org]

> > I'm gonna go try the 2.4.7 from RH's "Roswell" beta now.
> OK, thanks for testing that.

2.4.7 has the apm=on bug and won't suspend either... I'm beginning to
suspect that something else is afoot, but I might as well try 2.4.2... 

Funny, with 2.4.2, "apm=on" seems to work as expected, and the first time I
tried "apm --suspend", the screen blanked but nothing else appeared to
happen.  When I hit a key, the suspend command appeared to still be running.
I switched to a different vc and did a "ps ax", it looked like it was  stuck
in the middle of trying to unmount an smbfs filesystem.

Next time I booted up, I umounted the smbfs system and did an "apm
--suspend" that appears to have shut everything down... And when I hit the
power button, it comes up again, albeit with an incredibly dim screen (a
common problem on this Dell Latitude C600).

So, from the point of view of my laptop, something important seems to have
changed between 2.4.2 and 2.4.7.

> I suspect that it's something like a single driver change (not apm,
> but PM-support in a driver).  How many I/O-device drivers do you
> use?  Would it be difficult to try to isolate which one may be
> faulty?

How would I find out what driver(s) might be vetoing my suspend request?

Here's the complete list of modules which might typically be loaded at boot:

3c59x
smbfs
lns_cp437
vfat
fat
ide-cd
cdrom
md
usb-uhci
usbcore
maestro3
sound
soundcore
ac97_codec
r128
agpgart
usb-uhci
usbcore

-0xe1a
