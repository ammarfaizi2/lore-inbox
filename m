Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTI3A0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTI3A0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:26:41 -0400
Received: from quechua.inka.de ([193.197.184.2]:12229 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263055AbTI3A0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:26:33 -0400
Subject: ide problem in newer kernel or disc failure
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064881613.811.8.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 30 Sep 2003 02:26:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

my disc starts showing problems. a few weeks ago it was fine.
could that be a problem with latest 2.6.0-test* kernels
or is my disc failing? 

(dos software dft from hitachi and the dell analyse
tools do not show any problems.)

Thanks for any hint what this could be.
If full log files (kernel, dmesg, config, ...) are helpful
I will post them, mail them or put them online on request.

Regards, Andreas

io related kernel log:
Linux version 2.6.0-test6 (root@simulacron) (gcc version 3.3.2 20030908
(Debian prerelease)) #2 Sun Sep 28 16:50:32 CEST 2003

ide_setup: hda=2432,255,63

Using deadline io scheduler

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=2432/255/63,
UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=5745418,
sector=5745418
end_request: I/O error, dev hda, sector 5745418
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success
spurious 8259A interrupt: IRQ7.
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success

disc related config options:
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

smartctl log:
Device: IC25N020ATDA04-0  Supports ATA Version 5
Drive supports S.M.A.R.T. and is enabled
Check S.M.A.R.T. Passed

General Smart Values: 
Off-line data collection status: (0x00)	Offline data collection activity
was
					never started

Self-test execution status:      (   0)	The previous self-test routine
completed
					without error or no self-test has ever 
					been run

Total time to complete off-line 
data collection: 		 ( 645) Seconds

Offline data collection 
Capabilities: 			 (0x1b) SMART EXECUTE OFF-LINE IMMEDIATE
					Automatic timer ON/OFF support
					Suspend Offline Collection upon new
					command
					Offline surface scan supported
					Self-test supported

Smart Capablilities:           (0x0003)	Saves SMART data before entering
					power-saving mode
					Supports SMART auto save timer

Error logging capability:        (0x01)	Error logging supported

Short self-test routine 
recommended polling time: 	 (   2) Minutes

Extended self-test routine 
recommended polling time: 	 (  27) Minutes

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 16
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x000b   085   085   062       000000e60000
(  2)Throughput Performance  0x0005   100   100   040       000000000000
(  3)Spin Up Time            0x0007   129   129   033       000f00000001
(  4)Start Stop Count        0x0012   100   100   000       0000000004a5
(  5)Reallocated Sector Ct   0x0033   100   100   005       000000000000
(  7)Seek Error Rate         0x000b   100   100   067       000000000000
(  8)Seek Time Preformance   0x0005   100   100   040       000000000000
(  9)Power On Hours          0x0012   073   073   000       000000002e55
( 10)Spin Retry Count        0x0013   100   100   060       000000000000
( 12)Power Cycle Count       0x0032   100   100   000       00000000043a
(191)Unknown Attribute       0x000a   096   096   000       000000050003
(192)Unknown Attribute       0x0032   099   099   000       000000000155
(193)Unknown Attribute       0x0012   083   083   000       00000002a398
(194)Unknown Attribute       0x0002   127   127   000       0044000d002b
(196)Reallocated Event Count 0x0032   100   100   000       00000000014b
(197)Current Pending Sector  0x0022   100   100   000       000000000002
(198)Offline Uncorrectable   0x0008   100   100   000       000000000000
(199)UDMA CRC Error Count    0x000a   200   200   000       000000000000
SMART Error Log:
SMART Error Logging Version: 1
Error Log Data Structure Pointer: 03
ATA Error Count: 8
Non-Fatal Count: 0

Error Log Structure 1:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 02   a2   01   58   e0   fe    ef   fe     1920
 02   a2   01   59   e0   fe    ef   fe     1920
 02   a2   01   5a   e0   fe    ef   fe     1920
 02   a2   01   5b   e0   fe    ef   fe     1920
 02   a2   01   5c   e0   fe    ef   fe     1921
 00   01   01   5c   e0   fe    af   51     0
Error condition:   0	Error State:       3
Number of Hours in Drive Life: 11855 (life of the drive in hours)

Error Log Structure 2:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 02   a2   01   58   e0   fe    ef   fe     3654
 02   a2   01   59   e0   fe    ef   fe     3654
 02   a2   01   5a   e0   fe    ef   fe     3654
 02   a2   01   5b   e0   fe    ef   fe     3654
 02   a2   01   5c   e0   fe    ef   fe     3654
 00   01   01   5c   e0   fe    af   51     0
Error condition:   0	Error State:       3
Number of Hours in Drive Life: 11855 (life of the drive in hours)

Error Log Structure 3:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   00   30   e2   e0   53    e0   c8     24255
 00   00   08   42   d4   51    e0   c8     24255
 00   00   40   d2   e1   53    e0   c8     24255
 00   00   48   6a   e1   53    e0   c8     24255
 00   00   08   da   d4   65    e0   c8     24256
 00   40   08   da   d4   65    e0   51     0
Error condition:   0	Error State:       3
Number of Hours in Drive Life: 11861 (life of the drive in hours)

Error Log Structure 4:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 02   a2   01   58   e0   fe    ef   fe     1516
 02   a2   01   59   e0   fe    ef   fe     1516
 02   a2   01   5a   e0   fe    ef   fe     1516
 02   a2   01   5b   e0   fe    ef   fe     1516
 02   a2   01   5c   e0   fe    ef   fe     1516
 00   01   01   5c   e0   fe    af   51     0
Error condition:   0	Error State:       3
Number of Hours in Drive Life: 11855 (life of the drive in hours)

Error Log Structure 5:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 02   a2   01   58   e0   fe    ef   fe     1615
 02   a2   01   59   e0   fe    ef   fe     1615
 02   a2   01   5a   e0   fe    ef   fe     1615
 02   a2   01   5b   e0   fe    ef   fe     1615
 02   a2   01   5c   e0   fe    ef   fe     1615
 00   01   01   5c   e0   fe    af   51     0
Error condition:   0	Error State:       3
Number of Hours in Drive Life: 11855 (life of the drive in hours)


