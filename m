Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRDEW46>; Thu, 5 Apr 2001 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRDEW4t>; Thu, 5 Apr 2001 18:56:49 -0400
Received: from zeus.kernel.org ([209.10.41.242]:65482 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129245AbRDEW4i>;
	Thu, 5 Apr 2001 18:56:38 -0400
Date: Thu, 5 Apr 2001 15:57:38 -0700 (PDT)
From: "Andrew T. Scott" <andrews@tathata.org>
To: adam@cfar.umd.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: ufs fs at 2.2.x and 2.4.x
In-Reply-To: <Pine.GSO.4.21.0009171448450.7933-100000@chia.umiacs.umd.edu>
Message-ID: <Pine.LNX.4.21.0104051556540.2143-100000@tathata.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is it that 2.2.x UFS write support is considered (experimental)?

-Andrew


On Sun, 17 Sep 2000 adam@cfar.umd.edu wrote:

> > > FWIW, I downloaded install 'floppyC28.fs' from openbsd web site.
> > 
> > OK. So did I.
> > 
> > % md5sum floppyC28.fs
> > 2ae3c61008df5accdfb132f20e744bfb  floppyC28.fs
> 
> same here..
> [root@pepsi openbsd]# md5sum floppyC28.fs 
> 2ae3c61008df5accdfb132f20e744bfb  floppyC28.fs
> 
> 
> > > 		mount /dev/fd0 /mnt -t ufs -o ufstype=44bsd,ro
> > 
> > OK. So did I. Afterwards:
> > 
> > % ls -l /mnt
> > total 1332
> > -r-xr-xr-x   1 root     root        53248 Sep 12 13:18 boot
> > -rw-r--r--   1 root     root      1301229 Sep 12 13:18 bsd
> 
> still problems... 
> 
> [root@pepsi /]# df /mnt
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/fd0                  1407      1332        75  95% /mnt
> [root@pepsi /]# mount /mnt
> [root@pepsi /]# mount | grep mnt
> /dev/fd0 on /mnt type ufs (ro,ufstype=44bsd)
> 
> [root@pepsi /]# ls /mnt
> [root@pepsi /]# dmesg | tail -3
> UFS-fs error (device 02:00): ufs_readdir: bad entry in directory #2, size
> 512: reclen is too small for namlen - offset=0, inode=2, reclen=12,
> namlen=260
> UFS-fs error (device 02:00): ufs_readdir: bad entry in directory #2, size
> 512: reclen is too small for namlen - offset=0, inode=2, reclen=12,
> namlen=260
> UFS-fs error (device 02:00): ufs_readdir: bad entry in directory #2, size
> 512: reclen is too small for namlen - offset=0, inode=2, reclen=12,
> namlen=260
> 
> 
> > This was Linux version 2.4.0-test8 (aeb@mette) (gcc version 2.95.2 19991024 (release))
> > So, questions:
> > 1. Are we talking about the same file (same md5sum)?
> 
> yes.
> 
> > 2. Do things improve with 2.4.0-test8?
> 
> Will try it ... sometime. not right now though.. 
> 
> (obtw: i can mount /mnt multiple times.. )
> 
> [root@pepsi /]# umount /mnt
> [root@pepsi /]#     mount /dev/fd0 /mnt -t ufs -o ufstype=44bsd,ro
> [root@pepsi /]#     mount /dev/fd0 /mnt -t ufs -o ufstype=44bsd,ro
> [root@pepsi /]#     mount /dev/fd0 /mnt -t ufs -o ufstype=44bsd,ro
> /dev/fd0 on /mnt type ufs (ro,ufstype=44bsd)
> /dev/fd0 on /mnt type ufs (ro,ufstype=44bsd)
> /dev/fd0 on /mnt type ufs (ro,ufstype=44bsd)
> 
> Is this feature? 
> 
> 

