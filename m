Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSKFRI0>; Wed, 6 Nov 2002 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265839AbSKFRI0>; Wed, 6 Nov 2002 12:08:26 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:2576 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265828AbSKFRIZ>; Wed, 6 Nov 2002 12:08:25 -0500
Date: Wed, 6 Nov 2002 12:16:36 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org
Subject: Compile errors with devicemapper/2.5.46
Message-ID: <Pine.LNX.4.44.0211061210200.26467-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try compiling the devicemapper as a module in 2.5.46, I get the
following error:

------------------------------------------------------------
make -f scripts/Makefile.build obj=drivers/md
  gcc-3.2 -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE   -DKBUILD_BASENAME=dm_ioctl   -c -o drivers/md/dm-ioctl.o
drivers/md/dm-ioctl.c
drivers/md/dm-ioctl.c: In function `create':
drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
`set_device_ro'
drivers/md/dm-ioctl.c: In function `reload':
drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
`set_device_ro'
make[2]: *** [drivers/md/dm-ioctl.o] Error 1
make[1]: *** [drivers/md] Error 2
make: *** [drivers] Error 2
------------------------------------------------------------

I've tried with gcc 2.95.4, and have the same error, so I'm fairly sure
it's not gcc.

Here's the relevant part of .config:

------------------------------------------------------------
#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_DM=m
------------------------------------------------------------

My entire .config file is up at:
http://purdueriots.com/linux-2.5.46.config

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif


