Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272140AbTG2VdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTG2VdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:33:19 -0400
Received: from web20507.mail.yahoo.com ([216.136.226.142]:2952 "HELO
	web20507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272140AbTG2VcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:32:22 -0400
Message-ID: <20030729213221.40950.qmail@web20507.mail.yahoo.com>
Date: Tue, 29 Jul 2003 14:32:21 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: linux-2.6.0-test1 failed with SanDisk Compact Flash
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

linux-2.6.0-test1 with SanDisk 64 MB Compact Flash as
root failed with SH arch (7750)

Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes;
override with idebus=xx
hda: SanDisk SDCFB-64, CFA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 7
hda: max request size: 128KiB
hda: task_no_data_intr: status=0x51 { DriveReady
SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError
}
hda: 125440 sectors (64 MB) w/1KiB Cache, CHS=490/8/32
 hda: hda1
 hda: hda1
kobject_register failed for hda1 (-17)

Call trace:
[<8c08cc90>] kobject_register+0x50/0x80
[<8c07afc0>] add_partition+0x0/0xc0
[<8c07b1e6>] register_disk+0x106/0x140
[<8c0a7d32>] add_disk+0x32/0x60
[<8c0ba7c0>] ata_attach+0x0/0x1c0
[<8c0bf472>] idedisk_attach+0x112/0x1e0
[<8c0ba86a>] ata_attach+0xaa/0x1c0
[<8c0bbba4>] ide_register_driver+0xa4/0xe0
[<8c014fe0>] printk+0x0/0x1e0
[<8c014fe0>] printk+0x0/0x1e0
[<8c0020b8>] init+0x18/0x180
[<8c004284>] kernel_thread_helper+0x4/0x20

Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind
32768)
 hda: hda1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k freed

config is :-
:
#define CONFIG_MEMORY_START 0x0c000000
#define CONFIG_MEMORY_SIZE 0x02000000
#define CONFIG_MEMORY_SET 1
#undef CONFIG_MEMORY_OVERRIDE
#define CONFIG_CF_ENABLER 1
#undef CONFIG_CF_AREA5
#define CONFIG_CF_AREA6 1
#define CONFIG_CF_BASE_ADDR 0xb8000000
#define CONFIG_SH_RTC 1

/*
 * Bus options (PCI, PCMCIA, EISA, MCA, ISA)
 */
#define CONFIG_ISA 1
#undef CONFIG_PCI
#define CONFIG_HOTPLUG 1

/*
 * PCMCIA/CardBus support
 */
#define CONFIG_PCMCIA 1
#define CONFIG_I82365 1
#undef CONFIG_TCIC
#define CONFIG_PCMCIA_PROBE 1

/*
 * Block devices
 */
#undef CONFIG_BLK_DEV_FD
#undef CONFIG_BLK_DEV_XD
#undef CONFIG_BLK_DEV_LOOP
#undef CONFIG_BLK_DEV_NBD
#undef CONFIG_BLK_DEV_RAM
#undef CONFIG_BLK_DEV_INITRD

/*
 * ATA/ATAPI/MFM/RLL support
 */
#define CONFIG_IDE 1

/*
 * IDE, ATA and ATAPI Block devices
 */
#define CONFIG_BLK_DEV_IDE 1

/*
 * Please see Documentation/ide.txt for help/info on
IDE drives
 */
#undef CONFIG_BLK_DEV_HD
#define CONFIG_BLK_DEV_IDEDISK 1
#define CONFIG_IDEDISK_MULTI_MODE 1
#undef CONFIG_IDEDISK_STROKE
#undef CONFIG_BLK_DEV_IDECS
#undef CONFIG_BLK_DEV_IDECD
#undef CONFIG_BLK_DEV_IDEFLOPPY
#undef CONFIG_IDE_TASK_IOCTL

/*
 * IDE chipset support/bugfixes
 */
#undef CONFIG_IDE_CHIPSETS

how to fix these error.

Thanks.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
