Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUGAOOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUGAOOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUGAOOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:14:37 -0400
Received: from dialpool1-252.dial.tijd.com ([62.112.10.252]:61061 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S265265AbUGAOOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:14:31 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.7] SCSI trouble with Adaptec 29160N
Date: Thu, 1 Jul 2004 16:14:38 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407011614.47326.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello list,

Running kernel 2.6.7.

I found this in the logs today after not being able to access my /mnt/dump disk, which is normally mounted to /dev/sdb1
I'm wondering if this is a hardware problem, and if so, is it the disc or the controller? Google wasn't particulary helpful.

Jun 26 06:27:17 hellgate kernel: scsi0:0:1:0: Attempting to queue an ABORT message
Jun 26 06:27:17 hellgate kernel: CDB: 0x28 0x0 0x0 0x0 0x10 0x57 0x0 0x0 0x8 0x0
Jun 26 06:27:17 hellgate kernel: scsi0: At time of recovery, card was not paused
Jun 26 06:27:17 hellgate kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Jun 26 06:27:17 hellgate kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x9
Jun 26 06:27:17 hellgate kernel: Card was paused
Jun 26 06:27:17 hellgate kernel: ACCUM = 0x0, SINDEX = 0x30, DINDEX = 0xe4, ARG_2 = 0x0
Jun 26 06:27:17 hellgate kernel: HCNT = 0x0 SCBPTR = 0x2
Jun 26 06:27:17 hellgate kernel: SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0]
Jun 26 06:27:17 hellgate kernel: LASTPHASE[0x1] SCSISEQ[0x12] SBLKCTL[0x6] SCSIRATE[0x0]
Jun 26 06:27:17 hellgate kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] SSTAT1[0x8]
Jun 26 06:27:17 hellgate kernel: SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] SIMODE1[0xa4]
Jun 26 06:27:17 hellgate kernel: SXFRCTL0[0x80] DFCNTRL[0x0] DFSTATUS[0x89]
Jun 26 06:27:45 hellgate kernel: STACK: 0x0 0x163 0x109 0x3
Jun 26 06:27:45 hellgate kernel: SCB count = 116
Jun 26 06:27:45 hellgate kernel: Kernel NEXTQSCB = 57
Jun 26 06:27:45 hellgate kernel: Card NEXTQSCB = 57
Jun 26 06:27:45 hellgate kernel: QINFIFO entries:
Jun 26 06:27:45 hellgate kernel: Waiting Queue entries:
Jun 26 06:27:45 hellgate kernel: Disconnected Queue entries: 9:20
Jun 26 06:27:45 hellgate kernel: QOUTFIFO entries:
Jun 26 06:27:45 hellgate kernel: Sequencer Free SCB List: 2 17 19 24 15 16 18 25 10 7 12 3 11 29 26 13 23 4 21 28 0 22 31 27 30 8 6 5 20 14 1
Jun 26 06:27:45 hellgate kernel: Sequencer SCB Info:
Jun 26 06:27:45 hellgate kernel:   0 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   1 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   5 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   8 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:   9 SCB_CONTROL[0x64] SCB_SCSIID[0x17] SCB_LUN[0x0] SCB_TAG[0x14]
Jun 26 06:27:45 hellgate kernel:  10 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  11 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  12 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  13 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  14 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  15 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  16 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  17 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  18 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  19 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  20 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  21 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  22 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  23 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  24 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  25 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  26 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  27 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  28 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  29 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  30 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel:  31 SCB_CONTROL[0xe0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]
Jun 26 06:27:45 hellgate kernel: Pending list:
Jun 26 06:27:45 hellgate kernel:  20 SCB_CONTROL[0x60] SCB_SCSIID[0x17] SCB_LUN[0x0]
Jun 26 06:27:45 hellgate kernel: Kernel Free SCB list: 48 34 18 37 17 10 29 4 35 32 51 38 11 28 24 58 27 43 42 39 54 22 21 13 7 67 62 50 2 30 46 55 0 6 3 15 41 6
1 115 59 25 8 63 31 56 33 44 53 36 49 47 12 52 23 14 45 5 16 1 19 40 60 9 26 108 109 110 111 104 105 106 107 100 101 102 103 96 97 98 99 92 93 94 95 88 89 90 91
84 85 86 87 80 81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66 114 113 112
Jun 26 06:27:45 hellgate kernel: DevQ(0:0:0): 0 waiting
Jun 26 06:27:45 hellgate kernel: DevQ(0:1:0): 0 waiting
Jun 26 06:27:45 hellgate kernel:
Jun 26 06:27:45 hellgate kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Jun 26 06:27:45 hellgate kernel: (scsi0:A:1:0): Device is disconnected, re-queuing SCB
Jun 26 06:27:45 hellgate kernel: Recovery code sleeping
Jun 26 06:27:45 hellgate kernel: Recovery SCB completes
Jun 26 06:27:45 hellgate kernel: Recovery code awake
Jun 26 06:27:45 hellgate kernel: aic7xxx_abort returns 0x2002
Jun 26 06:27:45 hellgate kernel: scsi0:0:1:0: Attempting to queue a TARGET RESET message
Jun 26 06:27:45 hellgate kernel: CDB: 0x28 0x0 0x0 0x0 0x10 0x57 0x0 0x0 0x8 0x0
Jun 26 06:27:45 hellgate kernel: scsi0:0:1:0: Is not an active device
Jun 26 06:27:45 hellgate kernel: aic7xxx_dev_reset returns 0x2002
Jun 26 06:27:45 hellgate kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
Jun 26 06:27:45 hellgate kernel: SCSI error : <0 0 1 0> return code = 0x8000002
Jun 26 06:27:45 hellgate kernel: Info fld=0x0, Current sdb: sense key Aborted Command
Jun 26 06:27:45 hellgate kernel: end_request: I/O error, dev sdb, sector 4183
Jun 26 06:27:45 hellgate kernel: EXT3-fs error (device sdb1): ext3_find_entry: reading directory #2 offset 0
Jun 26 06:27:45 hellgate kernel:   
Jun 26 06:27:45 hellgate kernel: Remounting filesystem read-only
Jun 26 06:27:45 hellgate kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 26 06:27:45 hellgate kernel: Buffer I/O error on device sdb1, logical block 0
Jun 26 06:27:45 hellgate kernel: lost page write due to I/O error on sdb1
Jun 26 06:27:45 hellgate kernel: (scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)

Some dmesg stuff:
- -----------------
ahc_pci:0:10:0: Host Adapter Bios disabled.  Using default SCSI device parameters
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Using anticipatory io scheduler
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
  Vendor: HP        Model: 9.10GB A 80-B005  Rev: B005
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: HP        Model: 9.10GB A 80-B005  Rev: B005
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi1:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: HP        Model: C1537A            Rev: L708
  Type:   Sequential-Access                  ANSI SCSI revision: 02
SCSI device sda: 17773524 512-byte hdwr sectors (9100 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 17773524 512-byte hdwr sectors (9100 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0

lspci:
- ------
0000:01:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 18
        BIST result: 00
        I/O ports at e800 [disabled]
        Memory at feafe000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

- -- 
I wish you were a Scotch on the rocks.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5BxUUQQOfidJUwQRAgtMAJ9n4Ucb8zxFxD+JcHtJJywW6trM6QCdEzZ5
08ECcxj0smxmNDP+tZ/Ht8c=
=iorR
-----END PGP SIGNATURE-----
