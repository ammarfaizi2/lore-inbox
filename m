Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVKNQMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVKNQMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 11:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVKNQMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 11:12:16 -0500
Received: from vsmtp1.tin.it ([212.216.176.141]:14073 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S1751176AbVKNQMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 11:12:16 -0500
From: "Mario \"Ldonesty\" Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Intel Sata controller and DVD-RW
Date: Mon, 14 Nov 2005 17:12:12 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511141712.12763.jorge78@inwind.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.
Few days ago I've buy a new Dell Inspiron 6000 notebook and It seems to have 
an embedded Intel Sata Controller.
Here's lpsci output:

************
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express 
Processor to DRAM Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express 
Root Port (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
0000:00:1e.2 Multimedia audio controller: Intel Corporation 
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
AC'97 Modem Controller (rev 03)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface 
Bridge (rev 03)
0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller 
(rev 03)
************

Using 2.6.14 shipped by Debian (Sid with udev), I can bootup system but it 
doesn't recognize dvd-rw and then I can't use it (or I don't know which 
device I've to choose for fstab entry) .

************
libata version 1.12 loaded.
ata_piix version 1.04
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:6003 85:3469 86:9a09 87:6003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: FUJITSU MHV2080A  Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
input: PS/2 Mouse on isa0060/serio1
input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
ata2: dev 0 cfg 49:0f00 82:4218 83:5000 84:4000 85:4218 86:1000 87:4000 
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
************

Looking in /dev directory, I don't see any reference for the dvd-rw, and the 
official .config shipped with debian package shows modular entries for SCSI, 
SATA, and IDE controller. 
Otherwise, using 2.4.27 from Debian Sarge I see:

************
Nov 12 01:50:33 Chiba kernel: Uniform Multi-Platform E-IDE driver Revision: 
7.00beta4-2.4
Nov 12 01:50:33 Chiba kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Nov 12 01:50:33 Chiba kernel: hda: FUJITSU MHV2080AH, ATA DISK drive
Nov 12 01:50:33 Chiba kernel: hdc: TSSTcorp DVD+/-RW TS-L532B, ATAPI 
CD/DVD-ROM drive
Nov 12 01:50:33 Chiba kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 12 01:50:33 Chiba kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 12 01:50:33 Chiba kernel: hda: attached ide-disk driver.
Nov 12 01:50:33 Chiba kernel: hda: 156301488 sectors (80026 MB) w/8192KiB 
Cache, CHS=155061/16/63
Nov 12 01:50:33 Chiba kernel: Partition check:
Nov 12 01:50:33 Chiba kernel:  /dev/ide/host0/bus0/target0/lun0: [PTBL] 
[9729/255/63] p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
Nov 12 01:50:33 Chiba kernel: reiserfs: found format "3.6" with standard 
journal
Nov 12 01:50:33 Chiba kernel: reiserfs: checking transaction log (device ide0
(3,7)) ...
Nov 12 01:50:33 Chiba kernel: for (ide0(3,7))
Nov 12 01:50:33 Chiba kernel: ide0(3,7):Using r5 hash to sort names
************

and it works fine (I used it for the installation), but I can't use alsa and 
other laptop features.

I've also tried to change this behaviour, using ide boot parameters but I 
haven't luck.
Same result when I try to boot a 2.6.15-rc1 with the config taken from 2.6.14 
debian package. 
Now, if I want to use a recent 2.6 kernel, how can I setup the .config file?
Any ideas?
There's no problem to give other informations if they're needed.

Thanks in advance.

-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.

www.debianizzati.org  | Founder Member
Mario "Ldonesty" Di Nitto --- [Linux Registered User #334335]
