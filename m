Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBVO66>; Thu, 22 Feb 2001 09:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBVO6t>; Thu, 22 Feb 2001 09:58:49 -0500
Received: from viper.haque.net ([64.0.249.226]:22145 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S129161AbRBVO6f>;
	Thu, 22 Feb 2001 09:58:35 -0500
Date: Thu, 22 Feb 2001 09:58:33 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXT2-fs error
In-Reply-To: <200102220810.f1M8ApJ21675@webber.adilger.net>
Message-ID: <Pine.LNX.4.32.0102220949550.11455-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, here's the whole situtation...

Compiled 2.4.2 and reboot forcing fsck. No errors.

Tried mounting a cd image via loopback to see if loopback was working
again. Mount hangs. Reboot command stalled waiting for filesystems to
unmount. Force with alt-sysreq-<s,u,b>. Booted w/o any errors. Restart
forcing fsck and this time fsck needs to clear some inodes.

Once I am rebooted again, I went to reinstall some rpms for files I saw
fsck complain about and I get these errors.


On Thu, 22 Feb 2001, Andreas Dilger wrote:

> Did fsck complain?  If not, then it is a 2.4.2 kernel/driver bug, possibly
> not reading any data from disk (the below errors are generated from a zero
> filled directory block).
>
> > EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> > #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> > name_len=0
> > EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> > #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> > name_len=0

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

