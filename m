Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131005AbQKUTGV>; Tue, 21 Nov 2000 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131006AbQKUTGA>; Tue, 21 Nov 2000 14:06:00 -0500
Received: from squeaker.ratbox.org ([63.216.218.10]:61650 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S131004AbQKUTFn> convert rfc822-to-8bit; Tue, 21 Nov 2000 14:05:43 -0500
Date: Tue, 21 Nov 2000 13:36:55 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Jakob Østergaard <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Ext2 & Performances
In-Reply-To: <4.3.2.7.2.20001121190033.00d23bc0@mail.tekno-soft.it>
Message-ID: <Pine.LNX.4.21.0011211334530.1902-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to take a look at using reiserfs on the 130GB partition, as
its is journalled and doesn't need to be fsck'ed.  Take a look a
http://devlinux.com/namesys/

Aaron

On Tue, 21 Nov 2000, Roberto Fichera wrote:

> At 19.00 21/11/00 +0100, Jakob Østergaard wrote:
> 
> >On Tue, Nov 21, 2000 at 05:58:58PM +0100, Roberto Fichera wrote:
> > > Hi All,
> > >
> > > I need to know if there are some differences, in performances, between
> > > a ext2 filesystem in a 10Gb partition and another that reside in a 130Gb,
> > > each one have 4Kb block size.
> > >
> > > I'm configuring a Compaq ML350 2x800PIII, 1Gb RAM, 5x36Gb UWS3 RAID 5
> > > with Smart Array 4300, as database SQL server. So I need to chose 
> > between a
> > > single
> > > partition of 130Gb or multiple small partitions, depending by the 
> > performances.
> >
> >Does your database *require* a filesystem ?   At least Oracle can do without,
> >but I don't know about others...
> 
> Currently I'm using PostgreSQL.
> 
> >Usually, if you want performance, you let the database use the block device
> >without putting a filesystem on top of it.
> 
> Yes! I know! Oracle should be a good choice for that.
> 
> >You probably don't want a 130G ext2 if there is any chance that a power
> >surge etc. can cause the machine to reboot without umount()'ing the
> >filesystem.  A fsck on a 130G filesystem is going to take a *long* time.
> 
> Yes! I know :-((!!! I'm looking for other fs that are journaled like ext3 
> or raiserfs
> but I don't know which are a good choice for stability and performances.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
