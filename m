Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTBAOz1>; Sat, 1 Feb 2003 09:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTBAOz1>; Sat, 1 Feb 2003 09:55:27 -0500
Received: from tag.witbe.net ([81.88.96.48]:55818 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S264853AbTBAOzZ>;
	Sat, 1 Feb 2003 09:55:25 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: "'Paul Rolland'" <rol@as2917.net>
Subject: Linux 2.4.20 - Bunch of EXT2-fs error
Date: Sat, 1 Feb 2003 16:04:49 +0100
Message-ID: <001601c2ca03$44871010$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: High
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've a machine running Linux 2.4.20 and which is displaying
these on the console :
EXT2-fs error (device sd(8,18)): ext2_write_inode: unable to read inode
block - inode=549972, block=1081642
EXT2-fs error (device sd(8,18)): read_block_bitmap: Cannot read block
bitmap - block_group = 39, block_bitmap = 1277952
EXT2-fs error (device sd(8,9)): ext2_write_inode: unable to read inode
block - inode=12310, block=49166
EXT2-fs error (device sd(8,9)): ext2_write_inode: unable to read inode
block - inode=12311, block=49166
EXT2-fs error (device sd(8,9)): ext2_write_inode: unable to read inode
block - inode=38852, block=155665
EXT2-fs error (device sd(8,9)): ext2_write_inode: unable to read inode
block - inode=38856, block=155665
EXT2-fs error (device sd(8,18)): ext2_write_inode: unable to read inode
block - inode=541026, block=1081363
....

Not only that, but also trying to run commands results in
Input/Output error :

bash-2.05# umount /dev/sda5
bash: /bin/umount: Input/output error
bash-2.05# reboot
EXT2-fs error (device sd(8,5)): ext2_write_inode: unable to read inode
block - inode=163903, block=327685
bash: /usr/bin/reboot: Input/output error

What's going on ?

Here is a copy of /etc/fstab and /proc/partitions 
bash-2.05# cat fstab
LABEL=/                 /                       ext2    defaults
1 1
LABEL=/boot             /boot                   ext2    defaults
1 2
none                    /dev/pts                devpts  gid=5,mode=620
0 0
none                    /proc                   proc    defaults
0 0
#none                    /dev/shm                tmpfs   defaults
0 0
LABEL=/tmp              /tmp                    ext2    defaults
1 2
LABEL=/u01              /u01                    ext2    defaults
1 2
LABEL=/usr              /usr                    ext2    defaults
1 2
LABEL=/var              /var                    ext2    defaults
1 2
/dev/sdb2               /u02                    ext2    defaults
1 2
/dev/sdc2               /u03                    ext2    defaults
1 2
/dev/sda3               swap                    swap    defaults
0 0
/dev/sdb1               swap                    swap    defaults
0 0
/dev/sdc1               swap                    swap    defaults
0 0
/dev/cdrom              /mnt/cdrom              iso9660
noauto,owner,kudzu,ro 0 0
/dev/fd0                /mnt/floppy             auto
noauto,owner,kudzu 0 0

major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect
wuse running use aveq

   8     0   71678592 sda 66321 115222 1268480 2207070 161924 256121
3116304 14942220 0 1429590 17149230
   8     1      32098 sda1 6 18 48 10 0 0 0 0 0 10 10
   8     2     265072 sda2 63 563 1252 390 5 2 14 130 0 250 520
   8     3    2096482 sda3 2 0 16 0 0 0 0 0 0 0 0
   8     4          1 sda4 0 0 0 0 0 0 0 0 0 0 0
   8     5    2096451 sda5 23516 1667 201458 7340 27444 4226 254272
58440 0 16830 65780
   8     6    3148708 sda6 13903 1304 121410 25570 6445 1165 61528
13290140 0 229230 13315720
   8     7   62942638 sda7 15418 95200 884530 2060070 106142 234338
2723840 482270 0 1382240 2542270
   8     8     522081 sda8 38 33 142 130 264 2376 5280 4510 0 870 4640
   8     9     522081 sda9 13368 16416 59568 113500 21624 14014 71370
1106730 0 275560 1220220
   8    16   71678592 sdb 130838 413501 4354274 595520 267920 430758
5596704 751240 0 599880 1347600
   8    17    2096482 sdb1 2 0 16 0 0 0 0 0 0 0 0
   8    18   69577515 sdb2 130835 413498 4354250 595520 267920 430758
5596704 751250 0 599860 1347580
   8    32   71678592 sdc 60418 1417060 3184236 259440 69082 181066
1987874 1994140 0 365330 2253500
   8    33    2096482 sdc1 2 0 16 0 0 0 0 0 0 0 0
   8    34   69577515 sdc2 60415 1417057 3184212 259440 69082 181066
1987874 1994140 0 365330 2253500


Could someone help me ?
Regards,
Paul



Paul, rol@as2917.net

