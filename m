Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318715AbSICGSr>; Tue, 3 Sep 2002 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSICGSr>; Tue, 3 Sep 2002 02:18:47 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:41745 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S318715AbSICGSo>; Tue, 3 Sep 2002 02:18:44 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Sep 2002 08:22:13 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: ext2 anomaly when making filesystem?
Message-ID: <3D747134.9290.1A2BFC@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.12/Sophos-3.59+2.10+2.03.098+01 July 2002+74528@20020903.061944Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm late with this issue, and I hope that the forum is not completely 
wrong:

I had a desaster with one of my Linux partitions (Windows/98 shreddered 
it), so I had to make the filesystem anew. I used mke2fs 1.26 from SuSE 
8.0.

Being curious, I dumped the metadata after creation and found some odd 
thing: For several allocation groups there was a gap in the free 
blocks. First I thought it is intentional; maybe to put administrative 
data in the moddle of the allocation group, but then I found that other 
groups had no such gap. I'll attach the dump at the end.

If it's intentional, maybe add some documentation about the layout to 
the manual pages; if it's a bug, it would be nice to see it fixed.

Regards,
Ulrich
mke2fs -v -L home -i 32768 /dev/sda6
Filesystem volume name:   home
Last mounted on:          <not available>
Filesystem UUID:          7a6cede5-d4df-42a6-9392-6421f5f2ee41
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      filetype sparse_super
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              129024
Block count:              1024135
Reserved block count:     51206
Free blocks:              1020018
Free inodes:              129013
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         4032
Inode blocks per group:   126
Last mount time:          Thu Jan  1 01:00:00 1970
Last write time:          Sun Jul  7 17:52:08 2002
Mount count:              0
Maximum mount count:      39
Last checked:             Sun Jul  7 17:52:08 2002
Check interval:           15552000 (6 months)
Next check after:         Fri Jan  3 16:52:08 2003
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:		  128


Group 0: (Blocks 0-32767)
  Primary Superblock at 0,  Group Descriptors at 1-1
  Block bitmap at 2 (+2), Inode bitmap at 3 (+3)
  Inode table at 4-129 (+4)
  32633 free blocks, 4021 free inodes, 2 directories
  Free blocks: 135-32767
  Free inodes: 12-4032
Group 1: (Blocks 32768-65535)
  Backup Superblock at 32768,  Group Descriptors at 32769-32769
  Block bitmap at 32770 (+2), Inode bitmap at 32771 (+3)
  Inode table at 32772-32897 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 32898-65535
  Free inodes: 4033-8064
Group 2: (Blocks 65536-98303)
  Block bitmap at 65536 (+0), Inode bitmap at 65537 (+1)
  Inode table at 65540-65665 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 65538-65539, 65666-98303
  Free inodes: 8065-12096
Group 3: (Blocks 98304-131071)
  Backup Superblock at 98304,  Group Descriptors at 98305-98305
  Block bitmap at 98306 (+2), Inode bitmap at 98307 (+3)
  Inode table at 98308-98433 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 98434-131071
  Free inodes: 12097-16128
Group 4: (Blocks 131072-163839)
  Block bitmap at 131072 (+0), Inode bitmap at 131073 (+1)
  Inode table at 131076-131201 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 131074-131075, 131202-163839
  Free inodes: 16129-20160
Group 5: (Blocks 163840-196607)
  Backup Superblock at 163840,  Group Descriptors at 163841-163841
  Block bitmap at 163842 (+2), Inode bitmap at 163843 (+3)
  Inode table at 163844-163969 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 163970-196607
  Free inodes: 20161-24192
Group 6: (Blocks 196608-229375)
  Block bitmap at 196608 (+0), Inode bitmap at 196609 (+1)
  Inode table at 196612-196737 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 196610-196611, 196738-229375
  Free inodes: 24193-28224
Group 7: (Blocks 229376-262143)
  Backup Superblock at 229376,  Group Descriptors at 229377-229377
  Block bitmap at 229378 (+2), Inode bitmap at 229379 (+3)
  Inode table at 229380-229505 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 229506-262143
  Free inodes: 28225-32256
Group 8: (Blocks 262144-294911)
  Block bitmap at 262144 (+0), Inode bitmap at 262145 (+1)
  Inode table at 262148-262273 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 262146-262147, 262274-294911
  Free inodes: 32257-36288
Group 9: (Blocks 294912-327679)
  Backup Superblock at 294912,  Group Descriptors at 294913-294913
  Block bitmap at 294914 (+2), Inode bitmap at 294915 (+3)
  Inode table at 294916-295041 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 295042-327679
  Free inodes: 36289-40320
Group 10: (Blocks 327680-360447)
  Block bitmap at 327680 (+0), Inode bitmap at 327681 (+1)
  Inode table at 327684-327809 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 327682-327683, 327810-360447
  Free inodes: 40321-44352
Group 11: (Blocks 360448-393215)
  Block bitmap at 360448 (+0), Inode bitmap at 360449 (+1)
  Inode table at 360452-360577 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 360450-360451, 360578-393215
  Free inodes: 44353-48384
