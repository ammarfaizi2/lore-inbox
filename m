Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbREBRnH>; Wed, 2 May 2001 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135686AbREBRm6>; Wed, 2 May 2001 13:42:58 -0400
Received: from hertz.ikp.physik.tu-darmstadt.de ([130.83.24.91]:384 "EHLO
	hertz.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S135670AbREBRmt>; Wed, 2 May 2001 13:42:49 -0400
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15088.18199.487902.514295@hertz.ikp.physik.tu-darmstadt.de>
Date: Wed, 2 May 2001 19:42:47 +0200
To: linux-kernel@vger.kernel.org
Subject: Problems even with 512 block size MOs
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

recent 2.4 kernels have incredible bad performance for me when handling MO
drives. Going back 2.2 shows better performance.

This is my setup:
SCSI subsystem driver Revision: 1.00
ncr53c8xx: at PCI bus 0, device 15, function 0
ncr53c8xx: 53c810 detected 
ncr53c810-0: rev 0x2 on pci bus 0 device 15 function 0 irq 16
ncr53c810-0: ID 7, Fast-10, Parity Checking
scsi0 : ncr53c8xx-3.4.3-20010212
  Vendor: FUJITSU   Model: M2513A            Rev: 1500
  Type:   Optical Device                     ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-303   Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
ncr53c810-0-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sda: 248826 512-byte hdwr sectors (127 MB)
sda: Write Protect is off
 sda: unknown partition table

on a non-overclocked Dual celeron BP6 machine with 256MByte RAM

hertz:~> uname -a
Linux hertz 2.4.4-SMP #2 SMP Wed May 2 17:47:22 MEST 2001 i686 unknown
(recent kernel from ftp.suse.com/people/mantel/next) 

Copying a 6.5 MByte file with cp returns nearly immediately on the
commandline, but umount nearly takes forever. Maximum rate detected by
xosview during umount was about 30 kByte.

I have similar behaviour on another machine and with different disk. However
I don't get any "dmesg" output despite the "CONFIG_SCSI_LOGGING=y" option on
both machines.

Are all my MO disks rotten? Are the MO drives broken? Are my SCSI adapters
broken? Or is there a bug in the SCSI layer?

Bye

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
