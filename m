Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbTDHRDe (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbTDHRDe (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:03:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:24193 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261608AbTDHRDd convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:03:33 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66 Unable to update partition table 
Date: Tue, 8 Apr 2003 09:12:04 -0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304081012.04370.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not able to update partition table with 2.5.66.
I get following error message when I try to create a
new partition.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table.
The new table will be used at the next reboot.
Syncing disks.

Any ideas on why ? Is this expected ?

Thanks,
Badari

[root@elm3b78 root]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda6               381139    322588     38873  90% /
/dev/sda1                46636     43116      1112  98% /boot
none                   1941612         0   1941612   0% /dev/shm
/dev/sda2              9890888   8442076    946380  90% /usr
/dev/sdb5             16476952  10891916   4748052  70% /home
/dev/sda7               256667     80265    163150  33% /var


[root@elm3b78 root]# fdisk /dev/sdb

The number of cylinders for this disk is set to 2212.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/sdb: 255 heads, 63 sectors, 2212 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb2           129      2212  16739730    5  Extended
/dev/sdb5           129      2212  16739698+  83  Linux

Command (m for help): n
Command action
   l   logical (5 or over)
   p   primary partition (1-4)
Partition number (1-4): 1
First cylinder (1-2212, default 1):
Using default value 1
Last cylinder or +size or +sizeM or +sizeK (1-128, default 128):
Using default value 128

Command (m for help): p

Disk /dev/sdb: 255 heads, 63 sectors, 2212 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1             1       128   1028128+  83  Linux
/dev/sdb2           129      2212  16739730    5  Extended
/dev/sdb5           129      2212  16739698+  83  Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table.
The new table will be used at the next reboot.
Syncing disks.

