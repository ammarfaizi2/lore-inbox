Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbSKOXjv>; Fri, 15 Nov 2002 18:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbSKOXjv>; Fri, 15 Nov 2002 18:39:51 -0500
Received: from WebDev.iNES.RO ([80.86.100.174]:39042 "HELO webdev.ines.ro")
	by vger.kernel.org with SMTP id <S266839AbSKOXju>;
	Fri, 15 Nov 2002 18:39:50 -0500
Date: Sat, 16 Nov 2002 01:46:15 +0200 (EET)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: <shadow@webdev.ines.ro>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ext3 recovery
Message-ID: <Pine.LNX.4.33L2.0211160140330.6700-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>
> On Nov 13, 2002  19:13 +0200, Andrei Ivanov wrote:
> > Hello, I have an ext3 formated partition on a harddrive that just got tons
> > of badblocks and I'm trying to recover as much data as possible from that
> > partition.
> > If I try e2fsck /dev/hdb3 I get this error:
> >
> > e2fsck 1.32 (09-Nov-2002)
> > Group descriptors look bad... trying backup blocks...
> > e2fsck: Invalid argument while checking ext3 journal for /
> >
> > So I tried to remove the journal and make e2fsck treat the partition as an
> > ext2 one, but no luck, although tune2fs -O ^has_journal /dev/hdb3 doesn't
> > give me any message, except it's version string.
> >
> > If I pass fsck the backup superblock myself, it still refuses to run:
> > e2fsck -b 32768 /dev/hdb3
> > e2fsck: Invalid argument while checking ext3 journal for /
> >
> > Attached you will find some info (dmesg and hdparm). If you need any more
> > info, tell me.
>
> I would suggest "dd if=bad_drive of=good_drive conv=sync,noerror"
> and then do all of your recovery on the good drive.
>
> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/

I've finally managed to get a hard drive to do this, but I receive the
same errors... :(

Do you have any other suggestions ?
Thanks





