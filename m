Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280658AbRKJOGo>; Sat, 10 Nov 2001 09:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKJOGf>; Sat, 10 Nov 2001 09:06:35 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:13764 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280658AbRKJOGW>; Sat, 10 Nov 2001 09:06:22 -0500
Message-Id: <5.1.0.14.2.20011110140252.0343cb00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 10 Nov 2001 14:05:01 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: scsi BLKGETSIZE breakage in -pre2
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org (lkml),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <E162Ydz-0006Qf-00@the-village.bc.nu>
In-Reply-To: <3BECD87F.F53234B2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:57 10/11/01, Alan Cox wrote:
> > sd_ioctl() was changed to pass BLKGETSIZE off to blk_ioctl(),
> > but blk_ioctl() doesn't implement it.
> >
> > So `cfdisk /dev/sda' is failing.
> >
> > Simply copying the -ac version of blkpg.c across fixes
> > it for me.
>
>I'm feeding Linus stuff bit by bit - I managed to misorder that one.

It has one positive side: mkntfs failed so I finally got round to 
implementing device size determination via binary lseek search (a la 
e2fsutils library) and I can test it without having to modify the mkntfs 
source by booting into -pre2. (-:

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

