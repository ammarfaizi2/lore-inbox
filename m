Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVLXW4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVLXW4g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 17:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVLXW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 17:56:36 -0500
Received: from main.gmane.org ([80.91.229.2]:51108 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750745AbVLXW4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 17:56:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: 2.6.14.4 irqpoll / yenta problem? acpi?
Date: Sat, 24 Dec 2005 23:56:22 +0100
Message-ID: <dokjml$er$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-212-202-193-31.dynamic.qsc.de
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

even with this commandline: root=/dev/hda1 ro noapictimer irqpoll
I get this during bootup:

irq 11: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80153935>{__report_bad_irq+53}
<ffffffff80153b47>{note_interrupt+439}
       <ffffffff801534b8>{__do_IRQ+152} <ffffffff80110e6f>{do_IRQ+47}
       <ffffffff8010eef0>{ret_from_intr+0}  <EOI>
<ffffffff80217d76>{acpi_hw_low_level_read+126}
       <ffffffff80218009>{acpi_hw_low_level_write+120}
<ffffffff80217e43>{acpi_hw_register_read+196}
       <ffffffff802fa0f0>{pci_mmcfg_read+0}
<ffffffff8022beee>{acpi_processor_idle+324}
       <ffffffff8010d3a1>{cpu_idle+49} <ffffffff804d079f>{start_kernel+399}
       <ffffffff804d01f4>{_sinittext+500} 
handlers:
[<ffffffff8028fdb0>] (yenta_interrupt+0x0/0xc0)
Disabling IRQ #11

and later something similiar with acpi mixed into it.
the machine is a MSI S270 laptop with turion64 and ati chipset .
any idea what to do and how to get the pccard bus working?

here is the config, the full dmesg and the lspci...

Thanks for your help.

Andreas

CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_KALLSYMS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_SECCOMP=y
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_MSI=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_YENTA=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_BINFMT_ELF=y
CONFIG_IA32_EMULATION=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_FIB_HASH=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_TUNNEL=y
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_CONNECTOR=y
CONFIG_PNP=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_QLA2XXX=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=800
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_DRM=m
CONFIG_DRM_RADEON=m
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
CONFIG_I2C_ISA=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_HDAPS=m
CONFIG_FB=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SOFT_CURSOR=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_DEVICE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_USB_AUDIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_MON=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRPRIME=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_EZUSB=y
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_WBSD=m
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_INOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_LOG_BUF_SHIFT=14
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

00077f40200
ACPI: MADT (v001 MSI    OEMAPIC  0x11172005 MSFT 0x00000097) @
0x0000000077f40300
ACPI: WDRT (v001 MSI    MSI_OEM  0x11172005 MSFT 0x00000097) @
0x0000000077f40360
ACPI: MCFG (v001 MSI    OEMMCFG  0x11172005 MSFT 0x00000097) @
0x0000000077f403b0
ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @
0x0000000077f43700
ACPI: OEMB (v001 MSI    MSI_OEM  0x11172005 MSFT 0x00000097) @
0x0000000077f50040
ACPI: DSDT (v001    MSI     1013 0x11172005 INTL 0x02002026) @
0x0000000000000000
No mptable found.
On node 0 totalpages: 491231
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 487232 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Allocating PCI resources starting at 88000000 (gap: 80000000:7ff80000)
Checking aperture...
CPU 0: aperture @ 7cf6000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro noapictimer irqpoll
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2188.846 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1930604k/1965312k available (2622k kernel code, 34212k reserved,
934k data, 156k init)
Calibrating delay using timer specific routine.. 4388.01 BogoMIPS
(lpj=8776034)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
mtrr: v2.0 (20020519)
CPU: AMD Turion(tm) 64 Mobile Technology MT-40 stepping 02
ACPI: setting ELCR to 0200 (from 0ce0)
Disabling APIC timer
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC] (gpe 6)
spurious 8259A interrupt: IRQ7.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fbe00000-fbefffff
  PREFETCH window: d0000000-dfffffff
PCI: Bus 3, cardbus bridge: 0000:02:04.0
  IO window: 0000e000-0000e0ff
  IO window: 0000ec00-0000ecff
  PREFETCH window: 88000000-89ffffff
  MEM window: 8e000000-8fffffff
PCI: Bus 7, cardbus bridge: 0000:02:04.1
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 8a000000-8bffffff
  MEM window: 90000000-91ffffff
