Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWHZXSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWHZXSS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 19:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWHZXSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 19:18:18 -0400
Received: from vscan05.westnet.com.au ([203.10.1.139]:4574 "EHLO
	vscan05.westnet.com.au") by vger.kernel.org with ESMTP
	id S1751241AbWHZXSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 19:18:17 -0400
Message-ID: <44F0D6B2.9070201@westnet.com.au>
Date: Sun, 27 Aug 2006 09:18:10 +1000
From: Noel <ressy@westnet.com.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Seg Fault loading 2.4.33.2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System does not boot with latest 2.4.33.2 kernel

The same kernel options ( a cp .config ) from 2.4.32 to new kernel 
2.4.33.2 tree
make menuconfig and saved (no changes made)

This is Slackware 10.2

all makes and installs succeed without a glitch

ver_linux output:
Linux valhalla 2.4.32.s #2 SMP Fri Jun 16 17:58:07 EST 2006 i686 unknown 
unknown GNU/Linux
 
Gnu C                  3.3.6
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
modutils               2.4.27
e2fsprogs              1.38
jfsutils               1.1.8
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.12.
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ipt_state ip_conntrack ipt_REJECT iptable_mangle 
iptable_filter ip_tables i810_rng pcmcia_core ide-scsi agpgart


# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2593.521
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5177.34

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2593.521
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5177.34

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1056575488 417181696 639393792        0  5332992 75481088
Swap: 954122240        0 954122240




# capture file:
                                                                                

>
> LILO 22.7.1
>
> Welcome to the LILO Boot Loader!
>
> Please enter the name of the partition you would like to boot
>
> at the prompt below.  The choices are:
>
> Linux    -  (Linux partition)
>
> boot:
>
> Loading Linux........................
>
> BIOS data check successful
>
> Linux version 2.4.33.2 (root@valhalla) (gcc version 3.3.6) #2 SMP Sun 
> Aug 27 07:56:31 EST 2006
>
> BIOS-provided physical RAM map:
>
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>
> BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
>
> BIOS-e820: 0000000000100000 - 000000003fe30000 (usable)
>
> BIOS-e820: 000000003fe30000 - 000000003fe3e05e (ACPI NVS)
>
> BIOS-e820: 000000003fe3e05e - 000000003ff30000 (usable)
>
> BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
>
> BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
>
> BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
>
> BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
>
> BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
>
> 127MB HIGHMEM available.
>
> 896MB LOWMEM available.
>
> found SMP MP-table at 000ff780
>
> hm, page 000ff000 reserved twice.
>
> hm, page 00100000 reserved twice.
>
> hm, page 000fc000 reserved twice.
>
> hm, page 000fd000 reserved twice.
>
> On node 0 totalpages: 261936
>
> zone(0): 4096 pages.
>
> zone(1): 225280 pages.
>
> zone(2): 32560 pages.
>
> ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f63b0
>
> ACPI: RSDT (v001 INTEL  D865PERL 0x20040122 MSFT 0x00000097) @ 0x3ff30000
>
> ACPI: FADT (v002 INTEL  D865PERL 0x20040122 MSFT 0x00000097) @ 0x3ff30200
>
> ACPI: MADT (v001 INTEL  D865PERL 0x20040122 MSFT 0x00000097) @ 0x3ff30300
>
> ACPI: ASF! (v016 LEGEND I865PASF 0x00000001 MSFT 0x0100000d) @ 0x3ff344e0
>
> ACPI: WDDT (v001 INTEL  OEMWDDT  0x00000001 MSFT 0x0100000d) @ 0x3ff34579
>
> ACPI: DSDT (v001 INTEL  D865PERL 0x00000006 MSFT 0x0100000d) @ 0x00000000
>
> ACPI: Local APIC address 0xfee00000
>
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
>
> Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
>
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
>
> Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
>
> ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
>
> ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
>
> Using ACPI for processor (LAPIC) configuration information
>
> Intel MultiProcessor Specification v1.4
>
>    Virtual Wire compatibility mode.
>
> OEM ID:  Product ID: Springdale-G APIC at: 0xFEE00000
>
> I/O APIC #2 Version 32 at 0xFEC00000.
>
> Enabling APIC mode: Flat. Using 1 I/O APICs
>
> Processors: 2
>
> Kernel command line: auto BOOT_IMAGE=Linux ro root=301 apm=power-off 
> console=ttyS0,9600n8
>
> Initializing CPU#0
>
> Detected 2593.562 MHz processor.
>
> Console: colour VGA+ 80x25
>
> Calibrating delay loop... 5177.34 BogoMIPS
>
> Memory: 1031640k/1047744k available (1812k kernel code, 15656k 
> reserved, 682k data, 172k init, 130180k highmem)
>
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
>
> Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
>
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
>
> Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
>
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
>
> CPU: Trace cache: 12K uops, L1 D cache: 8K
>
> CPU: L2 cache: 512K
>
> CPU: Physical Processor ID: 0
>
> Intel machine check architecture supported.
>
> Intel machine check reporting enabled on CPU#0.
>
> Enabling fast FPU save and restore... done.
>
> Enabling unmasked SIMD FPU exception support... done.
>
> Checking 'hlt' instruction... OK.
>
> POSIX conformance testing by UNIFIX
>
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
>
> mtrr: detected mtrr type: Intel
>
> CPU: Trace cache: 12K uops, L1 D cache: 8K
>
> CPU: L2 cache: 512K
>
> CPU: Physical Processor ID: 0
>
> Intel machine check reporting enabled on CPU#0.
>
> CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
>
> per-CPU timeslice cutoff: 1462.72 usecs.
>
> enabled ExtINT on CPU#0
>
> ESR value before enabling vector: 00000000
>
> ESR value after enabling vector: 00000000
>
> Booting processor 1/1 eip 2000
>
> Initializing CPU#1
>
> masked ExtINT on CPU#1
>
> ESR value before enabling vector: 00000000
>
> ESR value after enabling vector: 00000000
>
> Calibrating delay loop... 5177.34 BogoMIPS
>
> CPU: Trace cache: 12K uops, L1 D cache: 8K
>
> CPU: L2 cache: 512K
>
> CPU: Physical Processor ID: 0
>
> Intel machine check reporting enabled on CPU#1.
>
> CPU1: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
>
> Total of 2 processors activated (10354.68 BogoMIPS).
>
> cpu_sibling_map[0] = 1
>
> cpu_sibling_map[1] = 0
>
> ENABLING IO-APIC IRQs
>
> Setting 2 in the phys_id_present_map
>
> ...changing IO-APIC physical APIC ID to 2 ... ok.
>
> ..TIMER: vector=0x31 pin1=2 pin2=0
>
> testing the IO APIC.......................
>
> .................................... done.
>
> Using local APIC timer interrupts.
>
> calibrating APIC timer ...
>
> ..... CPU clock speed is 2593.4920 MHz.
>
> ..... host bus clock speed is 199.4992 MHz.
>
> cpu: 0, clocks: 1994992, slice: 664997
>
> CPU0<T0:1994992,T1:1329984,D:11,S:664997,C:1994992>
>
> cpu: 1, clocks: 1994992, slice: 664997
>
> CPU1<T0:1994992,T1:664992,D:6,S:664997,C:1994992>
>
> checking TSC synchronization across CPUs: passed.
>
> Waiting on wait_init_idle (map = 0x2)
>
> All processors have done init_idle
>
> PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
>
> PCI: Using configuration type 1
>
> PCI: Probing PCI hardware
>
> PCI: Probing PCI hardware (bus 00)
>
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
>
> Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
>
> PCI: Using IRQ router PIIX/ICH [8086/24d0] at 00:1f.0
>
> PCI->APIC IRQ transform: (B0,I29,P0) -> 16
>
> PCI->APIC IRQ transform: (B0,I29,P1) -> 19
>
> PCI->APIC IRQ transform: (B0,I29,P2) -> 18
>
> PCI->APIC IRQ transform: (B0,I29,P0) -> 16
>
> PCI->APIC IRQ transform: (B0,I29,P3) -> 23
>
> PCI->APIC IRQ transform: (B0,I31,P0) -> 18
>
> PCI->APIC IRQ transform: (B0,I31,P0) -> 18
>
> PCI->APIC IRQ transform: (B0,I31,P1) -> 17
>
> PCI->APIC IRQ transform: (B0,I31,P1) -> 17
>
> PCI->APIC IRQ transform: (B2,I0,P0) -> 21
>
> PCI->APIC IRQ transform: (B2,I2,P0) -> 17
>
> isapnp: Scanning for PnP cards...
>
> isapnp: No Plug & Play device found
>
> Linux NET4.0 for Linux 2.4
>
> Based upon Swansea University Computer Society NET3.039
>
> Initializing RT netlink socket
>
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
>
> apm: disabled - APM is not SMP safe (power off active).
>
> Starting kswapd
>
> allocated 32 pages and 32 bhs reserved for the highmem bounces
>
> VFS: Disk quotas vdquot_6.5.1
>
> Journalled Block Device driver loaded
>
> Detected PS/2 Mouse Port.
>
> pty: 2048 Unix98 ptys configured
>
> keyboard: Timeout - AT keyboard not present?(ed)
>
> keyboard: Timeout - AT keyboard not present?(f4)
>
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
> SHARE_IRQ SERIAL_PCI ISAPNP enabled
>
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
>
> Real Time Clock Driver v1.10f
>
> Floppy drive(s): fd0 is 1.44M
>
> FDC 0 is a post-1991 82077
>
> NET4: Frame Diverter 0.46
>
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>
> Intel(R) PRO/100 Network Driver - version 2.3.43-k1
>
> Copyright (c) 2004 Intel Corporation
>
> e100: eth0: Intel(R) PRO/100 Network Connection
>
>  Hardware receive checksums enabled
>
>  cpu cycle saver enabled
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
>
> ICH5: IDE controller at PCI slot 00:1f.1
>
> PCI: Enabling device 00:1f.1 (0005 -> 0007)
>
> ICH5: chipset revision 2
>
> ICH5: not 100% native mode: will probe irqs later
>
>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
>
>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
>
> hda: Maxtor 6Y080L0, ATA DISK drive
>
> hdb: ST3300622A, ATA DISK drive
>
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>
> hda: attached ide-disk driver.
>
> hda: host protected area => 1
>
> hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, 
> UDMA(33)
>
> hdb: attached ide-disk driver.
>
> hdb: host protected area => 1
>
> hdb: 586072368 sectors (300069 MB) w/16384KiB Cache, CHS=36481/255/63, 
> UDMA(33)
>
> Partition check:
>
> hda: [PTBL] [9964/255/63] hda1 hda2
>
> hdb: hdb1
>
> ide: late registration of driver.
>
> SCSI subsystem driver Revision: 1.00
>
> sym53c416.c: Version 1.0.0-ac
>
> DC390: 0 adapters found
>
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
>
> md: Autodetecting RAID arrays.
>
> md: autorun ...
>
> md: ... autorun DONE.
>
> NET4: Linux TCP/IP 1.0 for NET4.0
>
> IP Protocols: ICMP, UDP, TCP, IGMP
>
> IP: routing cache hash table of 8192 buckets, 64Kbytes
>
> TCP: Hash tables configured (established 262144 bind 65536)
>
> Linux IP multicast router 0.06 plus PIM-SM
>
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>
> VFS: Mounted root (ext2 filesystem) readonly.
>
> Freeing unused kernel memory: 172k freed
>
> INIT: version 2.84 booting
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 11:    17 Segmentation fault      /sbin/mount -v 
> proc /proc -n -t proc
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 36:    18 Segmentation fault      cat 
> /proc/filesystems
>
>        19                       | grep -w sysfs >/dev/null 2>/dev/null
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 46:    20 Segmentation fault      /sbin/swapon -a
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 55:    21 Segmentation fault      touch 
> /fsrwtestfile 2>/dev/null
>
> Testing root filesystem status:  read-only filesystem
>
> Checking root filesystem:
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    22 Segmentation fault      /sbin/fsck 
> $FORCEFSCK -C -a /
>
> ***********************************************************
>
> *** An error occurred during the root filesystem check. ***
>
> *** You will now be given a chance to log into the      ***
>
> *** system in single-user mode to fix the problem.      ***
>
> ***                                                     ***
>
> *** If you are using the ext2 filesystem, running       ***
>
> *** 'e2fsck -v -y <partition>' might help.              ***
>
> ***********************************************************
>
> Once you exit the single-user shell, the system will reboot.
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    23 Segmentation fault      sulogin
>
> Unmounting file systems.
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    24 Segmentation fault      /sbin/umount -a -r
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    25 Segmentation fault      /sbin/mount -n 
> -o remount,ro /
>
> Rebooting system.
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    26 Segmentation fault      sleep 2
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    27 Segmentation fault      reboot -f
>
> Remounting root device with read-write enabled.
>
> sh: ../nptl/sysdeps/unix/sysv/linux/fork.c:138: __libc_fork: Assertion 
> `({ __typeof (self->tid) __value; if (sizeof (__value) == 1) asm 
> volatile ("movb %%gs:%P2,%b0" : "=q" (__value) : "0" (0), "i" 
> (((size_t) &((struct pthread *)0)->tid))); else if (sizeof (__value) 
> == 4) asm volatile ("movl %%gs:%P1,%0" : "=r" (__value) : "i" 
> (((size_t) &((struct pthread *)0)->tid))); else { if (sizeof (__value) 
> != 8) abort (); asm volatile ("movl %%gs:%P1,%%eax\n\t" "movl 
> %%gs:%P2,%%edx" : "=A" (__value) : "i" (((size_t) &((struct pthread 
> *)0)->tid)), "i" (((size_t) &((struct pthread *)0)->tid) + 4)); } 
> __value; }) != ppid' failed.
>
> /etc/rc.d/rc.S: line 159:    28 Segmentation fault      /sbin/mount -w 
> -v -n -o remount /
>
> Attempt to remount root device as read-write failed!  This is going to
>
> cause serious problems.
>
> If you're using the UMSDOS filesystem, you **MUST** mount the root 
> partition
>
> read-write!  You can make sure the root filesystem is getting mounted
>
> read-write with the 'rw' flag to Loadlin:
>
> loadlin vmlinuz root=/dev/hda1 rw   (replace /dev/hda1 with your root 
> device)
>
> Normal bootdisks can be made to mount a system read-write with the 
> rdev command:
>
> rdev -R /dev/fd0 0
>
> You can also get into your system by using a boot disk with a command 
> like this
>
> on the LILO prompt line:  (change the root partition name as needed)
>
> LILO: mount root=/dev/hda1 rw
>
> Please press ENTER to continue, then reboot and use one of the above 
> methods to
>
> get into your
>

 
..at this time I power cycled and reloaded to kern 2.4.32 and it remains 
active

Hope you can offer some suggestions.

Thanks.
Res
