Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUC2SIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUC2SIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:08:24 -0500
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:61704 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S263010AbUC2SH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:07:56 -0500
Date: Mon, 29 Mar 2004 20:07:41 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-mm4: tg3 problem / interrupts
Message-ID: <20040329180741.GA1569@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with my on-board Broadcom BCM5705 network card;
if I boot it works for a few seconds, then it stops. ifconfig eth0 down;
ifconfig eth0 up works for a few seconds, then it stops.

Often dmesg is silent, once I saw this:

tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
irq 185: nobody cared!
Call Trace:
 [<c01087a3>] __report_bad_irq+0x23/0x80
 [<c0108878>] note_interrupt+0x58/0x90
 [<c0108c36>] do_IRQ+0x1f6/0x240
 [<c046e1d8>] common_interrupt+0x18/0x20
 [<c0105080>] default_idle+0x30/0x40
 [<c0105105>] cpu_idle+0x35/0x50
 [<c058b9d8>] start_kernel+0x188/0x1c0

handlers:
[<c03eb090>] (snd_intel8x0_interrupt+0x0/0x2c0)
[<c0314040>] (tg3_interrupt+0x0/0x190)
Disabling IRQ #185

.config:

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
CONFIG_STOP_MACHINE=y
CONFIG_X86_PC=y
CONFIG_M586=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
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
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_USE_VECTOR=y
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
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
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
CONFIG_SCSI_QLA2XXX=y
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
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_NET_PCI=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139_RXBUF_IDX=2
CONFIG_TIGON3=y
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_HW_RANDOM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_INTEL_MCH=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ISA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_EEPROM=m
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
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
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
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_FRAME_POINTER=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

lspci:
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
	Subsystem: Unknown device 1695:4003
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f2000000-f4ffffff
	Prefetchable memory behind bridge: f0000000-f1ffffff

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at cc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 193
	I/O ports at c000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at c400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at c800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 201
	Memory at f7000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00008000-0000bfff
	Memory behind bridge: f5000000-f6ffffff

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f000 [size=16]
	Memory at c0000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
	Subsystem: Unknown device 1695:4003
	Flags: medium devsel, IRQ 185
	I/O ports at 0500 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
	Subsystem: Unknown device 1695:4003
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at d400 [size=256]
	I/O ports at d800 [size=64]
	Memory at f7002000 (32-bit, non-prefetchable) [size=512]
	Memory at f7003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual Head
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
	Memory at f3000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 169
	I/O ports at 8000 [size=8]
	I/O ports at 8400 [size=4]
	I/O ports at 8800 [size=8]
	I/O ports at 8c00 [size=4]
	I/O ports at 9000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 169
	I/O ports at 9400 [size=8]
	I/O ports at 9800 [size=4]
	I/O ports at 9c00 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at a400 [size=256]
	Capabilities: <available only to root>

02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
	Subsystem: Unknown device 1695:9013
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 185
	Memory at f6000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

02:02.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Flags: bus master, medium devsel, latency 32, IRQ 177
	I/O ports at a800 [size=32]
	Capabilities: <available only to root>

02:02.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at ac00 [size=8]
	Capabilities: <available only to root>

02:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c860 (rev 13)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
	Flags: bus master, medium devsel, latency 32, IRQ 217
	I/O ports at b000 [size=256]
	Memory at f6010000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

02:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Flags: bus master, medium devsel, latency 32, IRQ 201
	I/O ports at b400 [size=256]
	Memory at f6011000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

/proc/interrupts:

           CPU0       CPU1       
  0:     455677          0    IO-APIC-edge  timer
  1:       2842          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:          8          0    IO-APIC-edge  serial
  8:          4          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:         59          0    IO-APIC-edge  i8042
 14:      13636          1    IO-APIC-edge  ide0
 15:      13511          0    IO-APIC-edge  ide1
169:       8081          0   IO-APIC-level  ide2, ide3, ide4, ide5, uhci_hcd, uhci_hcd
177:          0          0   IO-APIC-level  uhci_hcd, EMU10K1
185:     200000          0   IO-APIC-level  Intel ICH5, eth0
193:          0          0   IO-APIC-level  uhci_hcd
201:          0          0   IO-APIC-level  ehci_hcd
217:        101          0   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:     455275     455453 
ERR:          0
MIS:          0


Is there anything I can do to get eth0 to work?

Thanks,
Jurriaan
-- 
Diplomacy is the art of saying "Nice doggie!" till you can find a rock.
        Wynn Catlin
Debian (Unstable) GNU/Linux 2.6.5-rc2-mm4 2x4734 bogomips 0.50 0.23
