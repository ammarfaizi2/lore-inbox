Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSIAS5s>; Sun, 1 Sep 2002 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSIAS5s>; Sun, 1 Sep 2002 14:57:48 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:34066 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317329AbSIAS5q>; Sun, 1 Sep 2002 14:57:46 -0400
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre1-ac1: Filesystem panic attempting to mount ext3
References: <20020901071327.GA404@steel> <87k7m5hccc.fsf@devron.myhome.or.jp>
	<20020901173036.GA20418@steel>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 02 Sep 2002 04:02:04 +0900
In-Reply-To: <20020901173036.GA20418@steel>
Message-ID: <87n0r1h6tv.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <fork0@users.sf.net> writes:

> OGAWA Hirofumi, Sun, Sep 01, 2002 19:02:59 +0200:
> > Alex Riesen <fork0@users.sf.net> writes:
> > 
> > > Hello,
> > > 
> > > the problem appeared on the first partition of an ide
> > > IBM-DHEA-36481 with one fat partition on it. I repartioned
> > > the device (4 primaries) and "mke2fs -j" three of them.
> > 
> > [...]
> > 
> > > 
> > > Umount produced something as well:
> > > 
> > > Sep  1 08:47:54 steel kernel: FAT: Did not find valid FSINFO signature.
> > > Sep  1 08:47:54 steel kernel: Found signature1 0x0 signature2 0x0 sector=1.
> > > 
> > > Assuming that some garbage was left on the disk event after mke2fs,
> > > i did "dd if=/dev/zero of=/dev/hdd1 bs=512", which cured the problem,
> > > after being followed by mke2fs.
> > 
> > It's problem of fatfs, and I think it's fixed in 2.5 series. I'll try
> > to back porting the part of fatfs of 2.5 series.
> 
> Thanks.
> Does mounting somehow depend on order of initialization of filesystems?
> The fatfs is a module here, and it was inserted last (ext3 is compiled in).

Well, the filesystem is detected by the mount command, except the root
filesystem. And mount command detects FAT before EXT3.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
