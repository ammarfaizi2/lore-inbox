Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129089AbRBCWKI>; Sat, 3 Feb 2001 17:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130242AbRBCWJ6>; Sat, 3 Feb 2001 17:09:58 -0500
Received: from mail.diligo.fr ([194.153.78.251]:56081 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S129089AbRBCWJr>;
	Sat, 3 Feb 2001 17:09:47 -0500
Date: Sat, 3 Feb 2001 23:05:44 +0100
From: patrick.mourlhon@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: ATAPI CDRW which doesn't work
Message-ID: <20010203230544.A549@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've never could make this CDRW ATAPI to work, if someone could
provide me any clue about the baby. I just said that people on the
kernel mailing list may care of its but. It looks like the baby didn't
even noticed. ;-)

kernel is 2.4.1, but never worked even before this release.
Never maintained speed.

Thanks in advance for any reply,

Patrick Mourlhon


----mount atapi cd writer outpu

Line:/mnt/home/pmo# mount /dev/hdb /cdrom
/dev/hdb: Input/output error
mount: block device /dev/hdb is write-protected, mounting read-only
/dev/hdb: Input/output error

mount: you must specify the filesystem type
Line:/mnt/home/pmo#


----/var/log/messages from start to the end of the previous mount command

Feb  3 22:08:25 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  3 22:08:25 Line kernel: hdb: DMA disabled
Feb  3 22:08:55 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:08:55 Line kernel: hda: DMA disabled
Feb  3 22:08:55 Line kernel: ide0: reset: success
Feb  3 22:09:06 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:09:36 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:09:36 Line kernel: ide0: reset: success
Feb  3 22:09:47 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:09:47 Line kernel: end_request: I/O error, dev 03:40 (hdb), sector 2
Feb  3 22:09:48 Line kernel: hdb: status timeout: status=0x90 { Busy }
Feb  3 22:09:48 Line kernel: hdb: drive not ready for command
Feb  3 22:10:11 Line kernel: hdb: ATAPI reset complete
Feb  3 22:10:21 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  3 22:10:51 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:10:51 Line kernel: ide0: reset: success
Feb  3 22:11:02 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:11:32 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:11:32 Line kernel: ide0: reset: success
Feb  3 22:11:42 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:11:42 Line kernel: end_request: I/O error, dev 03:40 (hdb), sector 2
Feb  3 22:11:43 Line kernel: hdb: status timeout: status=0x90 { Busy }
Feb  3 22:11:43 Line kernel: hdb: drive not ready for command
Feb  3 22:12:06 Line kernel: hdb: ATAPI reset complete
Feb  3 22:12:16 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  3 22:12:46 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:12:46 Line kernel: ide0: reset: success
Feb  3 22:12:57 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:13:27 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:13:27 Line kernel: ide0: reset: success
Feb  3 22:13:37 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:13:37 Line kernel: end_request: I/O error, dev 03:40 (hdb), sector 0
Feb  3 22:13:37 Line kernel: FAT bread failed
Feb  3 22:13:38 Line kernel: hdb: status timeout: status=0x90 { Busy }
Feb  3 22:13:38 Line kernel: hdb: drive not ready for command
Feb  3 22:14:02 Line kernel: hdb: ATAPI reset complete
Feb  3 22:14:12 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  3 22:14:42 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:14:42 Line kernel: ide0: reset: success
Feb  3 22:14:53 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:15:23 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:15:23 Line kernel: ide0: reset: success
Feb  3 22:15:33 Line kernel: hdb: irq timeout: status=0x90 { Busy }
Feb  3 22:15:33 Line kernel: end_request: I/O error, dev 03:40 (hdb), sector 0
Feb  3 22:15:33 Line kernel: FAT bread failed
Feb  3 22:15:35 Line kernel: hdb: status timeout: status=0x90 { Busy }
Feb  3 22:15:35 Line kernel: hdb: drive not ready for command
Feb  3 22:16:09 Line kernel: hdb: ATAPI reset timed-out, status=0x90
Feb  3 22:16:09 Line kernel: ide0: reset: success
Feb  3 22:16:12 Line kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
Feb  3 22:16:12 Line kernel: hdb: packet command error: error=0xb0
Feb  3 22:16:13 Line kernel: ATAPI device hdb:
Feb  3 22:16:13 Line kernel:   Error: Aborted command -- (Sense key=0x0b)
Feb  3 22:16:13 Line kernel:   (reserved error code) -- (asc=0x00, ascq=0x00)
Feb  3 22:16:13 Line kernel:   The failed "Prevent/Allow Medium Removal" packet command was:
Feb  3 22:16:13 Line kernel:   "1e 00 00 00 00 00 00 00 00 00 00 00 "


----cat /proc/interrupts

           CPU0
  0:     147746          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  serial
 10:          0          XT-PIC  usb-uhci
 12:       3622          XT-PIC  PCnet/PCI II 79C970A
 14:      11727          XT-PIC  ide0
 15:        127          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0


----cat /proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc Rage XL AGP
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : VIA Technologies, Inc. UHCI USB
  e400-e41f : usb-uhci
e800-e8ff : Tseng Labs Inc ET6000
ec00-ec1f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
  ec00-ec1f : PCnet/PCI II 79C970A


----/proc/ide/ide0/hdb

Line:/proc/ide/ide0/hdb# cat media
cdrom

Line:/proc/ide/ide0/hdb# cat model
R/RW 4x4x24

Line:/proc/ide/ide0/hdb# cat driver
ide-cdrom version 4.59

Line:/proc/ide/ide0/hdb# cat settings
name        value    min      max      mode
----        -----    ---      ---      ----
breada_readahead        4               0               127             rw
current_speed           34              0               69              rw
dsc_overlap             1               0               1               rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              12              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      128             1               127             rw
nice1                   1               0               1               rw
number                  1               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw

Line:/proc/ide/ide0/hdb# cat identify
85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 3456 4f30 3934 3544 4530 3530
3232 2020 0000 0000 0000 1000 0000 2031
2e30 3400 0000 522f 5257 2034 7834 7832
3420 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0b00 0000 0200 0200 0002 0000 0000
0000 0000 0000 0000 0000 0000 0007 0407
0003 0078 0078 0078 0078 0000 0000 0000
0000 0004 0009 0000 0000 0000 0000 0000
...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
