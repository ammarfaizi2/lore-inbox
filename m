Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTLXOw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 09:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTLXOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 09:52:27 -0500
Received: from mail.aei.ca ([206.123.6.14]:45283 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263638AbTLXOwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 09:52:23 -0500
Subject: 2.6 unknown partition table
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1072277542.10203.14.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Dec 2003 09:52:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed this in the logs yesterday on 2.6.0-test11-mm1 and upgraded to
2.6.0-mm1, but its still there. I use LVM on that disk and it is working
fine, (LV file systems are mountable and useable).

I recently was experimenting with raid5 on five, 100MB LVs on that disk.
Could that maybe have caused this? Since everything has been working
fine I don't know at which kernel version this appeared although I have
been using 2.6 for over a year.

Advice?

# fdisk -l /dev/hdg

Disk /dev/hdg: 16 heads, 63 sectors, 155114 cylinders
Units = cylinders of 1008 * 512 bytes

Disk /dev/hdg doesn't contain a valid partition table


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20269: IDE controller at PCI slot 0000:00:0d.0
PDC20269: chipset revision 2
PDC20269: Ultra133 TX2 on pci0000:00:0d.0
PDC20269: 100% native mode on irq 16
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
hde: IBM-DJNA-352030, ATA DISK drive
ide2 at 0xb800-0xb807,0xb402 on irq 16
hdg: MAXTOR 6L080J4, ATA DISK drive
ide3 at 0xb000-0xb007,0xa802 on irq 16
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100% native mode on irq 20
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJNA-352030, ATA DISK drive
hdb: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 128KiB
hde: 39876480 sectors (20416 MB) w/1966KiB Cache, CHS=39560/16/63,
UDMA(33)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: max request size: 128KiB
hdg: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63,
UDMA(133)
 hdg: unknown partition table
hda: max request size: 128KiB
hda: 39876480 sectors (20416 MB) w/1966KiB Cache, CHS=39560/16/63
 hda: hda1 hda2 hda3 hda4 < hda5 >
cdrom: : unknown mrw mode page
hdb: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
end_request: I/O error, dev hdb, sector 0
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
end_request: I/O error, dev hdc, sector 0

vgdisplay  --- Physical volumes ---
vgdisplay  PV Name               /dev/hdg     
vgdisplay  PV UUID               3q6w4c-bgGg-KgHR-8Orv-hr0n-qFwV-SeCTOv
vgdisplay  PV Status             allocatable
vgdisplay  Total PE / Free PE    19085 / 1590
vgdisplay   


Regards,

Shane

