Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUKVWAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUKVWAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUKVV7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:59:45 -0500
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:39320 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S262398AbUKVVyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:54:50 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: Bob van Manen <bobm75@gmail.com>
Subject: Re: 2.6. 9-gentoo-r4 migration kernel thread is using 10-60% cpu
Date: Mon, 22 Nov 2004 14:55:11 -0700
User-Agent: KMail/1.7.50
Cc: linux-kernel@vger.kernel.org
References: <88652ca704112212541b530efc@mail.gmail.com>
In-Reply-To: <88652ca704112212541b530efc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411221455.12234.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you made an attempt to contact the gentoo kernel team ? As it's probally 
some patch they tacked onto there kernel release that's causing you issues.

On Monday 22 November 2004 1:54 pm, Bob van Manen wrote:
> SITUATION
>
> I'm running the 2.6.9-gentoo-r4 kernel on a dual xeon box with
> hyperthreading enabled.
>
> I have FoldingAtHome running at niceness value of +19. That works fine
> by itself, but when I add another process running at +19 the cpu usage
> of migration/2 shoots up and varies between 10-60%. It's not constant
> and goes up and down, but it uses at least 10% of a cpu. This happens
> everytime. I haven't used another kernel yet in this situation, so I
> can't tell if it has changed.
>
> Let me know if any more information is needed.
>
> DMESG
>
> Linux version 2.6.9-gentoo-r4 (root@o-ren) (gcc version 3.3.4 20040623
> (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #1 SMP Mon Nov 15
> 10:05:39 PST 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff75000 (usable)
>  BIOS-e820: 000000003ff75000 - 000000003ff77000 (ACPI NVS)
>  BIOS-e820: 000000003ff77000 - 000000003ff98000 (ACPI data)
>  BIOS-e820: 000000003ff98000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000fe710
> On node 0 totalpages: 262005
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 32629 pages, LIFO batch:7
> DMI 2.3 present.
> ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
> ACPI: RSDT (v001 DELL    WS 450  0x00000008 ASL  0x00000061) @ 0x000fd4e7
> ACPI: FADT (v001 DELL    WS 450  0x00000008 ASL  0x00000061) @ 0x000fd51f
> ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffd7d4e
> ACPI: MADT (v001 DELL    WS 450  0x00000008 ASL  0x00000061) @ 0x000fd593
> ACPI: BOOT (v001 DELL    WS 450  0x00000008 ASL  0x00000061) @ 0x000fd617
> ACPI: ASF! (v016 DELL    WS 450  0x00000008 ASL  0x00000061) @ 0x000fd63f
> ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
> Processor #6 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
> Processor #1 15:2 APIC version 20
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
> Processor #7 15:2 APIC version 20
> Using ACPI for processor (LAPIC) configuration information
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: DELL     Product ID: WS 450       APIC at: 0xFEE00000
> I/O APIC #8 Version 32 at 0xFEC00000.
> I/O APIC #10 Version 32 at 0xFEC80000.
> I/O APIC #9 Version 32 at 0xFEC80800.
> Enabling APIC mode:  Flat.  Using 3 I/O APICs
> Processors: 4
> Built 1 zonelists
> Kernel command line: root=/dev/hda6
> video=vesafb:ywrap,mtrr,1280x1024-32@85 elevator=cfq
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 2392.247 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1035088k/1048020k available (1890k kernel code, 12272k
> reserved, 576k data, 172k init, 130516k highmem)
> Checking if this processor honours the WP bit even in supervisor mode...
> Ok. Calibrating delay loop... 4718.59 BogoMIPS (lpj=2359296)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU0: Thermal monitoring enabled
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
> per-CPU timeslice cutoff: 1462.89 usecs.
> task migration cache decay timeout: 2 msecs.
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> Calibrating delay loop... 4767.74 BogoMIPS (lpj=2383872)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU1: Thermal monitoring enabled
> CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
> Booting processor 2/6 eip 2000
> Initializing CPU#2
> Calibrating delay loop... 4767.74 BogoMIPS (lpj=2383872)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 3
> CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#2.
> CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU2: Thermal monitoring enabled
> CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
> Booting processor 3/7 eip 2000
> Initializing CPU#3
> Calibrating delay loop... 4767.74 BogoMIPS (lpj=2383872)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 3
> CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#3.
> CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU3: Thermal monitoring enabled
> CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 09
> Total of 4 processors activated (19021.82 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=0
> checking TSC synchronization across 4 CPUs: passed.
> Brought up 4 CPUs
> checking if image is initramfs...it isn't (ungzip failed); looks like an
> initrd Freeing initrd memory: 157k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfbde8, last bus=5
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
> PCI->APIC IRQ transform: (B0,I29,P0) -> 16
> PCI->APIC IRQ transform: (B0,I29,P1) -> 19
> PCI->APIC IRQ transform: (B0,I29,P2) -> 18
> PCI->APIC IRQ transform: (B0,I29,P3) -> 23
> PCI->APIC IRQ transform: (B0,I31,P0) -> 18
> PCI->APIC IRQ transform: (B0,I31,P1) -> 17
> PCI->APIC IRQ transform: (B0,I31,P1) -> 17
> PCI->APIC IRQ transform: (B1,I0,P0) -> 16
> PCI->APIC IRQ transform: (B3,I14,P0) -> 24
> Simple Boot Flag value 0x87 read from CMOS RAM was invalid
> Simple Boot Flag at 0x7a set to 0x1
> Machine check exception polling timer started.
> IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
> Starting balanced_irq
> highmem bounce pool size: 64 pages
> NTFS driver 2.1.20 [Flags: R/O].
> inotify init: minor=63
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected an Intel E7505 Chipset.
> agpgart: Maximum main memory to use for agp memory: 941M
> agpgart: AGP aperture is 128M @ 0xe8000000
> vesafb: NVIDIA Corporation, NV18 Board - p118wsnz, Chip Rev A2 (OEM:
> NVIDIA) vesafb: VBE version: 3.0
> vesafb: protected mode interface info at c000:f320
> vesafb: pmi: set display start = c00cf356, set palette = c00cf3c0
> vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc
> 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
> vesafb: hardware doesn't support DCC transfers
> vesafb: monitor limits: vf = 0 Hz, hf = 0 kHz, clk = 0 MHz
> vesafb: scrolling: ywrap using protected mode interface, yres_virtual=3276
> Console: switching to colour frame buffer device 160x64
> vesafb: framebuffer at 0xf0000000, mapped to 0xf8880000, size 16384k
> fb0: VESA VGA frame buffer device
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS/2 Logitech Mouse on isa0060/serio1
> Using cfq io scheduler
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
> Copyright (c) 1999-2004 Intel Corporation.
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH4: IDE controller at PCI slot 0000:00:1f.1
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ICH4: chipset revision 1
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: ST380011A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: HL-DT-ST RW/DVD GCC-4481B, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 1024KiB
> hda: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=16383/255/63,
> UDMA(100) hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> hdc: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> oprofile: using NMI interrupt.
> NET: Registered protocol family 2
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> ReiserFS: hda6: found reiserfs format "3.6" with standard journal
> ReiserFS: hda6: using ordered data mode
> ReiserFS: hda6: journal params: device hda6, size 8192, journal first
> block 18, max trans len1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda6: checking transaction log (hda6)
> ReiserFS: hda6: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 172k freed
> Adding 1959888k swap on /dev/hda5.  Priority:-1 extents:1
> nvidia: module license 'NVIDIA' taints kernel.
> NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov
>  3 13:12:51 PST 2004
> NTFS volume version 3.1.
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> microcode: CPU3 updated from revision 0xf to 0x2d, date = 08112004
> microcode: CPU1 updated from revision 0xf to 0x2d, date = 08112004
> microcode: CPU2 updated from revision 0xf to 0x2d, date = 08112004
> microcode: CPU0 updated from revision 0xf to 0x2d, date = 08112004
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
>
> CONFIGURATION
>
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.9-gentoo-r4
> # Mon Nov 15 10:02:14 2004
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_IOMAP=y
>
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
>
> #
> # General setup
> #
> CONFIG_LOCALVERSION=""
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_HOTPLUG=y
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SHMEM=y
> # CONFIG_TINY_SHMEM is not set
>
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> # CONFIG_MODULE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> # CONFIG_KMOD is not set
>
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> CONFIG_MPENTIUM4=y
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_HPET_TIMER is not set
> CONFIG_SMP=y
> CONFIG_NR_CPUS=4
> CONFIG_SCHED_SMT=y
> CONFIG_PREEMPT=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=y
> CONFIG_X86_MCE_P4THERMAL=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
>
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> CONFIG_HIGHMEM=y
> # CONFIG_HIGHPTE is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_IRQBALANCE=y
> CONFIG_HAVE_DEC_LOCK=y
> # CONFIG_REGPARM is not set
>
> #
> # Power management options (ACPI, APM)
> #
> # CONFIG_PM is not set
> # CONFIG_PM_DEBUG is not set
>
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> # CONFIG_ACPI is not set
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
>
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
>
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_PCI_MSI is not set
> # CONFIG_PCI_LEGACY_PROC is not set
> # CONFIG_PCI_NAMES is not set
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
>
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
>
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
>
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> # CONFIG_FW_LOADER is not set
>
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
>
> #
> # Plug and Play support
> #
>
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_LBD=y
>
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
>
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_IDE_SATA is not set
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=y
>
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
>
> #
> # SCSI device support
> #
> # CONFIG_SCSI is not set
>
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>
> #
> # Fusion MPT device support
> #
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
>
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
>
> #
> # Networking support
> #
> CONFIG_NET=y
>
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> # CONFIG_NETLINK_DEV is not set
> CONFIG_UNIX=y
> CONFIG_NET_KEY=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_TUNNEL is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETFILTER is not set
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
>
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> # CONFIG_NET_CLS_ROUTE is not set
>
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_NETDEVICES=y
> CONFIG_DUMMY=y
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
>
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
>
> #
> # Ethernet (10 or 100Mbit)
> #
> # CONFIG_NET_ETHERNET is not set
>
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> CONFIG_E1000=y
> CONFIG_E1000_NAPI=y
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
>
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
>
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
>
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
>
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=y
>
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> # CONFIG_SERIO_RAW is not set
>
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
>
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_INOTIFY=y
> # CONFIG_SERIAL_NONSTANDARD is not set
>
> #
> # Serial drivers
> #
> # CONFIG_SERIAL_8250 is not set
>
> #
> # Non-8250 serial port support
> #
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
>
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=y
> # CONFIG_AGP_INTEL_MCH is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_EFFICEON is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
>
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
>
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
>
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>
> #
> # Graphics support
> #
> CONFIG_FB=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_VESA_STD is not set
> CONFIG_FB_VESA_TNG=y
> CONFIG_FB_VESA_DEFAULT_MODE="640x480@60"
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I810 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
>
> #
> # Logo configuration
> #
> # CONFIG_LOGO is not set
> CONFIG_FB_SPLASH=y
>
> #
> # Speakup console speech
> #
> # CONFIG_SPEAKUP is not set
> CONFIG_SPEAKUP_DEFAULT="none"
>
> #
> # Sound
> #
> # CONFIG_SOUND is not set
>
> #
> # USB support
> #
> # CONFIG_USB is not set
>
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_JBD is not set
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_REISERFS_FS_XATTR is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=y
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> CONFIG_UDF_FS=y
> CONFIG_UDF_NLS=y
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=y
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
>
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_SQUASHFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
>
> #
> # Network File Systems
> #
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> # CONFIG_EXPORTFS is not set
> CONFIG_SMB_FS=y
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
>
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
>
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
>
> #
> # Profiling support
> #
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=y
>
> #
> # Kernel hacking
> #
> # CONFIG_DEBUG_KERNEL is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_EARLY_PRINTK=y
> # CONFIG_4KSTACKS is not set
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
>
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
>
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
>
> #
> # Library routines
> #
> # CONFIG_CRC_CCITT is not set
> # CONFIG_CRC32 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_X86_SMP=y
> CONFIG_X86_HT=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_X86_TRAMPOLINE=y
> CONFIG_PC=y
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
