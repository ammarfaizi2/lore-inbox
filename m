Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRARA7o>; Wed, 17 Jan 2001 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRARA7e>; Wed, 17 Jan 2001 19:59:34 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:10759 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S130388AbRARA71>; Wed, 17 Jan 2001 19:59:27 -0500
Date: Thu, 18 Jan 2001 00:59:22 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Werner Almesberger <Werner.Almesberger@epfl.ch>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <200101180039.f0I0du929822@webber.adilger.net>
Message-ID: <Pine.LNX.4.30.0101180048260.29484-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a mirrored boot drive in a pair of firewalls / routers and to test
> > before I put them into service I pulled hda and the machine booted fine
> > from hdc and baring winging about the missing disk (all the drives are
> > mirrored) carried on as normal. A fresh disk was put and rebuilt no
> > problems and was then booted off with the other disk missing.
>
> Ahh.  What I was missing was that by specifying /dev/md0 as the root device,
> not only do you get an identical map for the kernels, but the root device
> remains /dev/md0 no matter which drive fails and LILO/kernel don't need to
> do anything special to find it.  This assumes the BIOS can boot from /dev/hdc
> to start with (i.e. /dev/hda is totally gone).

Hence I have the disks in caddies to make taking them out all together
easier, to force the bios to find the /dev/hdc as the boot drive

> How does MD/RAID0 know which array should be /dev/md0?  What if you had a
> second array on /dev/hdb and /dev/hdd, would that become /dev/md0 (assuming
> it had a kernel/boot sector)?

/etc/raidtab specifies which drives belong in which array, but I only have
hda and hdc so I can't really answer the question

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

Never apply a StarTrek solution to a Babylon 5 problem


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
