Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQKUSvx>; Tue, 21 Nov 2000 13:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKUSvn>; Tue, 21 Nov 2000 13:51:43 -0500
Received: from isolaweb.it ([213.82.132.2]:7691 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S129391AbQKUSvZ> convert rfc822-to-8bit;
	Tue, 21 Nov 2000 13:51:25 -0500
Message-Id: <4.3.2.7.2.20001121190033.00d23bc0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 21 Nov 2000 19:16:19 +0100
To: Jakob Østergaard <jakob@unthought.net>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Ext2 & Performances
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001121190023.R4635@unthought.net>
In-Reply-To: <4.3.2.7.2.20001121174403.00d3e450@mail.tekno-soft.it>
 <4.3.2.7.2.20001121174403.00d3e450@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19.00 21/11/00 +0100, Jakob Østergaard wrote:

>On Tue, Nov 21, 2000 at 05:58:58PM +0100, Roberto Fichera wrote:
> > Hi All,
> >
> > I need to know if there are some differences, in performances, between
> > a ext2 filesystem in a 10Gb partition and another that reside in a 130Gb,
> > each one have 4Kb block size.
> >
> > I'm configuring a Compaq ML350 2x800PIII, 1Gb RAM, 5x36Gb UWS3 RAID 5
> > with Smart Array 4300, as database SQL server. So I need to chose 
> between a
> > single
> > partition of 130Gb or multiple small partitions, depending by the 
> performances.
>
>Does your database *require* a filesystem ?   At least Oracle can do without,
>but I don't know about others...

Currently I'm using PostgreSQL.

>Usually, if you want performance, you let the database use the block device
>without putting a filesystem on top of it.

Yes! I know! Oracle should be a good choice for that.

>You probably don't want a 130G ext2 if there is any chance that a power
>surge etc. can cause the machine to reboot without umount()'ing the
>filesystem.  A fsck on a 130G filesystem is going to take a *long* time.

Yes! I know :-((!!! I'm looking for other fs that are journaled like ext3 
or raiserfs
but I don't know which are a good choice for stability and performances.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
