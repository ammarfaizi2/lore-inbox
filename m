Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRIVPJs>; Sat, 22 Sep 2001 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIVPJj>; Sat, 22 Sep 2001 11:09:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40625 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S271329AbRIVPJ1>; Sat, 22 Sep 2001 11:09:27 -0400
Date: Sat, 22 Sep 2001 11:09:45 -0400
From: Greg Ward <gward@python.net>
To: David Grant <davidgrant79@hotmail.com>
Cc: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010922110945.B678@gerg.ca>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz> <OE3183UV8wAddX47sFo00001649@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OE3183UV8wAddX47sFo00001649@hotmail.com>; from davidgrant79@hotmail.com on Sat, Sep 22, 2001 at 03:53:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 September 2001, David Grant said:
> I'm not an expert user, just someone who's been trying feeble-ly to get
> Linux working for the past 3 months on my new computer.  I have a Promise
> chip (PDC20265) and Via vt86c686b on my A7V133.  I get these DMA timeout
> errors when I am even trying to install Linux!

A-ha, so I do not struggle alone.  That's comforting, in a way.

Most likely, you get DMA timeout errors when attempting to install Linux
for the same reason as I get them when booting: the first time Linux
tries to read the disk, it waits and waits and waits.  Depending on your
kernel version and which IDE interface you're using, it eventually gives
up... or it locks up.  (I had the lockup problem with kernel 2.4.2 and
the suspect drive on my Promise IDE interface.  On the VIA interface, it
booted eventually after ~60 sec of timeout errors.  Under 2.4.9, the
kernel doesn't take as long to timeout, and it's not as noisy as it was
under 2.4.2, but the underlying problem is still there: no DMA.)

BTW, you wouldn't happen to know which kernel version was in the Linux
distros you attempted to install, would you?  Not that it
matters... 2.4.9 doesn't work for me, and I haven't heard anyone telling
me to upgrade to the latest bleeding edge 2.4.10.preXX or 2.4.9acYY.

> [...] no version of Linux will
> install.  After the installer starts to install a few packages (sometimes
> 10, sometimes 100), the installer halts, the hard disk light stays on, and
> if I use CTRL-ALT-F4, I see these DMA timeout errors.  The hard drive is
> unresponsive unless I do a cold boot, as opossed to warm boot.

That sounds like problems I saw in the linux-kernel archive from a few
months back: intermittent, not-always-there, takes-a-while-to-manifest
DMA timeouts.  The DMA timeout I'm experiencing is always there, 100%
reliable, and manifests with the first attempt to read a sector from the
disk (the hunt for partitions).

For the record, I'm starting to suspect either a bad cable or a bad
drive.  I've had positive reports from two people with the ASUS A7V
motherboard and ATA/100 drives under Linux 2.4, so it's certainly
possible.  I just need to find someone with some redundant hardware that
I can play with.  Or get my hands on Seagate's diagnostic tool, which
they don't make terribly easy to access if you don't use Windows.
(Annoying irony: the only reason you need Windows is to run their
program that writes a floppy disk image; you then boot that disk.  But
the image is embedded in the .exe file, and they don't seem to make the
image available separately.  ARGGGHHH!!!)

        Greg
-- 
Greg Ward - just another /P(erl|ython)/ hacker          gward@python.net
http://starship.python.net/~gward/
"I know a lot about art, but I don't know what I like!"
