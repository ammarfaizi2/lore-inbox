Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUGCPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUGCPCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUGCPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 11:02:52 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:11698 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265137AbUGCPCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 11:02:49 -0400
Date: Sun, 4 Jul 2004 01:02:04 +1000
From: Andrew Clausen <clausen@gnu.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703150203.GN630@gnu.org>
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org> <s5gzn6iz2or.fsf@patl=users.sf.net> <20040703025457.GC630@gnu.org> <Pine.LNX.4.60.0407030843400.2415@hermes-1.csi.cam.ac.uk> <20040703124435.GH630@gnu.org> <Pine.LNX.4.60.0407031535230.6149@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407031535230.6149@hermes-1.csi.cam.ac.uk>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 03:40:01PM +0100, Anton Altaparmakov wrote:
> > XP home edition (the green box)
> 
> Hm, I only ever tried XP Pro.

I guess we can try diff'ing the bootstrap code.  Should probably do this
in private for copyright reasons...

> > > Does it use NTFS as both the boot and system drive?
> > 
> > I am using a single NTFS partition.
> 
> I have lots of partitions (mostly Linux, NTFS is at end of disk).

If NTFS is at the end of the disk, doesn't it have to use LBA to address
it?

> > Note: I reversed-engineered the Windows FAT bootstrap code.  My analysis
> > is contained in the file doc/FAT in the Parted source distribution.  I
> > concluded that Windows uses LBA if the LBA flag is set in the boot
> > partition table entry.  (i.e. the partition type includes LBA in the
> > fdisk codes - this corresponds to a bit being set)
> 
> Interesting.  Maybe I don't have this bit set?

This bit only applies to FAT, AFAIK.  There is no corresponding bit
for NTFS.

> > > u16 sectors_per_track; /* Required to boot Windows. */
> > > u16 heads;             /* Required to boot Windows. */
> > > u32 hidden_sectors;    /* Offset to the start of the partition relative 
> > > to the disk in sectors.  Required to boot Windows. */
> > 
> > I just set the first 2 of these fields to 0, and everything still works.
> > Am I blessed?  (Or perhaps cursed!)
> 
> Odd.  Messing up any of the above three values makes my XP Pro fail to 
> boot!

Interesting.  How is your BIOS configured?  (LBA, Auto, CHS or Large?
what CHS values?)

Cheers,
Andrew

