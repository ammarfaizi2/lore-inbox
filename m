Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291161AbSBSLEE>; Tue, 19 Feb 2002 06:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291162AbSBSLDy>; Tue, 19 Feb 2002 06:03:54 -0500
Received: from insgate.stack.nl ([131.155.140.2]:18447 "HELO skynet.stack.nl")
	by vger.kernel.org with SMTP id <S291161AbSBSLDm>;
	Tue, 19 Feb 2002 06:03:42 -0500
Date: Tue, 19 Feb 2002 12:03:39 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t
 VFAT)
In-Reply-To: <200202191025.g1JAPMm11153@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <20020219115519.C97916-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Denis Vlasenko wrote:

> > The type of a partition is written in the partition table, or something
> > similar. Maybe we should check that ?
>
> Partition type isn't available to fs driver. Think about mounting
> floppy/loopback/etc.

True. I never use floppys anymore :)

> Seems you guys are discussing non-problem here. What really needs to be done
> is to add more sanity checks to FAT superblock detection/validation code:
> * signatures like 55AA at end of 1st sector
> * sane values for various superblock data (if you see "FAT copies: 146"
>   it is more than enough to tell it's not a FAT, right?)
>
> If anyone feels so inclined, please go to fs/fat/inode.c:fat_read_super()
> and hack on it. Send your patches to Alexander Viro <viro@math.psu.edu>
> and tighten your seatbelt ;-)

Will hack tonight and see if my seatbelt is strong enough :) It has never
been used before, so maybe...

Jos

