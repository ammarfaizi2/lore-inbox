Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQKAEy3>; Tue, 31 Oct 2000 23:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQKAEyU>; Tue, 31 Oct 2000 23:54:20 -0500
Received: from lolita.speakeasy.net ([216.254.0.13]:26814 "HELO
	lolita.speakeasy.net") by vger.kernel.org with SMTP
	id <S129655AbQKAEyL>; Tue, 31 Oct 2000 23:54:11 -0500
Message-ID: <39FF9F8D.9D3D1077@speakeasy.org>
Date: Tue, 31 Oct 2000 20:43:57 -0800
From: Miles Lane <miles@speakeasy.org>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Paul Jakma <paul@clubi.ie>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthew Dharm <mdharm@one-eyed-alien.net>
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
In-Reply-To: <Pine.LNX.4.21.0010310054200.1041-100000@fogarty.jakma.org> <20001031153106.A9458@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, Oct 31 2000, Paul Jakma wrote:
> > I have 2 problems related to reading IRIX EFS cd's.
> >
> > -------problem 1:
> >
> > mounting an EFS cd from my Yamaha CDR-4416S SCSI CDRW consistently
> > causes a lockup when i try to read directory/file data from the CD. I
> > observed this initially with EFS CDR's, and assumed something had
> > gone wrong when burning that CD. But the exact same thing happens
> > with original SGI IRIX media. I have no problems with any of my EFS
> > CDs when accesed from an ATAPI CDROM.
> 
> Known problem, blocksizes != 2kb does not currently work
> correctly with SCSI CD-ROM (it's even on Ted's list).

Could this have something to do with the problem I reported where
running:

	dd if=/dev/zero of=/dev/sda bs=1k count=2G

to write data to my ORB drive over a USB connection causes
all writing to my hard drive to cease?  The USB Storage
driver uses a virtual SCSI interface.

	Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
