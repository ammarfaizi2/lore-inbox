Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSHaJjG>; Sat, 31 Aug 2002 05:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSHaJjF>; Sat, 31 Aug 2002 05:39:05 -0400
Received: from mz01.hal9001.net ([80.16.61.154]:5262 "EHLO server.hal9001.net")
	by vger.kernel.org with ESMTP id <S316957AbSHaJjE>;
	Sat, 31 Aug 2002 05:39:04 -0400
Message-ID: <3D708F3D.258D0E2E@hal9001.net>
Date: Sat, 31 Aug 2002 11:41:17 +0200
From: Stefano Biella <sbiella@hal9001.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com, Dan Egli <dan@shortcircuit.dyndns.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel panic: no init found with 2.5.32
References: <Pine.LNX.3.95.1020830161536.13754A-100000@chaos.analogic.com> <3D6FDFE6.4936FB3C@hal9001.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to compile with a minimal 2.5.32 kernel:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_INPUT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_REISERFS_FS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

This is my last row on the screen before the kernel panic:

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 11
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10c0-0x10x7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x10c8-0x10cf, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK239A-65, ATA DISK drive
hdc: SANYO CRD-S372BVA, ATAPI CD/RVR-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c020544, I/O limit 4095Mb (mask 0xffffffff)
hda: host protected area => 1
hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=789/255/63, UDMA(33)
hdc: ATAPI 24X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
 hda: hda1 hda2
found reiserfs format "3.6" with standard journal
Reiserfs hournal params: device ide0(3,2), size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
reiserfs: checking transaction log (ide0(3,2)) for (ide0(3,2))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 208K freed
Kernel panic: No init found.  Try passing init= option to kernel.

