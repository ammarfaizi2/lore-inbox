Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUBYHeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUBYHeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:34:37 -0500
Received: from littlegreenmen.armory.com ([192.122.209.37]:7047 "EHLO
	littlegreenmen.armory.com") by vger.kernel.org with ESMTP
	id S262653AbUBYHdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:33:02 -0500
Date: Tue, 24 Feb 2004 23:33:00 -0800
From: Phil White <cerise@armory.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 doesn't see my 2nd CPU
Message-ID: <20040225073300.GA3562@littlegreenmen.armory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another update.  The second processor still isn't working, but with args noapic, noirqbalance, and
maxcpus=4 (even though there's only 2 cpus), the APIC problems go away.  They're replaced with
spurious interrupts however.

Any ideas?

Here's the dmesg output from that (with redundant crap snipped out):
------------------------------------------------------------------------------------
Linux version 2.6.3-gentoo-r1 (root@littlegreenmen) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Fri Feb 20 16:54:42 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
ACPI: S3 and PAE do not like each other for now, S3 disabled.
found SMP MP-table at 000fb560
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 262144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32768 pages, LIFO batch:8
DMI 2.1 present.
ACPI disabled because your bios is from 99 and too old
You can enable it with acpi=force
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440GX        APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.3-g-r1 ro root=2141 noapic noirqbalance maxcpus=4
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 802.034 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 1032812k/1048576k available (2183k kernel code, 14832k reserved, 725k data, 176k init, 131072k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1585.15 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.23 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Unable to handle kernel paging request<1>Unable to handle kernel paging request at virtual address 3f83ec0d
 printing eip:
3f83ec0d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<3f83ec0d>]    Not tainted
EFLAGS: 00010082
EIP is at 0x3f83ec0d
eax: c1b3c000   ebx: 00000000   ecx: 00000001   edx: 00100100
esi: 00000000   edi: 00000026   ebp: 00000000   esp: c8008204
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=c8008000 task=3000801c)
Stack: c027abeb c1b3c000 00000002 c03a0b80 c027e74b 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 c03a0b80 00000026 00000c3c 00000001 
       c012616f c03a0b80 c040c4dc 00000026 00000c62 00000c62 00000c3c c012627f 
Call Trace:
 [<c027abeb>] hide_cursor+0x2b/0x50
 [<c027e74b>] vt_console_print+0x32b/0x350
 [<c012616f>] __call_console_drivers+0x5f/0x70
 [<c012627f>] call_console_drivers+0x6f/0x130
 [<c0126632>] release_console_sem+0x62/0xf0
 [<c0126532>] printk+0x182/0x1d0
 [<c011d144>] do_page_fault+0x154/0x53a
 [<c011cff0>] do_page_fault+0x0/0x53a
 [<c010a1dd>] error_code+0x2d/0x38

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
 Stuck ??
CPU #1 not responding - cannot use it.
Total of 1 processors activated (1585.15 BogoMIPS).

<snippage>

spurious 8259A interrupt: IRQ7.
spurious 8259A interrupt: IRQ15.
inserting floppy driver for 2.6.3-gentoo-r1
Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
FDC 0 is a National Semiconductor PC87306
------------------------------------------------------------

Here's the previous dmesg log and .config from the last post:

> On Fri, 20 Feb 2004, Phil White wrote:
> 
> So for whatever reason, my second processor isn't being seen in the 2.6 series of kernel.
> This isn't vanilla 2.6.3 (Gentoo adds a few patches), but this happens in every kernel I
> try.
>
> The hardware is OK (judging by POST).   Any ideas?
>
> dmesg shows this after bootup.
> -------------------------------------------------------
> Linux version 2.6.3-gentoo-r1 (root@littlegreenmen) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Fri Feb 20 16:54:42 PST 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> 128MB HIGHMEM available.
> 896MB LOWMEM available.
> ACPI: S3 and PAE do not like each other for now, S3 disabled.
> found SMP MP-table at 000fb560
> hm, page 000fb000 reserved twice.
> hm, page 000fc000 reserved twice.
> hm, page 000f6000 reserved twice.
> hm, page 000f7000 reserved twice.
> On node 0 totalpages: 262144
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 32768 pages, LIFO batch:8
> DMI 2.1 present.
> ACPI disabled because your bios is from 99 and too old
> You can enable it with acpi=force
> Intel MultiProcessor Specification v1.1
>     Virtual Wire compatibility mode.
> OEM ID: INTEL    Product ID: 440GX        APIC at: 0xFEE00000
> Processor #0 6:8 APIC version 17
> Processor #1 6:8 APIC version 17
> I/O APIC #2 Version 17 at 0xFEC00000.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Processors: 2
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=2.6.3-g-r1 ro root=2141
> Initializing CPU#0
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 801.861 MHz processor.
> Using tsc for high-res timesource
> Console: colour dummy device 80x25
> Memory: 1032812k/1048576k available (2183k kernel code, 14832k reserved, 725k data, 176k init, 131072k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 1585.15 BogoMIPS
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
> CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> CPU0: Intel Pentium III (Coppermine) stepping 03
> per-CPU timeslice cutoff: 732.15 usecs.
> task migration cache decay timeout: 1 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000004
> ESR value after enabling vector: 00000000
> Booting processor 1/1 eip 2000
> Unable to handle kernel paging request<1>Unable to handle kernel paging request at virtual address 3f83ec0d
>  printing eip:
> 3f83ec0d
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<3f83ec0d>]    Not tainted
> EFLAGS: 00010082
> EIP is at 0x3f83ec0d
> eax: c1b3c000   ebx: 00000000   ecx: 00000001   edx: 00100100
> esi: 00000000   edi: 00000026   ebp: 00000000   esp: c8008204
> ds: 007b   es: 007b   ss: 0068
> Process  (pid: 0, threadinfo=c8008000 task=3000801c)
> Stack: c027abeb c1b3c000 00000002 c03a0b80 c027e74b 00000000 00000000 00000000
>        00000000 00000000 00000000 00000000 c03a0b80 00000026 00000c1e 00000001
>        c012616f c03a0b80 c040c4be 00000026 00000c44 00000c44 00000c1e c012627f
> Call Trace:
>  [<c027abeb>] hide_cursor+0x2b/0x50
>  [<c027e74b>] vt_console_print+0x32b/0x350
>  [<c012616f>] __call_console_drivers+0x5f/0x70
>  [<c012627f>] call_console_drivers+0x6f/0x130
>  [<c0126632>] release_console_sem+0x62/0xf0
>  [<c0126532>] printk+0x182/0x1d0
>  [<c011d144>] do_page_fault+0x154/0x53a
>  [<c011cff0>] do_page_fault+0x0/0x53a
>  [<c010a1dd>] error_code+0x2d/0x38
>
> Code:  Bad EIP value.
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
>  Stuck ??
> CPU #1 not responding - cannot use it.
> Total of 1 processors activated (1585.15 BogoMIPS).
> -------------------------------------------------------
>
> I'm not sure quite why this is happening, but I suspect it's somehow related to my
> console framebuffer.
>
> After the system's been up for a while, dmesg has this:
>
> -------------------------------------------------------
> handlers:
> [<c0296510>] (ide_intr+0x0/0x1e0)
> Disabling IRQ #137
> APIC error on CPU0: 40(40)
> irq 137: nobody cared!
> Call Trace:
>  [<c010bc9a>] __report_bad_irq+0x2a/0x90
>  [<c010bd90>] note_interrupt+0x70/0xb0
>  [<c010c0e0>] do_IRQ+0x170/0x1b0
>  [<c0107030>] default_idle+0x0/0x40
>  [<c010a0e0>] common_interrupt+0x18/0x20
>  [<c0107030>] default_idle+0x0/0x40
>  [<c010705d>] default_idle+0x2d/0x40
>  [<c01070f6>] cpu_idle+0x46/0x50
>  [<c0105000>] _stext+0x0/0x70
>  [<c03da8f2>] start_kernel+0x172/0x190
>  [<c03da4a0>] unknown_bootoption+0x0/0x120
> -------------------------------------------------------
>
> Here's my .config for reference.
>
> -------------------------------------------------------
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
>
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> CONFIG_STANDALONE=y
>
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
>
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
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
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_HPET_TIMER=y
> # CONFIG_HPET_EMULATE_RTC is not set
> CONFIG_SMP=y
> CONFIG_NR_CPUS=2
> CONFIG_PREEMPT=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_TSC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=m
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=m
> CONFIG_EDD=m
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> CONFIG_X86_PAE=y
> # CONFIG_NUMA is not set
> CONFIG_HIGHPTE=y
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> CONFIG_HAVE_DEC_LOCK=y
>
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_PM_DISK=y
> CONFIG_PM_DISK_PARTITION="/dev/hda1"
>
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SLEEP_PROC_FS=y
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_RELAXED_AML is not set
>
> #
> # APM (Advanced Power Management) BIOS Support
> #
> CONFIG_APM=m
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> CONFIG_APM_REAL_MODE_POWER_OFF=y
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_PROC_INTF=m
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> CONFIG_CPU_FREQ_GOV_USERSPACE=m
> CONFIG_CPU_FREQ_24_API=y
> CONFIG_CPU_FREQ_TABLE=m
>
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_ACPI_CPUFREQ=m
> CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_SPEEDSTEP_ICH is not set
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
>
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_USE_VECTOR=y
> CONFIG_PCI_LEGACY_PROC=y
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> CONFIG_HOTPLUG=y
>
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
> CONFIG_PCMCIA_PROBE=y
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
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_MISC=m
>
> #
> # Device Drivers
> #
>
> #
> # Generic Driver Options
> #
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
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> CONFIG_PARPORT_SERIAL=m
> CONFIG_PARPORT_PC_FIFO=y
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_OTHER=y
> CONFIG_PARPORT_1284=y
>
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> # CONFIG_PNP_DEBUG is not set
>
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y
> CONFIG_PNPBIOS_PROC_FS=y
>
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=m
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_CRYPTOLOOP=m
> CONFIG_BLK_DEV_COMPRESSLOOP=m
> CONFIG_BLK_DEV_NBD=m
> CONFIG_BLK_DEV_RAM=m
> CONFIG_BLK_DEV_RAM_SIZE=4096
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_LBD is not set
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
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_IDEDISK_STROKE=y
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_IDE_TASK_IOCTL=y
> CONFIG_IDE_TASKFILE_IO=y
>
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=m
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> CONFIG_BLK_DEV_PDC202XX_NEW=y
> CONFIG_PDC202XX_FORCE=y
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_HD is not set
>
> #
> # SCSI device support
> #
> CONFIG_SCSI=m
> CONFIG_SCSI_PROC_FS=y
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=m
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=m
>
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_REPORT_LUNS=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
>
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INIA100 is not set
> CONFIG_SCSI_PPA=m
> CONFIG_SCSI_IMM=m
> # CONFIG_SCSI_IZIP_EPP16 is not set
> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> # CONFIG_SCSI_NCR53C406A is not set
> CONFIG_SCSI_SYM53C8XX_2=m
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=m
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> # CONFIG_SCSI_QLA2300 is not set
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA6322 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID5=m
> CONFIG_MD_RAID6=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_BLK_DEV_DM=m
> CONFIG_DM_IOCTL_V4=y
>
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
>
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
>
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
>
> #
> # Macintosh device drivers
> #
>
> #
> # Networking support
> #
> CONFIG_NET=y
>
> #
> # Networking options
> #
> CONFIG_PACKET=m
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=m
> CONFIG_UNIX=m
> CONFIG_NET_KEY=m
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> CONFIG_INET_IPCOMP=m
> CONFIG_IPV6=m
> CONFIG_IPV6_PRIVACY=y
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_IPV6_TUNNEL=m
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_NETFILTER is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_USER=m
>
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=m
> CONFIG_IP_SCTP=m
> # CONFIG_SCTP_DBG_MSG is not set
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_HMAC_NONE is not set
> CONFIG_SCTP_HMAC_SHA1=y
> # CONFIG_SCTP_HMAC_MD5 is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> CONFIG_LLC=m
> # CONFIG_LLC2 is not set
> CONFIG_IPX=m
> CONFIG_IPX_INTERN=y
> CONFIG_ATALK=m
> CONFIG_DEV_APPLETALK=y
> # CONFIG_LTPC is not set
> # CONFIG_COPS is not set
> CONFIG_IPDDP=m
> CONFIG_IPDDP_ENCAP=y
> CONFIG_IPDDP_DECAP=y
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=y
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_CSZ=m
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> CONFIG_NET_QOS=y
> CONFIG_NET_ESTIMATOR=y
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> CONFIG_NET_CLS_POLICE=y
>
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=m
> CONFIG_NETDEVICES=y
>
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=m
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> CONFIG_ETHERTAP=m
> # CONFIG_NET_SB1000 is not set
>
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=m
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
>
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_DGRS is not set
> CONFIG_EEPRO100=m
> # CONFIG_EEPRO100_PIO is not set
> CONFIG_E100=m
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=m
> # CONFIG_8139TOO_PIO is not set
> CONFIG_8139TOO_TUNE_TWISTER=y
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_8139_RXBUF_IDX=2
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_NET_POCKET is not set
>
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SIS190 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_NET_BROADCOM is not set
>
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PLIP=m
> CONFIG_PPP=m
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPPOE=m
> CONFIG_SLIP=m
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> CONFIG_SLIP_MODE_SLIP6=y
>
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> CONFIG_SHAPER=m
>
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>
> #
> # Amateur Radio support
> #
> CONFIG_HAMRADIO=y
>
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=m
> # CONFIG_AX25_DAMA_SLAVE is not set
> CONFIG_NETROM=m
> CONFIG_ROSE=m
>
> #
> # AX.25 network device drivers
> #
> # CONFIG_BPQETHER is not set
> # CONFIG_SCC is not set
> # CONFIG_BAYCOM_SER_FDX is not set
> # CONFIG_BAYCOM_SER_HDX is not set
> # CONFIG_BAYCOM_PAR is not set
> # CONFIG_BAYCOM_EPP is not set
> # CONFIG_YAM is not set
>
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
>
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
>
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
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
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=m
> CONFIG_INPUT_EVBUG=m
>
> #
> # Input I/O drivers
>
> CONFIG_GAMEPORT=m
> CONFIG_SOUND_GAMEPORT=m
> CONFIG_GAMEPORT_NS558=m
> # CONFIG_GAMEPORT_L4 is not set
> CONFIG_GAMEPORT_EMU10K1=m
> # CONFIG_GAMEPORT_VORTEX is not set
> # CONFIG_GAMEPORT_FM801 is not set
> # CONFIG_GAMEPORT_CS461x is not set
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=m
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> CONFIG_SERIO_PCIPS2=m
>
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> CONFIG_KEYBOARD_XTKBD=m
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=m
> CONFIG_MOUSE_SERIAL=m
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> CONFIG_INPUT_JOYSTICK=y
> CONFIG_JOYSTICK_ANALOG=m
> # CONFIG_JOYSTICK_A3D is not set
> # CONFIG_JOYSTICK_ADI is not set
> # CONFIG_JOYSTICK_COBRA is not set
> # CONFIG_JOYSTICK_GF2K is not set
> # CONFIG_JOYSTICK_GRIP is not set
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> # CONFIG_JOYSTICK_INTERACT is not set
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> # CONFIG_JOYSTICK_TMDC is not set
> # CONFIG_JOYSTICK_IFORCE is not set
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> # CONFIG_JOYSTICK_SPACEORB is not set
> # CONFIG_JOYSTICK_SPACEBALL is not set
> # CONFIG_JOYSTICK_STINGER is not set
> # CONFIG_JOYSTICK_TWIDDLER is not set
> CONFIG_JOYSTICK_DB9=m
> CONFIG_JOYSTICK_GAMECON=m
> CONFIG_JOYSTICK_TURBOGRAFX=m
> CONFIG_INPUT_JOYDUMP=m
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=m
> CONFIG_INPUT_UINPUT=m
>
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=m
> CONFIG_SERIAL_8250_ACPI=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_MULTIPORT=y
> # CONFIG_SERIAL_8250_RSA is not set
>
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=m
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=m
> CONFIG_TIPAR=m
>
> #
> # Linux InfraRed Controller
> #
> # CONFIG_LIRC_SUPPORT is not set
>
> #
> # Mice
> #
> CONFIG_BUSMOUSE=m
> # CONFIG_QIC02_TAPE is not set
>
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=y
> # CONFIG_WATCHDOG_NOWAYOUT is not set
>
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=m
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_AMD7XX_TCO is not set
> # CONFIG_SC520_WDT is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I8XX_TCO is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_SCx200_WDT is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
>
> #
> # ISA-based Watchdog Cards
> #
> # CONFIG_PCWATCHDOG is not set
> # CONFIG_MIXCOMWD is not set
> # CONFIG_WDT is not set
>
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
> # CONFIG_HW_RANDOM is not set
> CONFIG_NVRAM=m
> CONFIG_RTC=m
> CONFIG_GEN_RTC=m
> CONFIG_GEN_RTC_X=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> CONFIG_AGP=m
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=m
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=m
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_HANGCHECK_TIMER=m
>
> #
> # I2C support
> #
> CONFIG_I2C=m
> CONFIG_I2C_CHARDEV=m
>
> #
> # I2C Algorithms
> #
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
>
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_ELV is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_ISA is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_PHILIPSPAR is not set
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> CONFIG_I2C_PIIX4=m
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_SCx200_ACB is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VELLEMAN is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_VOODOO3 is not set
>
> #
> # I2C Hardware Sensors Chip support
> #
> # CONFIG_I2C_SENSOR is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
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
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=m
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_RIVA=m
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
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
>
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
>
> #
> # Bootsplash configuration
> #
> CONFIG_BOOTSPLASH=y
>
> #
> # Speakup console speech
> #
> CONFIG_SPEAKUP=m
> # CONFIG_SPEAKUP_ACNTSA is not set
> # CONFIG_SPEAKUP_ACNTPC is not set
> # CONFIG_SPEAKUP_APOLLO is not set
> # CONFIG_SPEAKUP_AUDPTR is not set
> # CONFIG_SPEAKUP_BNS is not set
> # CONFIG_SPEAKUP_DECTLK is not set
> # CONFIG_SPEAKUP_DECEXT is not set
> # CONFIG_SPEAKUP_DECPC is not set
> # CONFIG_SPEAKUP_DTLK is not set
> # CONFIG_SPEAKUP_KEYPC is not set
> # CONFIG_SPEAKUP_LTLK is not set
> CONFIG_SPEAKUP_SFTSYN=m
> # CONFIG_SPEAKUP_SPKOUT is not set
> # CONFIG_SPEAKUP_TXPRT is not set
>
> #
> # Enter the 3 to 6 character keyword from the list above, or none for no default synthesizer on boot up.
> #
> CONFIG_SPEAKUP_DEFAULT="sftsyn"
>
> #
> # Sound
> #
> CONFIG_SOUND=m
>
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=m
> CONFIG_SND_SEQUENCER=m
> CONFIG_SND_SEQ_DUMMY=m
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_RTCTIMER=m
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
>
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>
> #
> # ISA devices
> #
> # CONFIG_SND_AD1816A is not set
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> # CONFIG_SND_ES968 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_ALS100 is not set
> # CONFIG_SND_AZT2320 is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_DT019X is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> # CONFIG_SND_SSCAPE is not set
>
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> CONFIG_SND_EMU10K1=m
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
>
> #
> # ALSA USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
>
> #
> # Open Sound System
> #
> CONFIG_SOUND_PRIME=m
> # CONFIG_SOUND_BT878 is not set
> # CONFIG_SOUND_CMPCI is not set
> CONFIG_SOUND_EMU10K1=m
> CONFIG_MIDI_EMU10K1=y
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> # CONFIG_SOUND_OSS is not set
> # CONFIG_SOUND_TVMIXER is not set
> # CONFIG_SOUND_ALI5455 is not set
> # CONFIG_SOUND_FORTE is not set
> # CONFIG_SOUND_RME96XX is not set
> # CONFIG_SOUND_AD1980 is not set
>
> #
> # USB support
> #
> CONFIG_USB=m
> # CONFIG_USB_DEBUG is not set
>
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> CONFIG_USB_DYNAMIC_MINORS=y
>
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_EHCI_HCD is not set
> # CONFIG_USB_OHCI_HCD is not set
> CONFIG_USB_UHCI_HCD=m
>
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_MIDI is not set
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_STORAGE is not set
>
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> # CONFIG_HID_FF is not set
> CONFIG_USB_HIDDEV=y
>
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_XPAD is not set
>
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
>
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
>
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
>
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
>
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
>
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
>
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_BRLVGER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_TEST is not set
>
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
>
> #
> # File systems
> #
> CONFIG_EXT2_FS=m
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT2_FS_SECURITY=y
> CONFIG_EXT3_FS=m
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_SECURITY=y
> CONFIG_JBD=m
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=m
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> # CONFIG_JFS_DEBUG is not set
> CONFIG_JFS_STATISTICS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=y
> CONFIG_XFS_RT=y
> CONFIG_XFS_QUOTA=y
> # CONFIG_XFS_SECURITY is not set
> CONFIG_XFS_POSIX_ACL=y
> CONFIG_MINIX_FS=m
> CONFIG_ROMFS_FS=m
> CONFIG_QUOTA=y
> CONFIG_QFMT_V1=m
> CONFIG_QFMT_V2=m
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=m
> CONFIG_AUTOFS4_FS=m
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=m
> CONFIG_UDF_FS=m
>
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> CONFIG_DEVPTS_FS_XATTR=y
> CONFIG_DEVPTS_FS_SECURITY=y
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_RAMFS=y
> CONFIG_SUPERMOUNT=m
> # CONFIG_SUPERMOUNT_DEBUG is not set
>
> #
> # Miscellaneous filesystems
> #
> CONFIG_ADFS_FS=m
> # CONFIG_ADFS_FS_RW is not set
> CONFIG_AFFS_FS=m
> CONFIG_HFS_FS=m
> CONFIG_BEFS_FS=m
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=m
> CONFIG_EFS_FS=m
> CONFIG_CRAMFS=m
> # CONFIG_SQUASHFS is not set
> CONFIG_VXFS_FS=m
> CONFIG_HPFS_FS=m
> CONFIG_QNX4FS_FS=m
> # CONFIG_QNX4FS_RW is not set
> CONFIG_SYSV_FS=m
> CONFIG_UFS_FS=m
> # CONFIG_UFS_FS_WRITE is not set
>
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_DIRECTIO=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_RPCSEC_GSS_KRB5=m
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_CIFS=m
> CONFIG_NCP_FS=m
> CONFIG_NCPFS_PACKET_SIGNING=y
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> CONFIG_NCPFS_STRONG=y
> CONFIG_NCPFS_NFS_NS=y
> CONFIG_NCPFS_OS2_NS=y
> CONFIG_NCPFS_SMALLDOS=y
> CONFIG_NCPFS_NLS=y
> CONFIG_NCPFS_EXTRAS=y
> CONFIG_CODA_FS=m
> # CONFIG_CODA_FS_OLD_API is not set
> CONFIG_INTERMEZZO_FS=m
> CONFIG_AFS_FS=m
> CONFIG_RXRPC=m
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
> CONFIG_NLS_CODEPAGE_437=m
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
> CONFIG_NLS_ISO8859_1=m
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
> CONFIG_NLS_UTF8=m
>
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
>
> #
> # Kernel hacking
> #
> # CONFIG_DEBUG_KERNEL is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_FRAME_POINTER is not set
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
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_AES=m
> CONFIG_CRYPTO_CAST5=m
> CONFIG_CRYPTO_CAST6=m
> CONFIG_CRYPTO_DEFLATE=m
> # CONFIG_CRYPTO_UCL is not set
> CONFIG_CRYPTO_TEST=m
>
> #
> # Library routines
> #
> CONFIG_CRC32=y
> CONFIG_ZLIB_INFLATE=m
> CONFIG_ZLIB_DEFLATE=m
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


-Phil/CERisE
