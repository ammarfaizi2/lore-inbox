Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbSKZUX1>; Tue, 26 Nov 2002 15:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbSKZUX1>; Tue, 26 Nov 2002 15:23:27 -0500
Received: from ma-northadams1b-112.bur.adelphia.net ([24.52.166.112]:17536
	"EHLO ma-northadams1b-112.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S266908AbSKZUX0>; Tue, 26 Nov 2002 15:23:26 -0500
Date: Tue, 26 Nov 2002 15:30:43 -0500
From: Eric Buddington <eric@ma-northadams1b-112.nad.adelphia.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.49: "hdb: cannot handle device with more than 16 heads"
Message-ID: <20021126150325.A157@ma-northadams1b-112.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1038335905.2658.65.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 26, 2002 at 06:38:25PM +0000
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 06:38:25PM +0000, Alan Cox wrote:
> On Tue, 2002-11-26 at 17:50, Eric Buddington wrote:
> > This is 2.5.49, compiled for i386 with almost all modules using
> > gcc-3.2.  On my PII Omnibook 4100, the messages stop after the first
> > hda: message (where it would normally identify the drive). The same
> > problem existed in 2.4.48.
> > 
> > When booting on my Athlon (hda:Maxtor 5T040H4, hdb: Maxtor 90840D6), I
> > get the following boot messages:
> 
> Looks like you used the old MFM/RLL driver for hda. That wont work with
> new drives. 

Thanks. Disks and partitions are now recognized, but root still won't
mount. Reiserfs (the root fs) is compiled in, along with IDE disk
support.  I tried getting rid of the advanced partitopn types options,
which eliminated the MS-DOS partition table message, but did not
otherwise change things.

The hdc error is also unexpected, unless it's simply the result of no
CD in the drive.

I hope this isn't another silly thing I'm missing.

-Eric

---------------------------------------------------------------------

pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
hda: Maxtor 5T040H4, ATA DISK drive
hdb: Maxtor 90840D6, ATA DISK drive
hdc: _NEC CD-RW NR-7800A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=4982/255/63
 /dev/ide/host0/bus0/target0/lun0:<7>ldm_validate_partition_table(): Found an MS
-DOS partition table, not a dynamic disk.
 p1 p4
hdb: host protected area => 1
hdb: 16406208 sectors (8400 MB) w/256KiB Cache, CHS=1021/255/63
 /dev/ide/host0/bus0/target1/lun0:<7>ldm_validate_partition_table(): Found an MS
-DOS partition table, not a dynamic disk.
 p1
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
VFS: Cannot open root device "hda1" or 03:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:01
