Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSIARZx>; Sun, 1 Sep 2002 13:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSIARZx>; Sun, 1 Sep 2002 13:25:53 -0400
Received: from p508EAA3C.dip.t-dialin.net ([80.142.170.60]:29444 "EHLO
	tigra.home") by vger.kernel.org with ESMTP id <S317286AbSIARZx>;
	Sun, 1 Sep 2002 13:25:53 -0400
Date: Sun, 1 Sep 2002 19:30:36 +0200
From: Alex Riesen <fork0@users.sf.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre1-ac1: Filesystem panic attempting to mount ext3
Message-ID: <20020901173036.GA20418@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20020901071327.GA404@steel> <87k7m5hccc.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k7m5hccc.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi, Sun, Sep 01, 2002 19:02:59 +0200:
> Alex Riesen <fork0@users.sf.net> writes:
> 
> > Hello,
> > 
> > the problem appeared on the first partition of an ide
> > IBM-DHEA-36481 with one fat partition on it. I repartioned
> > the device (4 primaries) and "mke2fs -j" three of them.
> 
> [...]
> 
> > 
> > Umount produced something as well:
> > 
> > Sep  1 08:47:54 steel kernel: FAT: Did not find valid FSINFO signature.
> > Sep  1 08:47:54 steel kernel: Found signature1 0x0 signature2 0x0 sector=1.
> > 
> > Assuming that some garbage was left on the disk event after mke2fs,
> > i did "dd if=/dev/zero of=/dev/hdd1 bs=512", which cured the problem,
> > after being followed by mke2fs.
> 
> It's problem of fatfs, and I think it's fixed in 2.5 series. I'll try
> to back porting the part of fatfs of 2.5 series.

Thanks.
Does mounting somehow depend on order of initialization of filesystems?
The fatfs is a module here, and it was inserted last (ext3 is compiled in).

-alex
