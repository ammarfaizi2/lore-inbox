Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276331AbRI1WIm>; Fri, 28 Sep 2001 18:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276340AbRI1WIc>; Fri, 28 Sep 2001 18:08:32 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:13065 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S276331AbRI1WIV>; Fri, 28 Sep 2001 18:08:21 -0400
Message-ID: <3BB4F446.E7E1C014@osdlab.org>
Date: Fri, 28 Sep 2001 15:05:58 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Cruise <acruise@infowave.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81B1@earth.infowave.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Cruise wrote:
> 
> 2.4.7 has the apm=on bug and won't suspend either... I'm beginning to
> suspect that something else is afoot, but I might as well try 2.4.2...
> 
> Funny, with 2.4.2, "apm=on" seems to work as expected, and the first time I
> tried "apm --suspend", the screen blanked but nothing else appeared to
> happen.  When I hit a key, the suspend command appeared to still be running.
> I switched to a different vc and did a "ps ax", it looked like it was  stuck
> in the middle of trying to unmount an smbfs filesystem.
> 
> Next time I booted up, I umounted the smbfs system and did an "apm
> --suspend" that appears to have shut everything down... And when I hit the
> power button, it comes up again, albeit with an incredibly dim screen (a
> common problem on this Dell Latitude C600).
> 
> So, from the point of view of my laptop, something important seems to have
> changed between 2.4.2 and 2.4.7.
> 
> > I suspect that it's something like a single driver change (not apm,
> > but PM-support in a driver).  How many I/O-device drivers do you
> > use?  Would it be difficult to try to isolate which one may be
> > faulty?
> 
> How would I find out what driver(s) might be vetoing my suspend request?
> 
> Here's the complete list of modules which might typically be loaded at boot:
> 
> 3c59x
> smbfs
> lns_cp437
> vfat
> fat
> ide-cd
> cdrom
> md
> usb-uhci
> usbcore
> maestro3
> sound
> soundcore
> ac97_codec
> r128
> agpgart
> usb-uhci
> usbcore


Unload some of these (that you don't really need to run)
and try "apm -s".

If that fails, unload some more of them and try again...

That would at least narrow down the search for us.

~Randy
