Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280709AbRKBO4R>; Fri, 2 Nov 2001 09:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280712AbRKBO4J>; Fri, 2 Nov 2001 09:56:09 -0500
Received: from [202.108.44.221] ([202.108.44.221]:7925 "HELO wm4.163.com")
	by vger.kernel.org with SMTP id <S280711AbRKBOzw>;
	Fri, 2 Nov 2001 09:55:52 -0500
Message-Id: <3BE2B180.28918@bj221.163.com>
Date: Fri, 2 Nov 2001 22:45:20 +0800 (CST)
From: =?ISO-8859-1?Q? "=CD=F5=C0=E8=C3=F7" ?= <firetiger977@163.com>
To: linux-kernel@vger.kernel.org
Subject: RE: OOPS: reiserfs panic
X-Priority: 1
X-Originating-IP: [211.99.162.14]
X-Mailer: COREMAIL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RedHat 7.2 shipped with kernel 2.4.7.
I have tried the 2.4.14-pre7, panic too.

 
/var/log/messages:

Nov  3 17:35:32 localhost kernel: vs-5150: search_by_key: invalid format 
found in block 20795. Fsck?

Nov  3 17:35:32 localhost kernel: vs-13050: reiserfs_update_sd: i/o failure 
occurred trying to update [44468 44476 0x0 SD] stat data<4>is_leaf: item 
location seems wrong (second one): *NEW* [44468 44474 0x0 SD], item_len 44, 
item_location 4084, free_space(entry_count) 65535

 
fdisk output:

Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders

Units = cylinders of 16065 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System

   /dev/hda1             1       383   3076416    b  Win95 FAT32
   /dev/hda2           384       893   4096575    7  HPFS/NTFS
   /dev/hda3   *       894       912    152617+  83  Linux
   /dev/hda4           913      5005  32877022+   f  Win95 Ext'd (LBA)
   /dev/hda5           913      1422   4096543+   7  HPFS/NTFS
   /dev/hda6          1423      2442   8193118+   b  Win95 FAT32
   /dev/hda7          2443      3717  10241406    b  Win95 FAT32
   /dev/hda8          3718      4227   4096543+  83  Linux
   /dev/hda9          4228      4278    409626   82  Linux swap
   /dev/hda10         4279      5005   5839596   83  Linux

 The reiserfs created at hda10.

 
3.x.0k-pre10

mkreiserfs /dev/hda10 display:

mkreiserfs: Guessing about desired format..
mkreiserfs: Kernel 2.4.14-pre7 is running.

13107k will be used
Block 16 (0x30a) contains super block of format 3.6 with standart journal
Block count: 1459899
Bitmap number: 45
Blocksize: 4096
Free blocks: 1451643
Root block: 8211
Tree height: 2
Hash function used to sort names: "r5"
Objectid map size 2, max 972
Journal parameters:
        Device [0x0]
        Magic [0x527942af]
        Size 8193 (including journal header) (first block 18)
        Max transaction length 1024
        Max batch size 900
        Max commit age 30
      Spase reserved by journal: 0
      Correctness checked after mount 1
      Fsck field 0x0

 

 

 

 

=============================================================
http://dating.163.com    倾心的约会对象，完全可以这里掌握！
http://sms.163.com       美好的感情在于不断的联系！
http://stock.163.com     解股市烦恼，打开财富之门由此开始 ...

 





