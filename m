Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSDECuj>; Thu, 4 Apr 2002 21:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311269AbSDECua>; Thu, 4 Apr 2002 21:50:30 -0500
Received: from mta02ps.bigpond.com ([144.135.25.134]:38613 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S311264AbSDECuZ>; Thu, 4 Apr 2002 21:50:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Barry Kirsten <bjkirsten@bigpond.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem mounting Zip
Date: Fri, 5 Apr 2002 12:51:08 +1000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020405025026Z311264-616+5710@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all. 
 
I am a relative newcomer to Linux and am posting this on advice from my local 
Linux user group (Victoria, Australia), concerning a wierd problem I am 
having mounting my Zip files. 
 
Iam running Mandrake 8.1 on a 266 MB K6-2 with 256 MB RAM. My CD, CD-RW and 
floppy drives work, and I _have_ had my zip drive working on one occasion 
using the command: "mount -t vfat /dev/sda4 /mnt/zip2", but that appears to 
have been a fluke. The following are results of some of the things I've 
tried: 
 
/etc/fstab 
/dev/hda1 / ext2 defaults 1 1 
none /dev/pts devpts mode=0620 0 0 
none /dev/shm tmpfs defaults 0 0 
/dev/hda6 /home ext2 defaults 1 2 
/dev/hdb /mnt/cdrom auto 
user,iocharset=iso8859-1,umask=0,exec,codepage=850,ro,noauto 0 0 
/dev/scd0 /mnt/cdrom2 auto 
user,iocharset=iso8859-1,umask=0,exec,codepage=850,ro,noauto 0 0 
/dev/fd0 /mnt/floppy auto 
user,iocharset=iso8859-1,umask=0,sync,exec,codepage=850,noauto 0 0 
/dev/sda /mnt/zip auto 
user,iocharset=iso8859-1,umask=0,sync,exec,codepage=850,noauto 0 0 
/dev/sda4 /mnt/zip2 auto 
user,iocharset=iso8859-1,umask=0,sync,exec,codepage=850,noauto 0 0 
none /proc proc defaults 0 0 
/dev/hda5 swap swap defaults 0 0 
 
dmesg 
ppa: Version 2.07 (for Linux 2.4.x) 
ppa: Found device at ID 6, Attempting to use EPP 32 bit 
ppa: Found device at ID 6, Attempting to use PS/2 
ppa: Communication established with ID 6 using PS/2 
scsi0 : Iomega VPI0 (ppa) interface 
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.09 
  Type:   Direct-Access                      ANSI SCSI revision: 02 
 
cat /proc/partitions 
[root@localhost proc]# cat /proc/partitions 
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse 
running use aveq 
 
   3     0   20044080 ide/host0/bus0/target0/lun0/disc 7338 31157 308020 
61400 2382 636 24432 17810 0 52350 79210 
   3     1    3582463 ide/host0/bus0/target0/lun0/part1 4700 14911 156882 
30630 
1642 342 16120 12610 0 28540 43240 
   3     2          1 ide/host0/bus0/target0/lun0/part2 0 0 0 0 0 0 0 0 0 0 0 
   3     5     248976 ide/host0/bus0/target0/lun0/part5 1 0 8 10 0 0 0 0 0 10 
10   3     6   16209553 ide/host0/bus0/target0/lun0/part6 2637 16246 151130 
30760 
740 294 8312 5200 0 24430 35960 
 
[root@localhost proc]# ls -l /dev/sda 
lr-xr-xr-x    1 root     root           33 Apr  5  2002 /dev/sda -> 
scsi/host1/bus0/target6/lun0/disc 
 
The listing for /dev/sda is flashing, which I believe means that the link is 
dangling. The concensus appears to be that "scsi0" isn't creating an entry in 
/proc/partitions, so it hasn't registered a block device, which indicates a 
possible ppa/scsi driver problem. What do ppl think? 
 
Any help greatly appreciated. Please CC me.  I haven't joined the list 
as yet, as 99% of it would probably go over my head. Gimme time :-) 
 
Thanks, 
Barry 
