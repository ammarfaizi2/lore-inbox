Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWALUFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWALUFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWALUFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:05:08 -0500
Received: from amun.rz.tu-clausthal.de ([139.174.2.12]:7150 "EHLO
	amun.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S1161232AbWALUFE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:05:04 -0500
From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: two (little) problems wit 2.6.15-git7 one with build, one with acpi
Date: Thu, 12 Jan 2006 21:04:35 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601122104.35794.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I used the git-kernel ebuild to get the -git7 sources and build a kernel.

the first problem occured while installing:
make oldconfig (with a config from 2.6.15-rc7) worked fine, but when I did 
'make all modules_install install' like always, I got an error, 
that /lib/modules/2.6.15-git7 does not exists.
make install or make modules_install alone worked fine, so I did not care much 
and rebooted.

After reboot I tried this:
echo mem > /sys/power/state

the box went off, no fans turning, keyboard dead, monitor in standby 
(usb-mouse lights were still on), and on hitting the power button, the 
harddrive spun up. 
But than it hanged. 
Well, it had never come back from this, keyboard dead no lights there, monitor 
in standby and so on, but this time was much worse.

Usually everything starts to work again, when I hit the reset button, but with 
git7 nothing happend. Keyboard still dead, monitor still in deep standby, 
only the harddisk light flashed for a moment. I tried the reset button 
several times with the same result everytime: except the drives flashing 
their lights, nothing happened.

Ok, I thought and pushed the power button for some seconds. The box turned 
off, I turned it on with the power button and nothing happened. The harddisk 
flashed for a moment, but monitor was still 'dead' and no reaction to any 
heyboard key. 
I had to pull the plug and only after that my computer booted again.

hardware:
Amd64 'Venice' 3200+ (power scaling works fine with it)
Asrock 939DualSataII
Audigy2 Value
Terratec Tv+
Asus Geforce 6600 passiv cooled (the nvidia driver was not loaded, nor X 
running) in PCIE slot
Leadtec Geforce 5200 in the AGP slot.
usb mouse
ps/2 keyboard
Enermax PSU.
Monitor is connected to the PCIE card.

here is my some config output:
grep ^C .config
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
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_DOUBLEFAULT=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DUMMY_IOMMU=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_AMD=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_SECCOMP=y
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_SLEEP_PROC_SLEEP=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_BLACKLIST_YEAR=2001
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m
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
CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_UNORDERED_IO=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_MSI=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_FIB_HASH=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=4
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=16
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_NETDEVICES=y
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_TULIP=y
CONFIG_ULI526X=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=960
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_AMD64=m
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_ISA=m
CONFIG_SENSORS_EEPROM=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_MPU401=m
CONFIG_SND_EMU10K1=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_MON=y
CONFIG_EXT2_FS=y
CONFIG_REISERFS_FS=y
CONFIG_INOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_INIT_DEBUG=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m

and here my dmesg immediately after boot:

[    0.000000] Bootdata ok (command line is root=/dev/hda3 gentoo=nodevfs 
noexec=on nmi_watchdog=1)
[    0.000000] Linux version 2.6.15-git7 (root@energy) (gcc-Version 3.4.5 
(Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)) #1 Thu Jan 12 20:30:31 CET 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
[    0.000000]  BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
[    0.000000] ACPI: RSDP (v000 ACPIAM                                ) @ 
0x00000000000f9b60
[    0.000000] ACPI: RSDT (v001 A M I  OEMRSDT  0x08000526 MSFT 0x00000097) @ 
0x000000003ffb0000
[    0.000000] ACPI: FADT (v002 A M I  OEMFACP  0x08000526 MSFT 0x00000097) @ 
0x000000003ffb0200
[    0.000000] ACPI: MADT (v001 A M I  OEMAPIC  0x08000526 MSFT 0x00000097) @ 
0x000000003ffb0390
[    0.000000] ACPI: OEMB (v001 A M I  AMI_OEM  0x08000526 MSFT 0x00000097) @ 
0x000000003ffc0040
[    0.000000] ACPI: DSDT (v001  939M2 939M2120 0x00000120 INTL 0x02002026) @ 
0x0000000000000000
[    0.000000] On node 0 totalpages: 257487
[    0.000000]   DMA zone: 3045 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 254442 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages, LIFO batch:0
[    0.000000]   HighMem zone: 0 pages, LIFO batch:0
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:15 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec10000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 17, address 0xfec10000, GSI 24-39
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 
40000000:bf7c0000)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/hda3 gentoo=nodevfs noexec=on 
nmi_watchdog=1
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 2000.112 MHz processor.
[   19.797661] time.c: Using PIT/TSC based timekeeping.
[   19.799744] Console: colour VGA+ 80x25
[   19.801832] Dentry cache hash table entries: 131072 (order: 8, 1048576 
bytes)
[   19.803033] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   19.812833] Memory: 1027960k/1048256k available (1967k kernel code, 19616k 
reserved, 927k data, 152k init)
[   19.891486] Calibrating delay using timer specific routine.. 4004.75 
BogoMIPS (lpj=8009516)
[   19.891607] Mount-cache hash table entries: 256
[   19.891734] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 
bytes/line)
[   19.891783] CPU: L2 Cache: 512K (64 bytes/line)
[   19.891833] mtrr: v2.0 (20020519)
[   19.891878] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
[   19.939935] activating NMI Watchdog ... done.
[   19.940014] Using local APIC timer interrupts.
[   19.989963] Detected 12.500 MHz APIC timer.
[   19.990014] testing NMI watchdog ... OK.
[   20.030297] NET: Registered protocol family 16
[   20.030359] ACPI: bus type pci registered
[   20.030408] PCI: Using configuration type 1
[   20.030726] ACPI: Subsystem revision 20050902
[   20.036257] ACPI: Interpreter enabled
[   20.036303] ACPI: Using IOAPIC for interrupt routing
[   20.036939] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   20.036986] PCI: Probing PCI hardware (bus 00)
[   20.039070] PCI quirk: region 0800-083f claimed by ali7101 ACPI
[   20.039434] Boot video device is 0000:01:00.0
[   20.039729] PCI: Transparent bridge - 0000:00:06.0
[   20.039803] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   20.051969] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[   20.052200] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
[   20.056149] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
[   20.056331] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
[   20.056941] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 *7 10 11 12 14 
15)
[   20.057600] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 
15)
[   20.058256] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 
15), disabled.
[   20.058952] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 
15), disabled.
[   20.059661] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 
15)
[   20.060317] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 
15)
[   20.060976] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 
15)
[   20.061636] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) 
*9
[   20.062333] ACPI: PCI Interrupt Link [LNKP] (IRQs *3 4 5 6 7 10 11 12 14 
15)
[   20.062901] SCSI subsystem initialized
[   20.062976] usbcore: registered new driver usbfs
[   20.063046] usbcore: registered new driver hub
[   20.063124] PCI: Using ACPI for IRQ routing
[   20.063230] PCI: If a device doesn't work, try "pci=routeirq".  If it 
helps, post a report
[   20.064045] PCI: Bridge: 0000:00:01.0
[   20.064089]   IO window: disabled.
[   20.064136]   MEM window: f2700000-fc7fffff
[   20.064182]   PREFETCH window: a7e00000-c7dfffff
[   20.064229] PCI: Bridge: 0000:00:02.0
[   20.064273]   IO window: disabled.
[   20.064318]   MEM window: fc800000-fc8fffff
[   20.064364]   PREFETCH window: disabled.
[   20.064410] PCI: Bridge: 0000:00:05.0
[   20.064454]   IO window: disabled.
[   20.064501]   MEM window: fc900000-fe9fffff
[   20.064548]   PREFETCH window: c7e00000-d7dfffff
[   20.064596] PCI: Bridge: 0000:00:06.0
[   20.064642]   IO window: d000-dfff
[   20.064689]   MEM window: fea00000-feafffff
[   20.064736]   PREFETCH window: d7e00000-d7efffff
[   20.064795] GSI 16 sharing vector 0xA9 and IRQ 16
[   20.064842] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> 
IRQ 169
[   20.064933] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   20.064939] GSI 17 sharing vector 0xB1 and IRQ 17
[   20.064985] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> 
IRQ 177
[   20.065074] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   20.065081] PCI: Setting latency timer of device 0000:00:05.0 to 64
[   20.065087] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   20.065298] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak 
Exp $
[   20.065672] Total HugeTLB memory allocated, 0
[   20.065819] io scheduler noop registered
[   20.065897] io scheduler anticipatory registered
[   20.065975] io scheduler deadline registered
[   20.066057] io scheduler cfq registered
[   20.066832] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> 
IRQ 169
[   20.066926] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   20.066948] assign_interrupt_mode Found MSI capability
[   20.067025] Allocate Port Service[0000:00:01.0:pcie00]
[   20.067055] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> 
IRQ 177
[   20.067146] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   20.067181] assign_interrupt_mode Found MSI capability
[   20.067247] Allocate Port Service[0000:00:02.0:pcie00]
[   20.067332] ACPI: Power Button (FF) [PWRF]
[   20.067387] ACPI: Power Button (CM) [PWRB]
[   20.078956] Real Time Clock Driver v1.12
[   20.081149] serio: i8042 AUX port at 0x60,0x64 irq 12
[   20.081348] serio: i8042 KBD port at 0x60,0x64 irq 1
[   20.081468] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   20.081517] ide: Assuming 33MHz system bus speed for PIO modes; override 
with idebus=xx
[   20.081603] ALI15X3: IDE controller at PCI slot 0000:00:12.0
[   20.081658] GSI 18 sharing vector 0xD1 and IRQ 18
[   20.081705] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 19 (level, low) -> 
IRQ 209
[   20.081801] ALI15X3: chipset revision 199
[   20.081847] ALI15X3: not 100% native mode: will probe irqs later
[   20.081904]     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, 
hdb:pio
[   20.082029]     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, 
hdd:pio
[   20.082152] Probing IDE interface ide0...
[   20.370787] hda: SAMSUNG SP1213N, ATA DISK drive
[   21.041445] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   21.041568] Probing IDE interface ide1...
[   21.776166] hdc: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
[   22.446812] ide1 at 0x170-0x177,0x376 on irq 15
[   22.446993] hda: max request size: 512KiB
[   22.448873] hda: 234493056 sectors (120060 MB) w/8192KiB Cache, 
CHS=16383/255/63, UDMA(100)
[   22.449407] hda: cache flushes supported
[   22.449482]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
[   22.488736] hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, 
UDMA(33)
[   22.489030] Uniform CD-ROM driver Revision: 3.20
[   22.490381] usbmon: debugfs is not available
[   22.490442] usbcore: registered new driver usbhid
[   22.490489] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   22.490573] mice: PS/2 mouse device common for all mice
[   22.490662] NET: Registered protocol family 2
[   22.530599] IP route cache hash table entries: 32768 (order: 6, 262144 
bytes)
[   22.530867] TCP established hash table entries: 131072 (order: 8, 1048576 
bytes)
[   22.531699] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   22.532106] TCP: Hash tables configured (established 131072 bind 65536)
[   22.532155] TCP reno registered
[   22.532216] TCP bic registered
[   22.532272] NET: Registered protocol family 1
[   22.532322] NET: Registered protocol family 17
[   22.532370] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors 
(version 1.60.0)
[   22.532526] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
[   22.532575] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8 (1350 mV)
[   22.532623] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xa (1300 mV)
[   22.532673] cpu_init done, current fid 0xc, vid 0x6
[   22.532818] ACPI wakeup devices:
[   22.532863]  HTT PS2K AC97 MC97  LAN USB0 USB1 USB2 UB20 PEB1 PEB2 PEB3
[   22.533265] ACPI: (supports S0 S1 S3 S4 S5)
[   22.554005] ReiserFS: hda3: found reiserfs format "3.6" with standard 
journal
[   22.760853] input: AT Translated Set 2 keyboard as /class/input/input0
[   26.129529] ReiserFS: hda3: using ordered data mode
[   26.141918] ReiserFS: hda3: journal params: device hda3, size 8192, journal 
first block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
[   26.143607] ReiserFS: hda3: checking transaction log (hda3)
[   26.200593] ReiserFS: hda3: replayed 7 transactions in 0 seconds
[   26.216745] ReiserFS: hda3: Using r5 hash to sort names
[   26.216807] VFS: Mounted root (reiserfs filesystem) readonly.
[   26.216951] Freeing unused kernel memory: 152k freed
[   29.633252] Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1 
across:996020k
[   30.069415] ReiserFS: hda3: Removing [344649 119965 0x0 SD]..done
[   30.069476] ReiserFS: hda3: Removing [344649 115674 0x0 SD]..done
[   30.069510] ReiserFS: hda3: Removing [344649 73948 0x0 SD]..done
[   30.069541] ReiserFS: hda3: There were 3 uncompleted unlinks/truncates. 
Completed
[   30.712913] uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
[   30.713136] GSI 19 sharing vector 0xD9 and IRQ 19
[   30.713140] ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> 
IRQ 217
[   30.735403] eth0: ULi M5263 at pci0000:00:11.0, 00:13:8f:3f:bf:15, irq 217.
[   30.750951] Linux video capture interface: v1.00
[   30.848128] bttv: driver version 0.9.16 loaded
[   30.848132] bttv: using 8 buffers with 2080k (520 pages) each for capture
[   30.848162] bttv: Bt8xx card found (0).
[   30.848176] GSI 20 sharing vector 0xE1 and IRQ 20
[   30.848179] ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, low) -> 
IRQ 225
[   30.848190] bttv0: Bt848 (rev 18) at 0000:04:06.0, irq: 225, latency: 32, 
mmio: 0xd7eff000
[   30.848200] bttv0: using: Terratec TerraTV+ Version 1.0 (Bt848)/ Terra 
TValue Version 1.0/ Vobis TV-Boostar [card=25,insmod option]
[   30.848232] bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
[   31.849191] bttv0: tea5757: read timeout
[   31.849195] bttv0: using tuner=5
[   31.849199] bttv0: i2c: checking for MSP34xx @ 0x80... not found
[   31.851340] bttv0: i2c: checking for TDA9875 @ 0xb0... not found
[   31.853465] bttv0: i2c: checking for TDA7432 @ 0x8a... not found
[   31.855590] bttv0: i2c: checking for TDA9887 @ 0x86... not found
[   31.877691] tuner 0-0060: All bytes are equal. It is not a TEA5767
[   31.877695] tuner 0-0060: chip found @ 0xc0 (bt848 #0 [sw])
[   31.877924] tuner 0-0060: type set to 5 (Philips PAL_BG (FI1216 and 
compatibles))
[   31.913914] bttv0: registered device video0
[   31.913987] bttv0: registered device vbi0
[   32.079354] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[   32.079573] GSI 21 sharing vector 0xE9 and IRQ 21
[   32.079577] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 20 (level, low) -> 
IRQ 233
[   32.079738] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   32.080164] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus 
number 1
[   32.080177] ohci_hcd 0000:00:13.0: irq 233, io mem 0xfebfe000
[   32.135065] usb usb1: configuration #1 chosen from 1 choice
[   32.135155] hub 1-0:1.0: USB hub found
[   32.135164] hub 1-0:1.0: 3 ports detected
[   32.236631] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 21 (level, low) -> 
IRQ 225
[   32.236734] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   32.237052] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus 
number 2
[   32.237060] ohci_hcd 0000:00:13.1: irq 225, io mem 0xfebfd000
[   32.294697] usb usb2: configuration #1 chosen from 1 choice
[   32.294793] hub 2-0:1.0: USB hub found
[   32.294802] hub 2-0:1.0: 3 ports detected
[   32.396317] GSI 22 sharing vector 0x32 and IRQ 22
[   32.396321] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 22 (level, low) -> 
IRQ 50
[   32.396420] ohci_hcd 0000:00:13.2: OHCI Host Controller
[   32.396744] ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus 
number 3
[   32.396756] ohci_hcd 0000:00:13.2: irq 50, io mem 0xfebfc000
[   32.454393] usb usb3: configuration #1 chosen from 1 choice
[   32.454490] hub 3-0:1.0: USB hub found
[   32.454499] hub 3-0:1.0: 3 ports detected
[   32.491984] usb 1-1: new full speed USB device using ohci_hcd and address 2
[   32.656685] usb 1-1: configuration #1 chosen from 1 choice
[   32.662707] hub 1-1:1.0: USB hub found
[   32.665666] hub 1-1:1.0: 4 ports detected
[   32.670069] GSI 23 sharing vector 0x3A and IRQ 23
[   32.670073] ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, low) -> 
IRQ 58
[   32.670237] ehci_hcd 0000:00:13.3: EHCI Host Controller
[   32.670272] ehci_hcd 0000:00:13.3: debug port 1
[   32.691949] ehci_hcd 0000:00:13.3: new USB bus registered, assigned bus 
number 4
[   32.691962] ehci_hcd 0000:00:13.3: irq 58, io mem 0xfebff800
[   32.691971] ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[   32.692240] usb usb4: configuration #1 chosen from 1 choice
[   32.692339] hub 4-0:1.0: USB hub found
[   32.692347] hub 4-0:1.0: 8 ports detected
[   32.792485] usb 1-1: USB disconnect, address 2
[   33.498105] usb 1-1: new full speed USB device using ohci_hcd and address 3
[   33.662785] usb 1-1: configuration #1 chosen from 1 choice
[   33.668814] hub 1-1:1.0: USB hub found
[   33.671766] hub 1-1:1.0: 4 ports detected
[   34.011116] usb 1-1.3: new low speed USB device using ohci_hcd and address 
4
[   34.115921] usb 1-1.3: configuration #1 chosen from 1 choice
[   34.130936] input: HID 062a:0000 as /class/input/input1
[   34.130964] input: USB HID v1.10 Mouse [HID 062a:0000] on 
usb-0000:00:13.0-1.3
[   38.228262] ReiserFS: hda5: found reiserfs format "3.6" with standard 
journal
[   41.280914] ReiserFS: hda5: using ordered data mode
[   41.299904] ReiserFS: hda5: journal params: device hda5, size 8192, journal 
first block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
[   41.301469] ReiserFS: hda5: checking transaction log (hda5)
[   41.374824] ReiserFS: hda5: Using r5 hash to sort names
[   45.469640] ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 22 (level, low) -> 
IRQ 50
[   45.473199] Audigy2 value: Special config.
[   52.782409] uli526x: eth0 NIC Link is Up 100 Mbps Full duplex
[   53.165707] ali1563: SMBus control = 0403
[   53.174133] ali1563_probe: Returning 0


If you want more information, or if I should try something, please mail me.


Glück Auf
Volker
