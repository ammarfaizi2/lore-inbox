Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbSJIPH4>; Wed, 9 Oct 2002 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbSJIPH4>; Wed, 9 Oct 2002 11:07:56 -0400
Received: from apollo.sot.fi ([195.74.13.237]:54278 "EHLO vscan.sot.com")
	by vger.kernel.org with ESMTP id <S261800AbSJIPHz>;
	Wed, 9 Oct 2002 11:07:55 -0400
Date: Wed, 9 Oct 2002 18:14:28 +0300 (EEST)
From: Yaroslav Popovitch <yp@sot.com>
To: linux-kernel@vger.kernel.org
Subject: initrd's ramdisk mounted in read-only mode
Message-ID: <Pine.LNX.4.44.0210091704320.21553-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. I was making boot image for CD with kernel-2.4.19 and found that 
ramdisk is mounted in read-only mode. On previous kernel 2.4.12 it was 
working ok.

I passed "rw" option according to initrd documentation and ramdisk was 
mounted in  rw modes.
I checked mount points by "cat /proc/mounts" and found that 
 	/dev/rootfs mounted on /
	/dev/root	       / 

If /dev/rootfs is mounted, is it mean, that there was an error during 
mounting ramdisk?
Why /dev/rootfs is still mounted? And why ramdisk is mounted in read-only 
mode?

Here it is my default  settings to grub-bootloader:
root=(fd0)
kernel=/boot/vmlinuz.gz root=/dev/ram0 load_ramdisk=1
initrd=/initrd.gz

Modified with rw option:
root=(fd0)
kernel=/boot/vmlinuz.gz root=/dev/ram0 init=/linuxrc rw load_ramdisk=1
initrd=/initrd.gz


Cheers,YP

-
Mr. Yaroslav Popovitch yp@sot.com       - tel. +372 6419975
SOT Finnish Software Engineering Ltd.   - fax  +372 6419975
Kreutzwaldi 7-4, 10124  TALLINN         - http://www.sot.com
ESTONIA                                 - http://bestlinux.net

