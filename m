Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279416AbRKMV4Q>; Tue, 13 Nov 2001 16:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279512AbRKMV4H>; Tue, 13 Nov 2001 16:56:07 -0500
Received: from dialin-145-254-148-003.arcor-ip.net ([145.254.148.3]:41994 "EHLO
	picklock.adams.family") by vger.kernel.org with ESMTP
	id <S279416AbRKMV4C> convert rfc822-to-8bit; Tue, 13 Nov 2001 16:56:02 -0500
Message-ID: <3BF196B2.8D12892B@loewe-komp.de>
Date: Tue, 13 Nov 2001 22:54:59 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.13-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 to 2.4.14 bug & workaround
In-Reply-To: <Springmail.105.1005600219.0.18983900@www.springmail.com> <20011113124519.G3949@emma1.emma.line.org> <3BF10DD5.9461C2F@loewe-komp.de> <20011113135617.C9591@emma1.emma.line.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree schrieb:
> 
> Peter Wächtler schrieb am Dienstag, den 13. November 2001:
> 
> > On the IDE I mount /dev/hdb, on the USB thing I mount sd[ab]4
> > depending if the flash reader is there or not.
> > Hmh?
> 
> Do these behave differently? In particular, do the IDE Zip drives hide
> the partition structure...
> 
> >    Device Boot    Start       End    Blocks   Id  System
> > /dev/sdb4             1      1536     98288    6  FAT16
> 
> ...which is evidently there?
> 
> > Until now I thought it had something to do with the different gendisk,
> > LDM or so.
> 
> Well, you may also see firmware and/or design flaws in the drive
> (personally, I have never trusted iomega, because on the CeBIT fair in
> Hannover, I once asked them "why should I prefer iomega ZIP or JAZ over
> SyQuest" and they had no answer except "we're just better". I later
> heard complaints about the SCSI ID only to be chosen from 5 or 6, 25-pin
> SCSI connectors and stuff, then there was the click-of-death sabotage
> and now there is your "partition entry or not" problem.)
> 
> http://www.win.tue.nl/~aeb/linux/zip/zip-1.html has some info which does
> not look too promising when you're after consistent behaviour across the
> various drive types (interface-wise, that is).
> 
> Judging from what's on that page, the IDE driver seems to know it's just
> a "floppy" without partitions, but the USB driver sees the (fake)
> partitions.
> 

Wow, thanks for this link. It explains the details very well.

Nov 12 21:50:51 picklock kernel: hdb: 98288kB, 196576 blocks, 512 sector size
Nov 12 21:50:51 picklock kernel: VFS: Disk change detected on device ide0(3,68)
Nov 12 21:50:54 picklock kernel:  hdb: hdb1 hdb2 hdb3 hdb4
Nov 12 21:50:54 picklock kernel: ide-floppy: hdb: I/O error, pc = 28, key =  5,
Nov 12 21:50:54 picklock kernel: end_request: I/O error, dev 03:44 (hdb), sector

<4>hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive

This was an attempt of (mdir z: with z: mapping to /dev/hdb4)



BTW, on the same day I bought this thing, "Linux" did demolish my only media.
But luckily I also bought a SB Live!, told the dealer, that I am running an
Athlon with 686_A_ (not B) southbridge and the soundcard does not work also.

I got a different soundcard and a new ZIP media for no extra costs ;-)
