Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKHXET>; Wed, 8 Nov 2000 18:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKHXEJ>; Wed, 8 Nov 2000 18:04:09 -0500
Received: from topaz.3com.com ([192.156.136.158]:37589 "EHLO topaz.3com.com")
	by vger.kernel.org with ESMTP id <S129171AbQKHXD4>;
	Wed, 8 Nov 2000 18:03:56 -0500
X-Lotus-FromDomain: 3COM
From: Steven_Snyder@3com.com
To: linux-kernel@vger.kernel.org
Message-ID: <88256991.007ED337.00@hqoutbound.ops.3com.com>
Date: Wed, 8 Nov 2000 17:03:44 -0600
Subject: 2.4.0-test10: "fatfs: bogus cluster size"
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello.

I am attempting to boot off a Compact Flash device which has a UMSDOS
filesystem.  When I do, I get text that looks like this:

     Partition check:
      hdc: hdc1 hdc2
     .
     .
     hdc: hdc1 hdc2
     hdc: hdc1 hdc2
     fatfs: bogus cluster size
     fatfs: bogus cluster size
     UMSDOS: msdos_read_super failed, mount aborted.

The bootable partion (/dev/hdc1) has a FAT16 filesystem and was created by
MS-DOS v6.2.  The 2nd partition (/dev/hdc2) is a Linux swap partition.  The
kernel itself is loaded by loadlin (not LILO).

This is a snippet of my configuration:

     CONFIG_FAT_FS=y
     CONFIG_MSDOS_FS=y
     CONFIG_UMSDOS_FS=y
     CONFIG_PROC_FS=y
     CONFIG_DEVPTS_FS=y
     CONFIG_EXT2_FS=y

The cluster size on this 128MB disk (a "SanDisk SDCFB-128 ATA DISK drive") is, I
 think, 2048 bytes.

(Of  possible relevance: when I do a "chkdsk" on this device, from either DOS or
Win95, I get a report that the validity cannot be checked because a path name is
illegally  longer  than  67  characters.   I  built  this  drive  by  installing
Slackware's ZipSlack package, then updating to the v2.4.0-test10 kernel.)

So... any thoughts on how to fix this complaint about cluster size?

Thank you.

(Sorry about the advertisement below.)




PLANET PROJECT will connect millions of people worldwide through the combined
technology of 3Com and the Internet. Find out more and register now at
http://www.planetproject.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
