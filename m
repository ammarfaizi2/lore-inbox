Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUAHPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUAHPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:07:27 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:62214 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S265100AbUAHPGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:06:48 -0500
Date: Thu, 8 Jan 2004 16:06:08 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1-mm2: mozilla-firebird gives kernel warnings and oops
Message-ID: <20040108150608.GA1459@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is not quite right in 2.6.1-rc2-mm1, I can't start
mozilla-firebird anymore without some pretty interesting messages.
Mozilla throws a segfault, BTW.

Jan  8 15:45:01 middle kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Jan  8 15:45:02 middle kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Jan  8 15:45:02 middle kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Jan  8 15:45:36 middle kernel:  printing eip:
Jan  8 15:45:36 middle kernel: c0139dab
Jan  8 15:45:36 middle kernel: Oops: 0000 [#1]
Jan  8 15:45:36 middle kernel: PREEMPT 
Jan  8 15:45:36 middle kernel: CPU:    0
Jan  8 15:45:36 middle kernel: EIP:    0060:[<c0139dab>]    Not tainted VLI
Jan  8 15:45:36 middle kernel: EFLAGS: 00010202
Jan  8 15:45:36 middle kernel: EIP is at filemap_populate_nonblock+0x1bb/0x2b0
Jan  8 15:45:36 middle kernel: eax: 20020028   ebx: 00000003   ecx: fffd0000   edx: c11e9830
Jan  8 15:45:36 middle kernel: esi: d89fde5c   edi: 00000223   ebp: d89fde88   esp: d89fde2c
Jan  8 15:45:36 middle kernel: ds: 007b   es: 007b   ss: 0068
Jan  8 15:45:36 middle kernel: Process MozillaFirebird (pid: 3838, threadinfo=d89fc000 task=e3043300)
Jan  8 15:45:36 middle kernel: Stack: ccad44f0 d89fde5c 00000223 00000004 00000004 d89fc000 fffd0000 fffcfff4 
Jan  8 15:45:36 middle kernel:        f5c547c0 d89fde5c f7ae6700 ccad44ec c11e9830 c11e9808 c11e97e0 c11e4998 
Jan  8 15:45:36 middle kernel:        00000025 00007000 403fd000 f5bbb300 f5bbb300 403fcf38 c11daa60 d89fded4 
Jan  8 15:45:36 middle kernel: Call Trace:
Jan  8 15:45:36 middle kernel:  [<c0147e38>] do_no_page+0x3f8/0x410
Jan  8 15:45:36 middle kernel:  [<c014806a>] handle_mm_fault+0xda/0x180
Jan  8 15:45:36 middle kernel:  [<c011b3e5>] do_page_fault+0x315/0x51f
Jan  8 15:45:36 middle kernel:  [<c01287ad>] update_wall_time+0xd/0x40
Jan  8 15:45:36 middle kernel:  [<c0128c1d>] do_timer+0xdd/0xf0
Jan  8 15:45:36 middle kernel:  [<c010cc19>] do_IRQ+0x109/0x140
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c046a6c3>] error_code+0x2f/0x38
Jan  8 15:45:36 middle kernel: 
Jan  8 15:45:36 middle kernel: Code: 5c 28 01 00 31 c9 83 c4 50 89 c8 5b 5e 5f c9 c3 e8 0b 36 fe ff eb db e8 04 36 fe ff eb ca 8b 02 a8 08 0f 84 7a ff ff ff 8b 4d bc <8b> 01 85 c0 0f 85 6d ff ff ff 8b 45 c4 85 c0 74 49 ff 42 04 8b 
Jan  8 15:45:36 middle kernel: Badness in unblank_screen at drivers/char/vt.c:2793
Jan  8 15:45:36 middle kernel: Call Trace:
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c02da72b>] unblank_screen+0x12b/0x130
Jan  8 15:45:36 middle kernel:  [<c011ae2a>] bust_spinlocks+0x2a/0x60
Jan  8 15:45:36 middle kernel:  [<c010b6e5>] die+0x95/0x100
Jan  8 15:45:36 middle kernel:  [<c011b2c5>] do_page_fault+0x1f5/0x51f
Jan  8 15:45:36 middle kernel:  [<c0191907>] ext3_mark_iloc_dirty+0x27/0x40
Jan  8 15:45:36 middle kernel:  [<c0195c84>] __ext3_journal_stop+0x24/0x50
Jan  8 15:45:36 middle kernel:  [<c0191aa8>] ext3_dirty_inode+0x68/0x90
Jan  8 15:45:36 middle kernel:  [<c0174f2b>] __mark_inode_dirty+0xeb/0xf0
Jan  8 15:45:36 middle kernel:  [<c016f314>] update_atime+0x84/0xd0
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c046a6c3>] error_code+0x2f/0x38
Jan  8 15:45:36 middle kernel:  [<c0139dab>] filemap_populate_nonblock+0x1bb/0x2b0
Jan  8 15:45:36 middle kernel:  [<c0147e38>] do_no_page+0x3f8/0x410
Jan  8 15:45:36 middle kernel:  [<c014806a>] handle_mm_fault+0xda/0x180
Jan  8 15:45:36 middle kernel:  [<c011b3e5>] do_page_fault+0x315/0x51f
Jan  8 15:45:36 middle kernel:  [<c01287ad>] update_wall_time+0xd/0x40
Jan  8 15:45:36 middle kernel:  [<c0128c1d>] do_timer+0xdd/0xf0
Jan  8 15:45:36 middle kernel:  [<c010cc19>] do_IRQ+0x109/0x140
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c046a6c3>] error_code+0x2f/0x38
Jan  8 15:45:36 middle kernel: 
Jan  8 15:45:36 middle kernel:  <6>note: MozillaFirebird[3838] exited with preempt_count 3
Jan  8 15:45:36 middle kernel: Call Trace:
Jan  8 15:45:36 middle kernel:  [<c011d394>] schedule+0x5a4/0x5b0
Jan  8 15:45:36 middle kernel:  [<c01463b1>] unmap_page_range+0x41/0x70
Jan  8 15:45:36 middle kernel:  [<c014659e>] unmap_vmas+0x1be/0x220
Jan  8 15:45:36 middle kernel:  [<c014a4c9>] exit_mmap+0x79/0x190
Jan  8 15:45:36 middle kernel:  [<c011ee8a>] mmput+0x7a/0xe0
Jan  8 15:45:36 middle kernel:  [<c0122e98>] do_exit+0x148/0x400
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c010b749>] die+0xf9/0x100
Jan  8 15:45:36 middle kernel:  [<c011b2c5>] do_page_fault+0x1f5/0x51f
Jan  8 15:45:36 middle kernel:  [<c0191907>] ext3_mark_iloc_dirty+0x27/0x40
Jan  8 15:45:36 middle kernel:  [<c0195c84>] __ext3_journal_stop+0x24/0x50
Jan  8 15:45:36 middle kernel:  [<c0191aa8>] ext3_dirty_inode+0x68/0x90
Jan  8 15:45:36 middle kernel:  [<c0174f2b>] __mark_inode_dirty+0xeb/0xf0
Jan  8 15:45:36 middle kernel:  [<c016f314>] update_atime+0x84/0xd0
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c046a6c3>] error_code+0x2f/0x38
Jan  8 15:45:36 middle kernel:  [<c0139dab>] filemap_populate_nonblock+0x1bb/0x2b0
Jan  8 15:45:36 middle kernel:  [<c0147e38>] do_no_page+0x3f8/0x410
Jan  8 15:45:36 middle kernel:  [<c014806a>] handle_mm_fault+0xda/0x180
Jan  8 15:45:36 middle kernel:  [<c011b3e5>] do_page_fault+0x315/0x51f
Jan  8 15:45:36 middle kernel:  [<c01287ad>] update_wall_time+0xd/0x40
Jan  8 15:45:36 middle kernel:  [<c0128c1d>] do_timer+0xdd/0xf0
Jan  8 15:45:36 middle kernel:  [<c010cc19>] do_IRQ+0x109/0x140
Jan  8 15:45:36 middle kernel:  [<c011b0d0>] do_page_fault+0x0/0x51f
Jan  8 15:45:36 middle kernel:  [<c046a6c3>] error_code+0x2f/0x38
Jan  8 15:45:36 middle kernel: 
Jan  8 15:53:42 middle shutdown[14288]: shutting down for system reboot

This ran fine using 2.6.1-rc1-mm1.

my .config:

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_RELAXED_AML=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_MAX_SD_DISKS=2
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139_RXBUF_IDX=2
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ISA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_EMU10K1=y
CONFIG_SND_CMIPCI=y
CONFIG_SND_INTEL8X0=y
CONFIG_SND_VIA82XX=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_SCANNER=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_XFS_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y
