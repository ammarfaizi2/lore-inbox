Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTLGRtz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTLGRtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:49:55 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:1744 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264466AbTLGRto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:49:44 -0500
Message-ID: <3FD367F1.2060501@inp-net.eu.org>
Date: Sun, 07 Dec 2003 18:48:33 +0100
From: =?ISO-8859-1?Q?Rapha=EBl_Rigo?= <raphael.rigo@inp-net.eu.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS?] 2.6-test11 : problem about irq18.
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090601000504080205000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601000504080205000509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,
I have a hard time making the 2.6-test11 to work correctly.
I constantly get messages about irq 18.
The kernel boots, linux works, but I get such messages every second :

Dec  7 18:28:24 pici kernel: irq 18: nobody cared!
Dec  7 18:28:24 pici kernel: Call Trace:
Dec  7 18:28:24 pici kernel:  [<c010b08b>] __report_bad_irq+0x2b/0x90
Dec  7 18:28:24 pici kernel:  [<c010b093>] __report_bad_irq+0x33/0x90
Dec  7 18:28:24 pici kernel:  [<c010b168>] note_interrupt+0x50/0x78
Dec  7 18:28:24 pici kernel:  [<c010b3f7>] do_IRQ+0xf7/0x180
Dec  7 18:28:24 pici kernel:  [<c0105000>] _stext+0x0/0x60
Dec  7 18:28:24 pici kernel:  [<c0109aec>] common_interrupt+0x18/0x20
Dec  7 18:28:24 pici kernel:  [<c0105000>] _stext+0x0/0x60
Dec  7 18:28:24 pici kernel:  [<c0107010>] default_idle+0x2c/0x34
Dec  7 18:28:24 pici kernel:  [<c01070a6>] cpu_idle+0x3a/0x48
Dec  7 18:28:24 pici kernel:  [<c0105057>] _stext+0x57/0x60
Dec  7 18:28:24 pici kernel:  [<c03aa7f3>] start_kernel+0x16b/0x174
Dec  7 18:28:24 pici kernel:
Dec  7 18:28:24 pici kernel: handlers:
Dec  7 18:28:24 pici kernel: [<c0221364>] (ide_intr+0x0/0x1b4)
Dec  7 18:28:24 pici kernel: [<c0221364>] (ide_intr+0x0/0x1b4)
Dec  7 18:28:24 pici kernel: Disabling IRQ #18

I also had this :
Dec  7 18:27:45 pici kernel: hdg: dma_timer_expiry: dma status == 0x24
Dec  7 18:27:45 pici kernel: hdg: DMA interrupt recovery
Dec  7 18:27:45 pici kernel: hdg: lost interrupt
Dec  7 18:27:45 pici kernel: irq 18: nobody cared!
Dec  7 18:27:45 pici kernel: Call Trace:
Dec  7 18:27:45 pici kernel:  [<c010b08b>] __report_bad_irq+0x2b/0x90
Dec  7 18:27:45 pici kernel:  [<c010b093>] __report_bad_irq+0x33/0x90
Dec  7 18:27:45 pici kernel:  [<c010b168>] note_interrupt+0x50/0x78
Dec  7 18:27:45 pici kernel:  [<c010b3f7>] do_IRQ+0xf7/0x180
Dec  7 18:27:45 pici kernel:  [<c0109aec>] common_interrupt+0x18/0x20
Dec  7 18:27:45 pici kernel:  [<c01222b1>] do_softirq+0x61/0xd0
Dec  7 18:27:45 pici kernel:  [<c010b466>] do_IRQ+0x166/0x180
Dec  7 18:27:45 pici kernel:  [<c0109aec>] common_interrupt+0x18/0x20
Dec  7 18:27:45 pici kernel:  [<c022007b>] ide_complete_pm_request+0x9b/0xe0
Dec  7 18:27:45 pici kernel:  [<c021048f>] generic_unplug_device+0x73/0x8c
Dec  7 18:27:45 pici kernel:  [<c0210619>] blk_run_queues+0x9d/0xe4
Dec  7 18:27:45 pici kernel:  [<c01520ba>] __wait_on_buffer+0x92/0xb4
Dec  7 18:27:45 pici kernel:  [<c011c680>] autoremove_wake_function+0x0/0x3c
Dec  7 18:27:45 pici kernel:  [<c011c680>] autoremove_wake_function+0x0/0x3c
Dec  7 18:27:45 pici kernel:  [<c01540ef>] __block_prepare_write+0x2a3/0x398
Dec  7 18:27:45 pici kernel:  [<c0154904>] block_prepare_write+0x20/0x3c
Dec  7 18:27:45 pici kernel:  [<c019d2b8>] ext2_get_block+0x0/0x3b4
Dec  7 18:27:45 pici kernel:  [<c019d6d9>] ext2_prepare_write+0x19/0x20
Dec  7 18:27:45 pici kernel:  [<c019d2b8>] ext2_get_block+0x0/0x3b4
Dec  7 18:27:45 pici kernel:  [<c013800e>] generic_file_aio_write_nolock+0x6ba/0xa9c
Dec  7 18:27:45 pici kernel:  [<c0143b8b>] do_anonymous_page+0x22f/0x23c
Dec  7 18:27:45 pici kernel:  [<c013845f>] generic_file_write_nolock+0x6f/0x8c
Dec  7 18:27:45 pici kernel:  [<c0117cf5>] do_page_fault+0x15d/0x4aa
Dec  7 18:27:45 pici kernel:  [<c0117b98>] do_page_fault+0x0/0x4aa
Dec  7 18:27:45 pici kernel:  [<c013856f>] generic_file_write+0x57/0x70
Dec  7 18:27:45 pici kernel:  [<c0150fee>] vfs_write+0x9e/0xd0
Dec  7 18:27:45 pici kernel:  [<c01510a0>] sys_write+0x30/0x50
Dec  7 18:27:45 pici kernel:  [<c010917f>] syscall_call+0x7/0xb
Dec  7 18:27:45 pici kernel:
Dec  7 18:27:45 pici kernel: handlers:
Dec  7 18:27:45 pici kernel: [<c0221364>] (ide_intr+0x0/0x1b4)
Dec  7 18:27:45 pici kernel: [<c0221364>] (ide_intr+0x0/0x1b4)
Dec  7 18:27:45 pici kernel: Disabling IRQ #18

I am using a P4 2.6 Ghz without HT activated
512 MB DDR PC3200 on an ASUS P4P800 Deluxe MB.
HardDrive is on SATA (native mode) : Maxtor 6Y120MO.

2.4.23 doesn't have this problem but keeps using 30-50% CPU even if I do nothing.
Attached is attached grep "=[y|m]" .config

Regards,
Raphaël RIGO

--------------090601000504080205000509
Content-Type: text/plain;
 name=".configok"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".configok"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_SK98LIN=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_I830=y
CONFIG_VIDEO_DEV=m
CONFIG_FB=y
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_INTEL8X0=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--------------090601000504080205000509--
