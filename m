Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFCXtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFCXtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFCXtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:49:14 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:425 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261168AbVFCXtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:49:03 -0400
Message-ID: <42A0EC6E.7060108@candelatech.com>
Date: Fri, 03 Jun 2005 16:49:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: DMA timeouts & errors when using Sandisk CF for root.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a small VIA based system with a 512MB CF disk for
the 'hard drive'.  It seems to work OK, but I am getting some
DMA timeouts and errors upon boot.

kernel is 2.6.11.  I saw the same problem with FC2's 2.6.5 default kernel.

 From dmesg:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: SanDisk SDCFB-512, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 1000944 sectors (512 MB) w/1KiB Cache, CHS=993/16/63, DMA
hda: cache flushes not supported
  hda:<4>hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
  hda1
ide-floppy driver 0.99.newide

...........

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

ide: failed opcode was: unknown
hda: drive not ready for command
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 208k freed
USB Universal Host Controller Interface driver v2.2


lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a)


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

