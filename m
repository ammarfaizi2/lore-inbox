Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTBFUz3>; Thu, 6 Feb 2003 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbTBFUz3>; Thu, 6 Feb 2003 15:55:29 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:36736 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267385AbTBFUz2>; Thu, 6 Feb 2003 15:55:28 -0500
Date: Thu, 6 Feb 2003 15:05:11 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
In-Reply-To: <20030206123631.617524f7.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302061501510.998-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Andrew Morton wrote:

> Thomas Molina <tmolina@cox.net> wrote:
> >
> > I have run into an apparent anomaly while compiling/testing 2.5.59-bk.  My 
> > normal mode of operation is to do a daily bk pull to get the latest csets 
> > and do a compile/boot run.  After yesterday's I started seeing problems on 
> > reboot.  During the reboot I would get the OK booting the kernel followed 
> > by a system freeze.  After a forced reboot into a stock RedHat 8.0 2.4 
> > kernel I would see the system misidentify my boot partiton as an ext2 
> > partition and the following messages would appear:
> > 
> 
> Everything you describe is consistent with a kernel which does not have ext3
> compiled into it.
> 
> > EXT2-fs: ide0(3,8): couldn't mount because of unsupported optional feature 
> > (4).
> > Kernel panic: VFS: Unable to mount root fs on 08:08
> > 
> 
> That is an ext3 filesystem in the "needs journal recovery" state.  ext2
> cannot mount that until either fsck or the ext3 kernel driver has run
> recovery.
> 
> grep EXT3 .config ??
> 

I'm aware of that.  I attached the config file showing ext3 was compiled 
in.  I went through several iterations to ensure that having the proper 
filesystem compiled in was done.  

