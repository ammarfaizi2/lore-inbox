Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbREQDOB>; Wed, 16 May 2001 23:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbREQDNv>; Wed, 16 May 2001 23:13:51 -0400
Received: from radio.protv.ro ([193.230.227.51]:63758 "EHLO radio.protv.ro")
	by vger.kernel.org with ESMTP id <S261367AbREQDNm>;
	Wed, 16 May 2001 23:13:42 -0400
Message-ID: <3873.193.230.227.44.990069222.squirrel@radio.protv.ro>
Date: Thu, 17 May 2001 06:13:42 +0300 (EEST)
Subject: Ide Floppy problems 
From: "Mihai Moldovanu" <mihaim@profm.ro>
To: linux-kernel@vger.kernel.org
Reply-To: mihaim@profm.ro
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First this my configuration:

Kernel 2.4.4 / Athlon 650

May 17 05:38:45 m kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
May 17 05:38:45 m kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 17 05:38:45 m kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 17 05:38:45 m kernel: hda: 60036480 sectors (30739 MB) w/1916KiB Cache,
CHS=29314/64/32, UDMA(100)
May 17 05:38:45 m kernel: hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
May 17 05:38:45 m kernel: Uniform CD-ROM driver Revision: 3.12
May 17 05:38:45 m kernel: hdd: 98304kB, 196608 blocks, 512 sector size,
May 17 05:38:45 m kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector
size, 2941 rpm

then i did the following:

[root@m /mnt]# mount /dev/hdd4 /mnt/zip
[root@m /mnt]# cp /linux-2.4.4.tar.bz2 /mnt/zip
[root@m /mnt]# sync

May 17 05:42:20 m kernel: hdd: lost interrupt
May 17 05:42:20 m kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr
May 17 05:42:20 m kernel: hdd: ATAPI reset complete
May 17 05:43:10 m kernel: hdd: lost interrupt
May 17 05:43:10 m kernel: ide-floppy: CoD != 0 in idefloppy_pc_intr
May 17 05:43:10 m kernel: hdd: ATAPI reset complete

After few minutes and lots of that messages I ejected the zip.

May 17 05:46:19 m kernel: end_request: I/O error, dev 16:44 (hdd), sector 56533
May 17 05:46:19 m kernel: ide-floppy: hdd: I/O error, pc = 2a, key =  2, asc
= 3a, ascq =  0

After another 1 minute of this repeated messages I push reset .
Any ideeas ?


-- 
TFM Group Romania , Linux division

Mihai Moldovanu
http://www.tfm.ro/
http://portal.tfm.ro/



