Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbTCNJ53>; Fri, 14 Mar 2003 04:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbTCNJ53>; Fri, 14 Mar 2003 04:57:29 -0500
Received: from atlas.cc.itu.edu.tr ([160.75.2.22]:24782 "EHLO
	atlas.cc.itu.edu.tr") by vger.kernel.org with ESMTP
	id <S261547AbTCNJ5X>; Fri, 14 Mar 2003 04:57:23 -0500
Message-ID: <3E71A9F1.6080900@itu.edu.tr>
Date: Fri, 14 Mar 2003 12:07:45 +0200
From: "O.Sezer" <oosezer@itu.edu.tr>
Reply-To: oosezer@itu.edu.tr
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: tr,en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre + siimage + framebuffer = no boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another data-point: Upon replacing the SiImage card
with my older HPT366 pci card, the problem does not
occur at all. Any ideas? Alan, Andre?

Regards;
O. Sezer



"O.Sezer" wrote:

Hello to all:

This maybe somewhat long, but please bear with me :))


Kernel-1 : 2.4.19.16mdk patched with the packet-writing patch.
Kernel-2 : 2.4.21-pre5+bk, packet-writing patch, freeswan, lm_sensors
	   OR 2.4.21-pre4q13 from mandrake-cooker.
	   Both are configured without changing the mandrake config
	   but excluding the acpi and swsusp options.

IDE Card = InnoVision EIO UltraATA/133 RAID pci card

With Kernel-1, I can successfully boot and run my system whether
or not I use vga=788. From dmesg:
CMD680: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 4 for device 00:0a.0
CMD680: chipset revision 2
CMD680: not 100% native mode: will probe irqs later
      ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
      ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hdc: SONY CD-ROM CDU5221, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive
hde: ST320014A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd000-0xd007,0xb802 on irq 4
hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
Partition check:
   /dev/ide/host2/bus0/target0/lun0:<6> [PTBL] [2434/255/63] p1 p2 < p5 >
p3 p4


With Kernel-2, if I use vga=normal, then everything seems normal -
I can boot and run my system. From dmesg:
SiI680: IDE controller at PCI slot 00:0a.0
PCI: Found IRQ 4 for device 00:0a.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
      ide2: MMIO-DMA at 0xd0800000-0xd0800007, BIOS settings: hde:pio,
hdf:pio
      ide3: MMIO-DMA at 0xd0800008-0xd080000f, BIOS settings: hdg:pio,
hdh:pio
hdc: SONY CD-ROM CDU5221, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive
hde: ST320014A, ATA DISK drive
blk: queue c031f3e0, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd0800080-0xd0800087,0xd080008a on irq 4
hde: host protected area => 1
hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
Partition check:
   /dev/ide/host2/bus0/target0/lun0:<6> [PTBL] [2434/255/63] p1 p2 < p5 >
p3 p4


Now, with Kernel-2, if I use vga=788, boot fails:
------ Hand copied from screen.
------ Messages when tried to boot with vga=788
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
      ide2: MMIO-DMA at 0xd8801000-0xd8801007 - Error MMIO ports already
in use
      ide3: MMIO-DMA at 0xd8801008-0xd880100f - Error MMIO ports already
in use
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
----- SNIPPED --------
Mounted devfs on /dev
Red Hat nash 3.1.6 starting
Mounting /proc filesystem
Creating root device
Mounting root filesystem
mount: error 6 mounting ext2 flags  Mounted devfs on /dev
Freeing unused kernel memory: 140k freed
Kernel panic: No init found. Try passing init= option to kernel.

In these three cases, there are interesting address differences
which mean nothing to me...

What can I do to overcome this problem? Full dmesg logs, config,
and lspci output are gzipped and attached. I can provide any more
information which maybe necessary.

Kindest regards,
Ozkan Sezer
PS: I am not on the list, please CC me.