Group 12: (Blocks 393216-425983)
  Block bitmap at 393216 (+0), Inode bitmap at 393217 (+1)
  Inode table at 393220-393345 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 393218-393219, 393346-425983
  Free inodes: 48385-52416
Group 13: (Blocks 425984-458751)
  Block bitmap at 425984 (+0), Inode bitmap at 425985 (+1)
  Inode table at 425988-426113 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 425986-425987, 426114-458751
  Free inodes: 52417-56448
Group 14: (Blocks 458752-491519)
  Block bitmap at 458752 (+0), Inode bitmap at 458753 (+1)
  Inode table at 458756-458881 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 458754-458755, 458882-491519
  Free inodes: 56449-60480
Group 15: (Blocks 491520-524287)
  Block bitmap at 491520 (+0), Inode bitmap at 491521 (+1)
  Inode table at 491524-491649 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 491522-491523, 491650-524287
  Free inodes: 60481-64512
Group 16: (Blocks 524288-557055)
  Block bitmap at 524288 (+0), Inode bitmap at 524289 (+1)
  Inode table at 524292-524417 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 524290-524291, 524418-557055
  Free inodes: 64513-68544
Group 17: (Blocks 557056-589823)
  Block bitmap at 557056 (+0), Inode bitmap at 557057 (+1)
  Inode table at 557060-557185 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 557058-557059, 557186-589823
  Free inodes: 68545-72576
Group 18: (Blocks 589824-622591)
  Block bitmap at 589824 (+0), Inode bitmap at 589825 (+1)
  Inode table at 589828-589953 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 589826-589827, 589954-622591
  Free inodes: 72577-76608
Group 19: (Blocks 622592-655359)
  Block bitmap at 622592 (+0), Inode bitmap at 622593 (+1)
  Inode table at 622596-622721 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 622594-622595, 622722-655359
  Free inodes: 76609-80640
Group 20: (Blocks 655360-688127)
  Block bitmap at 655360 (+0), Inode bitmap at 655361 (+1)
  Inode table at 655364-655489 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 655362-655363, 655490-688127
  Free inodes: 80641-84672
Group 21: (Blocks 688128-720895)
  Block bitmap at 688128 (+0), Inode bitmap at 688129 (+1)
  Inode table at 688132-688257 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 688130-688131, 688258-720895
  Free inodes: 84673-88704
Group 22: (Blocks 720896-753663)
  Block bitmap at 720896 (+0), Inode bitmap at 720897 (+1)
  Inode table at 720900-721025 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 720898-720899, 721026-753663
  Free inodes: 88705-92736
Group 23: (Blocks 753664-786431)
  Block bitmap at 753664 (+0), Inode bitmap at 753665 (+1)
  Inode table at 753668-753793 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 753666-753667, 753794-786431
  Free inodes: 92737-96768
Group 24: (Blocks 786432-819199)
  Block bitmap at 786432 (+0), Inode bitmap at 786433 (+1)
  Inode table at 786436-786561 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 786434-786435, 786562-819199
  Free inodes: 96769-100800
Group 25: (Blocks 819200-851967)
  Backup Superblock at 819200,  Group Descriptors at 819201-819201
  Block bitmap at 819202 (+2), Inode bitmap at 819203 (+3)
  Inode table at 819204-819329 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 819330-851967
  Free inodes: 100801-104832
Group 26: (Blocks 851968-884735)
  Block bitmap at 851968 (+0), Inode bitmap at 851969 (+1)
  Inode table at 851972-852097 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 851970-851971, 852098-884735
  Free inodes: 104833-108864
Group 27: (Blocks 884736-917503)
  Backup Superblock at 884736,  Group Descriptors at 884737-884737
  Block bitmap at 884738 (+2), Inode bitmap at 884739 (+3)
  Inode table at 884740-884865 (+4)
  32638 free blocks, 4032 free inodes, 0 directories
  Free blocks: 884866-917503
  Free inodes: 108865-112896
Group 28: (Blocks 917504-950271)
  Block bitmap at 917504 (+0), Inode bitmap at 917505 (+1)
  Inode table at 917508-917633 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 917506-917507, 917634-950271
  Free inodes: 112897-116928
Group 29: (Blocks 950272-983039)
  Block bitmap at 950272 (+0), Inode bitmap at 950273 (+1)
  Inode table at 950276-950401 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 950274-950275, 950402-983039
  Free inodes: 116929-120960
Group 30: (Blocks 983040-1015807)
  Block bitmap at 983040 (+0), Inode bitmap at 983041 (+1)
  Inode table at 983044-983169 (+4)
  32640 free blocks, 4032 free inodes, 0 directories
  Free blocks: 983042-983043, 983170-1015807
  Free inodes: 120961-124992
Group 31: (Blocks 1015808-1024134)
  Block bitmap at 1015808 (+0), Inode bitmap at 1015809 (+1)
  Inode table at 1015812-1015937 (+4)
  8199 free blocks, 4032 free inodes, 0 directories
  Free blocks: 1015810-1015811, 1015938-1024134
  Free inodes: 124993-129024

