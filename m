Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSERPfH>; Sat, 18 May 2002 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSERPfG>; Sat, 18 May 2002 11:35:06 -0400
Received: from host217-36-7-219.in-addr.btopenworld.com ([217.36.7.219]:7173
	"EHLO alanis.home.our-asylum.net") by vger.kernel.org with ESMTP
	id <S312296AbSERPfG>; Sat, 18 May 2002 11:35:06 -0400
Date: Sat, 18 May 2002 16:34:40 +0100 (BST)
From: Jeremy Elgar <jeremy@our-asylum.net>
X-X-Sender: jeremy@alanis.home.our-asylum.net
To: linux-kernel@vger.kernel.org
Subject: ide-scsi Problems 2.4.18 
Message-ID: <Pine.LNX.4.43.0205181553020.28303-100000@alanis.home.our-asylum.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Ive had the following problem for a while now but havent been able to
solveit. My Set up is like this

its a VP6 MotherBoard 2Gb ram and dual P3 700's

I have 2 CD type devices (one dvd drive one cd burner)

the CD_RW (LG Brand) is on hda.
the dvd HITACH DVD-ROM GD-2500 is on hdg

My disks are on the Highpoint controller (hde)

Im currently using 2.4.18-lkpc-4 (from lkpc.sourceforge.net) but have had
the same issues with plain 2.4.18 + XFS.

using grip (for example) I can read data from the DVD drive (hde) for a
while
(sometimes all the way through other times after a few tracks, it seems to
be dependent on what else im doing) then
I start getting
May 18 15:59:43 dido kernel: SCSI cdrom error : host 0 channel 0 id 1 lun 0 return code = 28000000
May 18 15:59:43 dido kernel: Info fld=0x0, ILI Current sd0b:01: sense key Illegal Request
May 18 15:59:43 dido kernel: Additional sense indicates Illegal mode for this track
May 18 15:59:43 dido kernel:  I/O error: dev 0b:01, sector 0
May 18 15:59:43 dido kernel: FAT: unable to read boot sector
May 18 15:59:43 dido kernel: SCSI cdrom error : host 0 channel 0 id 1 lun 0 return code = 28000000
May 18 15:59:43 dido kernel: Info fld=0x0, ILI Current sd0b:01: sense key Illegal Request
May 18 15:59:43 dido kernel: Additional sense indicates Illegal mode for this track

in the log

using hda the drive will spin up but nothing will happen and Ill get the
following in the log
May 18 16:12:29 dido kernel: scsi : aborting command due to timeout : pid 12640, scsi0, channel 0, id 0, lun 0 UNKNOWN(0xbe) 00 00 00 00 0d 00 00 0d f8 00 00
hda: lost interupt

In both cases sometimes the machine will reboot with no errors in the log.

Im at a bit of a loss as to what to do. Im going to attempt to build the
current kernel with out SMP and Highmem (seperatly and together) to see
if I can remove the problem but was wondering if anyone had any ideas?

Is the physical devise layout okay? Pretty sure Ive had this working
before okay ~2.4.14ish but I may have only had one drive (the CDRW)
configured as ide-scsi.

Nothing very simular has come up in the archives but If I have missed
something please tell me

Oh and yes I have tried turning off DMA etc using hdparam as suggested to
someone else.

Thanks
Jeremy



--
Even the samurai have teddy bears,
and even the teddy bears get drunk.

