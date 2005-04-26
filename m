Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVDZGlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVDZGlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDZGlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:41:12 -0400
Received: from 114.135.160.66.in-arpa.com ([66.160.135.114]:20487 "EHLO
	furrylvs.randyg.org") by vger.kernel.org with ESMTP id S261351AbVDZGiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:38:54 -0400
Message-ID: <426DE1F8.6010702@bushytails.net>
Date: Mon, 25 Apr 2005 23:38:48 -0700
From: Randy Gardner <lkml@bushytails.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd?  Can burn DVDs, just not read them...
References: <426972E5.4000408@bushytails.net> <20050425163436.GA15693@csclub.uwaterloo.ca> <426D2F03.2040001@bushytails.net> <20050425202921.GB15693@csclub.uwaterloo.ca>
In-Reply-To: <20050425202921.GB15693@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> You should be able to see the firmware version using one of the cd
> writing tools (cdrecord or dvd+rw-mediainfo or whichever).  Comparing to
> what the manufacturer has on offer could at least tell that.  As for
> updating, if it isn't a plextor it almost certainly requries windows
> and/or dos to update (usually windows it seems).

It's not a plextor...  they have some windows-only "live update" utility.

I spent all day fixing the $#@! lawnmower, so didn't get a chance to
take the drive to the relative with the windoze box to try updating it.

> Well that does sound odd.  Is this your own kernel build from plain
> kernel.org sources or are there any patches involved?

It's "patched" (the files are replacements, not patches, hence the
quotes) with the linuxwacom drivers, but those are replacements for a
couple usb files (evdev.c, hid-core.c, mousedev.c, usbmouse.c, and
wacom.c) and hopefully don't affect IDE.  I have the proprietary nvidia
driver installed, but I tried booting without it to test, with no
change.  Otherwise it's just the kernel.org sources.

> As far as I know, promise cards are only recommended for harddisks, but
> I am not sure of that.  I have only ever used them for harddisks myself.

The promise controller seems to suck...  I'd never use it for a hard
disk.  Don't trust the thing, and whenever you have a hard drive
installed, you have to either format it as a raid disk (even if it's
only a single drive) or press escape to make it boot, every time you go
to boot.  even on, say, powerfail recovery.  However, since plugging the
drive into the main ide controllers doesn't result in any change
whatsoever, I don't think it's related to the problem.

> Different cables tried?  Just in case you have a bad cable in there?

Tried a total of 4 cables...  one cable when it was shared with the
cd-rw on the promise controller, one cable when it was on the main
controller, one cable when it was on the promise controller not sharing
anything, and one cable when it was in the relative's dual-boot box.

>>Someone suggested I try a binary search of kernel versions to figure out 
>>exactly when the cd-rw drive was broken (which worked before, unlike the 
>>dvd, which I have no idea if it ever worked), in an effort to figure out 
>>what caused it to break...  going to try this, but haven't had the 
>>time...  a long project.  :)
> 
> 
> Sounds painful.

Very.  fortunately distcc makes it somewhat less painful, as I can throw
a total of 5 cpus at it...

> Well so far I have had no problems reading or writing with 2.6.11,
> 2.6.10, 2.6.8, and some earlier 2.6 kernels (all Debian sarge or sid
> builds).  
> 
> Len Sorensen
> 

I can write fine...  that's the funny thing.  I can burn dvds at 8x with
only 3% or so cpu usage, and with the drive in the relative's windoze
box, can read the discs perfectly...  same for the cd-rw drive.  so
whatever it is only affects reads.

Tonight I'll be trying the suggestion of IDEDISK_MULTI_MODE=y to see if
it changes anything.  I think it only affects hard drives, but worth a shot.

Unfortunately, I have 6 motherboards, and every single one of them is a
via vt82c686a chipset, from the dual p3 ones to the athlon one...  so it
makes it a bit hard to see if it's a chipset-specific bug.  I might try
tomorrow hunting up a used p3 motherboard with a different chipset to
see if it makes it do anything differently.


Thanks again,
--Randy