PCI: Bridge: 0000:00:14.4
  IO window: e000-efff
  MEM window: fbf00000-fbffffff
  PREFETCH window: 88000000-8cffffff
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 6
PCI: setting IRQ 6 as level-triggered
ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNKE] -> GSI 6 (level, low) ->
IRQ 6
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (58 C)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKC] -> GSI 5 (level, low) ->
IRQ 5
eth0: RealTek RTL8139 at 0xffffc20000006c00, 00:11:09:f9:0b:57, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8101'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [LNKA] -> GSI 10 (level, low) ->
IRQ 10
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHV2100AH, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVD-RW GCA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
Yenta: ISA IRQ mask 0x0098, PCI irq 11
Socket status: 30000810
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x8cffffff
ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNKE] -> GSI 6 (level, low) ->
IRQ 6
Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
Yenta: ISA IRQ mask 0x0098, PCI irq 6
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x8cffffff
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
ehci_hcd 0000:00:13.2: EHCI Host Controller
cs: memory probe 0x88000000-0x8cffffff: excluding 0x88000000-0x8cffffff
cs: memory probe 0xfbf00000-0xfbffffff: excluding 0xfbf00000-0xfbf0ffff
0xfbff0000-0xfbffffff
irq 11: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80153935>{__report_bad_irq+53}
<ffffffff80153b47>{note_interrupt+439}
       <ffffffff801534b8>{__do_IRQ+152} <ffffffff80110e6f>{do_IRQ+47}
       <ffffffff8010eef0>{ret_from_intr+0}  <EOI>
<ffffffff80217d76>{acpi_hw_low_level_read+126}
       <ffffffff80218009>{acpi_hw_low_level_write+120}
<ffffffff80217e43>{acpi_hw_register_read+196}
       <ffffffff802fa0f0>{pci_mmcfg_read+0}
<ffffffff8022beee>{acpi_processor_idle+324}
       <ffffffff8010d3a1>{cpu_idle+49} <ffffffff804d079f>{start_kernel+399}
       <ffffffff804d01f4>{_sinittext+500} 
