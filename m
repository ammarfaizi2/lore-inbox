Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292429AbSCIIPD>; Sat, 9 Mar 2002 03:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCIIOx>; Sat, 9 Mar 2002 03:14:53 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:656 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S292429AbSCIIOe>; Sat, 9 Mar 2002 03:14:34 -0500
Message-ID: <3C89C3D4.3070004@wanadoo.fr>
Date: Sat, 09 Mar 2002 09:12:04 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.6-pre3 boot hangs in ide probing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The motherboard is abit BE6 (4 ide, piix and hpt366) with a pIII coppermine.
For reference below is dmesg with a booting 2.5.6-pre2.

booting 2.5.6-pre3 hangs at :

........
Partition check:
  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
  /dev/ide/host3/bus0/target0/lun0:
........

with hdg=noprobe, and even after un-plugging hdg, 2.5.6-pre3 hangs at :

........
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
ide3 at 0xd800-0xd807,0xdc02 on irq 11
blk: queue c0255658, I/O limit 4095Mb (mask 0xffffffff)
........

(2.5.6-pre2)# dmesg
........
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
PCI device 8086:7111: IDE controller on PCI slot 00:07.1
PCI device 8086:7111: chipset revision 1
PCI device 8086:7111: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
PCI device 1103:0004: onboard version of chipset, pin1=1 pin2=2
PCI device 1103:0004: IDE controller on PCI slot 00:13.0
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:13.1
PCI device 1103:0004: chipset revision 1
PCI device 1103:0004: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
PCI device 1103:0004: IDE controller on PCI slot 00:13.1
PCI: Found IRQ 11 for device 00:13.1
PCI: Sharing IRQ 11 with 00:13.0
PCI device 1103:0004: chipset revision 1
PCI device 1103:0004: not 100% native mode: will probe irqs later
     ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:pio, hdh:pio
hdc: SAMSUNG DVD-ROM SD-616F, ATAPI CD/DVD-ROM drive
hde: ST310212A, ATA DISK drive
hdg: SAMSUNG SV0322A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
ide3 at 0xd800-0xd807,0xdc02 on irq 11
blk: queue c0255658, I/O limit 4095Mb (mask 0xffffffff)
hde: 20005650 sectors (10243 MB) w/512KiB Cache, CHS=19846/16/63, UDMA(66)
blk: queue c0255c50, I/O limit 4095Mb (mask 0xffffffff)
hdg: 6250608 sectors (3200 MB) w/478KiB Cache, CHS=11024/9/63, UDMA(33)
Partition check:
  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
  /dev/ide/host3/bus0/target0/lun0: p1
.......

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

