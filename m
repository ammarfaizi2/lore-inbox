Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbSKLXUd>; Tue, 12 Nov 2002 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbSKLXUc>; Tue, 12 Nov 2002 18:20:32 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:53004 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S267027AbSKLXUb>;
	Tue, 12 Nov 2002 18:20:31 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200211122327.gACNRFH21238@oboe.it.uc3m.es>
Subject: 2.5.46 won't boot with root=/dev/hda5, does with /dev/ide.../part5
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Wed, 13 Nov 2002 00:27:15 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.44 booted fine with root=/dev/hda5 on my laptop (one ide disk, all
ext2).

2.5.46 stopped at VFS cannot blah blah "hda5", after reading the
partition table fine.

I got 2.5.47 to boot (gave up on 2.5.46) by using the
root=/dev/ide/../part5 param instead.

Yes, it took me a week to think of that.

There was no change between configs except what make oldconfig
threw up to make a decision on (and I always say no).

Choice selections from config ..

  ...
  # CONFIG_HPFS_FS is not set
  CONFIG_PROC_FS=y
  CONFIG_DEVFS_FS=y
  # CONFIG_DEVFS_MOUNT is not set
  # CONFIG_DEVFS_DEBUG is not set
  CONFIG_DEVPTS_FS=y
  # CONFIG_QNX4FS_FS is not set
  CONFIG_ROMFS_FS=m
  CONFIG_EXT2_FS=y
  CONFIG_EXT2_FS_XATTR=y
  # CONFIG_EXT2_FS_POSIX_ACL is not set
  CONFIG_SYSV_FS=m
  ...


Peter
