Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129728AbQKXJOP>; Fri, 24 Nov 2000 04:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129971AbQKXJOG>; Fri, 24 Nov 2000 04:14:06 -0500
Received: from linus.st-and.ac.uk ([138.251.32.11]:63220 "EHLO
        linus.st-andrews.ac.uk") by vger.kernel.org with ESMTP
        id <S129728AbQKXJNn>; Fri, 24 Nov 2000 04:13:43 -0500
Date: Fri, 24 Nov 2000 08:42:06 GMT
Message-Id: <200011240842.IAA07873@hindleyhome.st-andrews.ac.uk>
From: Mark Hindley <mh15@st-andrews.ac.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] ? ide-scsi 2.4.0-test11. Can't mount iso9660 cd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can not mount an  cd in either my cdrom or cdrw drives. Both are ide
drives using scsi-ide emulation.

During the mount the logs show:

Nov 23 10:03:27 hindleyhome kernel: VFS: Disk change detected on device sr(11,0)
Nov 23 10:03:29 hindleyhome kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
Nov 23 10:03:29 hindleyhome kernel: ISO 9660 Extensions: RRIP_1991A
Nov 23 10:05:38 hindleyhome kernel:  I/O error: dev 0b:00, sector 0
Nov 23 10:05:38 hindleyhome kernel:  I/O error: dev 0b:00, sector 0
Nov 23 10:05:38 hindleyhome kernel: MSDOS: Hardware sector size is 2048
Nov 23 10:05:38 hindleyhome kernel:  I/O error: dev 0b:00, sector 0
Nov 23 10:05:38 hindleyhome kernel: FAT bread failed
Nov 23 10:05:38 hindleyhome kernel: MSDOS: Hardware sector size is 2048
Nov 23 10:05:38 hindleyhome kernel:  I/O error: dev 0b:00, sector 0
Nov 23 10:05:38 hindleyhome kernel: FAT bread failed

The boot logs are:

Nov 23 09:00:48 hindleyhome kernel: Linux version 2.4.0-test11 (root@HindleyHome) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #59 Thu Nov 23 08:54:15 GMT 2000
(...)
Nov 23 09:00:48 hindleyhome kernel: ide-cd: passing drive hdc to ide-scsi emulation.
Nov 23 09:00:48 hindleyhome kernel: ide-cd: passing drive hdd to ide-scsi emulation.
(...)
Nov 23 09:00:48 hindleyhome kernel: SCSI subsystem driver Revision: 1.00
Nov 23 09:00:48 hindleyhome kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Nov 23 09:00:48 hindleyhome kernel:   Vendor: YAMAHA    Model: CRW4416E          Rev: 1.0h
Nov 23 09:00:48 hindleyhome kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov 23 09:00:48 hindleyhome kernel:   Vendor: PIONEER   Model: CD-ROM DR-A24X    Rev: 1.04
Nov 23 09:00:48 hindleyhome kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Nov 23 09:00:48 hindleyhome kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Nov 23 09:00:48 hindleyhome kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Nov 23 09:00:48 hindleyhome kernel: sr0: scsi3-mmc drive: 6x/6x writer cd/rw xa/form2 cdda tray
Nov 23 09:00:48 hindleyhome kernel: Uniform CD-ROM driver Revision: 3.11
Nov 23 09:00:48 hindleyhome kernel: sr1: scsi3-mmc drive: 20x/20x
xa/form2 cdda tray

I have now reverted to test10 with the same setup and all works fine.

Hope that is useful

Mark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
