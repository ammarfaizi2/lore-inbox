Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135683AbRARODr>; Thu, 18 Jan 2001 09:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135684AbRARODi>; Thu, 18 Jan 2001 09:03:38 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:45320 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S135683AbRAROD1>; Thu, 18 Jan 2001 09:03:27 -0500
Date: Thu, 18 Jan 2001 14:03:23 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: David Balazic <david.balazic@uni-mb.si>,
        Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <200101181301.OAA18768@microsoft.com>
Message-ID: <Pine.LNX.4.30.0101181354280.13189-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is when devfs comes into its own, as the disks are refered to by
> > their device/controller id not by the /dev/sd{a,b,c,etc} numbering, hence
> > when one fails the others don't change. Also I think the kernel autodetect
> > code for scsi devices will deal with this case, but I'm not sure.
>
> 'would be great to use driver name, e.g. something like
> /dev/scsi/advansys/... (I don't remember devfs naming scheme)

Then you are back to the arguement about should the naming be based on the
function of the device (scsi0,1,2 / eth0,1,2) or based on the hardware
(aic7xxx0,1,2 advansys0,1,2 / tulip0,1,2 eepro0,1,2). *BSD uses this
naming scheme for its ethernet interfaces, not sure about its scsi thou.

I prefer the functional naming scheme (scsi0 / eth0) as I can change the
hardware in a machine and not change anything in the init scripts,
assuming the driver is in kernel or if not I only need to change the line
/etc/modules.conf.

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

"I am Homer of Borg.  Prepare to Oooh! Doughnuts!"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
