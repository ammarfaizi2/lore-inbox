Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRKNR30>; Wed, 14 Nov 2001 12:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRKNR3R>; Wed, 14 Nov 2001 12:29:17 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:61467 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276761AbRKNR26>; Wed, 14 Nov 2001 12:28:58 -0500
Date: Wed, 14 Nov 2001 12:28:52 -0500
From: <joeja@mindspring.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, joeja@mindspring.com
Subject: Re: Re: 2.4.9 to 2.4.14 bug & workaround
Message-ID: <Springmail.105.1005758932.0.19986500@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, 

>>    Device Boot    Start       End    Blocks   Id  System
>> /dev/sdb4             1      1536     98288    6  FAT16

>.which is evidently there?

I found out some of my disks have no partition table 'readable by Linux'.  Which is really f***** weird since, they can be read under NT.  What is also really weird is that some of these disks can be mounted as /dev/hdd4 even though there is no valid partition.

In some cases these are zip disks that were readable under 2.2.x, but since I don't have 2.2.x anymore I cannot verify that they would still be readable.  Rather strange that a disk partition would just disapear like that.  Unless the drive itself is hiding it or not recgonizing it.

In any case it seems if I run fdisk against the disks and then mformat they behave better.  But aren't zip disks formated and partitioned out of the box?  These ones all were.

>> Until now I thought it had something to do with the different gendisk,
>> LDM or so.

>Well, you may also see firmware and/or design flaws in the drive
>(personally, I have never trusted iomega, because on the CeBIT fair in

Mine is not an 'iomega' drive, but a copy.  Made by someone else. AFAIK.

>Hannover, I once asked them "why should I prefer iomega ZIP or JAZ over
>SyQuest" and they had no answer except "we're just better". I later
>heard complaints about the SCSI ID only to be chosen from 5 or 6, 
25-pin

I got mine cause it was cheap, internal and I already had zip disks.  

>Judging from what's on that page, the IDE driver seems to know it's >just
>a "floppy" without partitions, but the USB driver sees the (fake)
>partitions.

This would explain what I am seeing, weird as it may seem.  I used to be using an external iomega zip drive that recgonized these disks, but now the internal one does not seem to.

I guess this means that I have to run fdisk on all these disks. Then mformat.

Hmm, it would be nice if there was a workaround.

Joe
 
