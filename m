Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDHKc3 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 06:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTDHKc3 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 06:32:29 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:9993 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S261296AbTDHKc0 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 06:32:26 -0400
Date: Tue, 8 Apr 2003 12:43:28 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: cannot mount reiserfs-partition with 2.4.21-pre7 (works fine with 2.5.*)
Message-ID: <20030408104328.GA1264@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem mounting a partition with 2.4.21-pre7. The kernel has
the HPT372N id added to the pci_ids file, otherwise it's vanilla.

The partition is /dev/hdd2, which works fine with 2.5.x (x = 53, 63, 65,
66, 67 I haven't tested earlier kernels).

The stupid thing is that hdc is an identical drive, with identical
partitions and it works fine!

I've included dmesg here below; the error-message at the end also occurs
if I manually type 'mount -t reiserfs /dev/hdd2 /space4'

I'm sure this has worked with earlier kernels; but lately I've been
working with 2.5 most of the time.

If there's anything I can do to help, please let me know.

Kind regards,
Jurriaan

Linux version 2.4.21-pre7 (root@middle) (gcc version 3.2.3 20030331 (Debian prerelease)) #1 Tue Apr 8 08:42:02 CEST 2003
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:0e.1
PCI: Sharing IRQ 10 with 00:10.1
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
PCI: Found IRQ 10 for device 00:0e.1
PCI: Sharing IRQ 10 with 00:0e.0
PCI: Sharing IRQ 10 with 00:10.1
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xd000-0xd007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xd008-0xd00f, BIOS settings: hdk:pio, hdl:pio
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: C/H/S=22075/16/255 from BIOS ignored
hda: IBM-DTLA-307045, ATA DISK drive
hdb: LITE-ON LTR-40125W, ATAPI CD/DVD-ROM drive
blk: queue c0357980, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 4G120J6, ATA DISK drive
hdd: Maxtor 4G120J6, ATA DISK drive
blk: queue c0357dd0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0357f0c, I/O limit 4095Mb (mask 0xffffffff)
hde: WDC WD800JB-00CRA1, ATA DISK drive
blk: queue c0358220, I/O limit 4095Mb (mask 0xffffffff)
hdi: WDC WD800JB-00CRA1, ATA DISK drive
blk: queue c0358ac0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xac00-0xac07,0xb002 on irq 10
ide4 at 0xc000-0xc007,0xc402 on irq 10
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
hdd: attached ide-disk driver.
hdd: host protected area => 1
hdd: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
hdi: attached ide-disk driver.
hdi: host protected area => 1
hdi: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(100)
ide-cd: passing drive hdb to ide-scsi emulation.
hdb: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdc: hdc1 hdc2
 hdd: hdd1 hdd2
 hde: hde1 hde2
 hdi: hdi1 hdi2
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:0a) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 09:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 16:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 16:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 16:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Filesystem on 16:42 cannot be mounted because it is bigger than the device
You may need to run fsck or increase size of your LVM partition
Or may be you forgot to reboot after fdisk when it told you to

-- 
No, no my lord. What I mean is we could get a mad wild killer bull
and disguise it as a bird.
	Baldrik in Blackadder II
Debian (Unstable) GNU/Linux 2.5.66-mm3 3940 bogomips load av: 0.09 0.21 0.34
