Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbRARAPL>; Wed, 17 Jan 2001 19:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130387AbRARAPB>; Wed, 17 Jan 2001 19:15:01 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:3079 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S130307AbRARAOq>; Wed, 17 Jan 2001 19:14:46 -0500
Date: Thu, 18 Jan 2001 00:14:42 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Werner Almesberger <Werner.Almesberger@epfl.ch>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <200101172043.f0HKhnA09341@webber.adilger.net>
Message-ID: <Pine.LNX.4.30.0101180009460.26536-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What _would_ be interesting, and still not affect the boot loader proper,
> is to allow specifying multiple boot devices in /etc/lilo.conf (for e.g.
> RAID 1 setups), and then /sbin/lilo would put a boot sector on each such
> drive.

You can already do this, just specify /dev/md0 as the device to install
onto, and lilo does the rest

> This would potentially allow you to boot from the second drive if the
> first one fails, assuming the kernel does UUID or LABEL resolution for
> the root device.  The kernel would boot from the first BIOS drive, and
> would match search for a UUID or LABEL as the root device.

I can confirm that this works on RedHat 6.2 + Lilo 0.21 + kernel
2.4.0-test8 and RAID1.

I have a mirrored boot drive in a pair of firewalls / routers and to test
before I put them into service I pulled hda and the machine booted fine
from hdc and baring winging about the missing disk (all the drives are
mirrored) carried on as normal. A fresh disk was put and rebuilt no
problems and was then booted off with the other disk missing.

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

An NT server can be run by an idiot, and usually is.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