handlers:
[<ffffffff8028fdb0>] (yenta_interrupt+0x0/0xc0)
Disabling IRQ #11
ehci_hcd 0000:00:13.2: BIOS handoff failed (160, 01010001)
ehci_hcd 0000:00:13.2: continuing after BIOS bug...
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: irq 11, io mem 0xfbdff000
ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 11, io mem 0xfbdfd000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [LNKD] -> GSI 11 (level, low) ->
IRQ 11
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 11, io mem 0xfbdfe000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usbcore: registered new driver hiddev
usb 3-2: new full speed USB device using ohci_hcd and address 2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [LNKB] -> GSI 10 (level, low) ->
IRQ 10
ALSA device list:
  #0: ATI IXP rev 1 with ALC655 at 0xfbdfc800, irq 10
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80428be0(lo)
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x16 (1000 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x10 (1150 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xe (1200 mV)
powernow-k8:    3 : fid 0xc (2000 MHz), vid 0xc (1250 mV)
powernow-k8:    4 : fid 0xe (2200 MHz), vid 0xa (1300 mV)
cpu_init done, current fid 0xe, vid 0x8
powernow-k8: ph2 null fid transition 0xe
ACPI wakeup devices: 
POP2  RTL USB1 USB2 EUSB AC97 MC97 
ACPI: (supports S0 S1 S3 S4 S5)
input: AT Translated Set 2 keyboard on isa0060/serio0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
logips2pp: Detected unknown logitech mouse model 99
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio2
logips2pp: Detected unknown logitech mouse model 99
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio2
EXT3 FS on hda1, internal journal
SCSI subsystem initialized
cdrom: open failed.
ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 10 (level, low) ->
IRQ 10
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:02:04.2[C] -> Link [LNKF] -> GSI 7 (level, low) ->
IRQ 7
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[7]  MMIO=[fbfff000-fbfff7ff] 
Max Packet=[2048]
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00007da2c6]
irq 7: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80153935>{__report_bad_irq+53}
<ffffffff80153b47>{note_interrupt+439}
       <ffffffff801534b8>{__do_IRQ+152} <ffffffff80110e6f>{do_IRQ+47}
       <ffffffff8010eef0>{ret_from_intr+0}
<ffffffff80261240>{as_queue_empty+0}
       <ffffffff801533da>{handle_IRQ_event+26}
<ffffffff8015349e>{__do_IRQ+126}
       <ffffffff80110e6f>{do_IRQ+47} <ffffffff8010eef0>{ret_from_intr+0}
       <ffffffff8020be2d>{acpi_os_read_port+44}
<ffffffff80217d76>{acpi_hw_low_level_read+126}
       <ffffffff80217df3>{acpi_hw_register_read+116}
<ffffffff8027dcf0>{cdrom_pc_intr+0}
       <ffffffff8020ff6d>{acpi_ev_fixed_event_detect+47}
<ffffffff80296ed0>{rh_timer_func+0}
       <ffffffff80210728>{acpi_ev_sci_xrupt_handler+12}
<ffffffff8020bcb9>{acpi_irq+15}
       <ffffffff801533ec>{handle_IRQ_event+44}
<ffffffff8015349e>{__do_IRQ+126}
       <ffffffff80110e6f>{do_IRQ+47} <ffffffff8010eef0>{ret_from_intr+0}
        <EOI> <ffffffff80217d76>{acpi_hw_low_level_read+126}
       <ffffffff80226996>{acpi_ec_read+202}
<ffffffff80226e10>{acpi_ec_space_handler+156}
       <ffffffff80226d74>{acpi_ec_space_handler+0}
<ffffffff802101d1>{acpi_ev_address_space_dispatch+224}
       <ffffffff80226d74>{acpi_ec_space_handler+0}
<ffffffff80216e7c>{acpi_ex_enter_interpreter+8}
       <ffffffff8021426b>{acpi_ex_access_region+263}
<ffffffff8021458f>{acpi_ex_field_datum_io+250}
       <ffffffff8021469f>{acpi_ex_extract_from_field+113}
<ffffffff80212f6f>{acpi_ex_read_data_from_field+283}
       <ffffffff802176ab>{acpi_ex_resolve_node_to_value+223}
       <ffffffff8020e7c7>{acpi_ds_init_object_from_op+36}
<ffffffff80213905>{acpi_ex_resolve_to_value+497}
       <ffffffff8020ef7e>{acpi_ds_create_operand+431}
<ffffffff802155d4>{acpi_ex_resolve_operands+485}
       <ffffffff8020de2d>{acpi_ds_exec_end_op+160}
<ffffffff8021c172>{acpi_ps_parse_loop+1370}
       <ffffffff8021ba70>{acpi_ps_parse_aml+81}
<ffffffff8021c935>{acpi_ps_execute_pass+127}
       <ffffffff8021c998>{acpi_ps_execute_method+77}
<ffffffff80219b88>{acpi_ns_evaluate_by_handle+216}
       <ffffffff80222ee7>{acpi_ut_release_mutex+8}
<ffffffff80219d3f>{acpi_ns_evaluate_relative+208}
       <ffffffff802193b3>{acpi_evaluate_object+251}
<ffffffff80224bb5>{acpi_battery_get_info+125}
       <ffffffff80224dee>{acpi_battery_read_info+71}
<ffffffff801931b5>{seq_read+309}
       <ffffffff80173c4b>{vfs_read+187} <ffffffff80174833>{sys_read+83}
       <ffffffff8010e94e>{system_call+126} 
handlers:
[<ffffffff8808f000>] (ohci_irq_handler+0x0/0x7a0 [ohci1394])
Disabling IRQ #7
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f (prog-if
00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fbe00000-fbefffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000dff00000
        Capabilities: [44] #08 [a803]
        Capabilities: [b0] #0d [0000]

0000:00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4374
(prog-if 10 [OHCI])
        Subsystem: ATI Technologies Inc: Unknown device 4374
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at fbdfd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

0000:00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4375
(prog-if 10 [OHCI])
        Subsystem: ATI Technologies Inc: Unknown device 4375
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at fbdfe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

0000:00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4373
(prog-if 20 [EHCI])
        Subsystem: ATI Technologies Inc: Unknown device 4373
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at fbdff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

0000:00:14.0 SMBus: ATI Technologies Inc: Unknown device 4372 (rev 10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: 66MHz, medium devsel
        I/O ports at c800 [size=16]
        Memory at fbdfc400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [b0] #08 [a802]

0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4376
(prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 10
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ff00 [size=16]
        Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377
        Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4371 (prog-if
01 [Subtractive decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fbf00000-fbffffff
        Prefetchable memory behind bridge: 88000000-8cffffff

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown
device 4370 (rev 01)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 10
        Memory at fbdfc800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

0000:00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 01)
(prog-if 00 [Generic])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 10
        Memory at fbdfcc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-

0000:01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5955 (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 10
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        I/O ports at d800 [size=256]
        Memory at fbef0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fbec0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2

0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at e800 [size=256]
        Memory at fbfffc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 8c000000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

0000:02:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at fbf00000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 88000000-89fff000 (prefetchable)
        Memory window 1: 8e000000-8ffff000
        I/O window 0: 0000e000-0000e0ff
        I/O window 1: 0000ec00-0000ecff
        16-bit legacy interface ports at 0001

0000:02:04.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, medium devsel, latency 168, IRQ 6
        Memory at fbf01000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 8a000000-8bfff000 (prefetchable)
        Memory window 1: 90000000-91fff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        16-bit legacy interface ports at 0001

0000:02:04.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 04) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
        Flags: bus master, medium devsel, latency 64, IRQ 7
        Memory at fbfff000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2

0000:02:09.0 Ethernet controller: Linksys, A Division of Cisco Systems
[AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 6855
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at e400 [size=32]
        Memory at fbfff800 (32-bit, non-prefetchable) [size=32]
        Memory at fbffe800 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [40] Power Management version 2


