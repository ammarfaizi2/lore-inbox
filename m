Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQLELfY>; Tue, 5 Dec 2000 06:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbQLELfN>; Tue, 5 Dec 2000 06:35:13 -0500
Received: from comunit.de ([195.21.213.33]:56884 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S129828AbQLELfE>;
	Tue, 5 Dec 2000 06:35:04 -0500
Date: Tue, 5 Dec 2000 12:04:31 +0100 (CET)
From: Falk Stern <falk@comunit.de>
To: linux-kernel@vger.kernel.org
Subject: APIC Errors with 2.4.0-test11-pre7
Message-ID: <Pine.LNX.4.21.0012051155500.5291-100000@tyr.valhalla.ccc>
X-Arschkarte: gezogen
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there. 

I have a Dual Pentium-233MMX Machine, which throws lots of Errors like
this one: 

Dec  5 10:56:04 tyr kernel: APIC error on CPU0: 02(00)
Dec  5 10:56:20 tyr kernel: APIC error on CPU0: 04(00)

The Machine has a Gigabyte 586DX Board with onboard SCSI (AIC7xxx),
ISA 3c509 Network Card, Soundblaster AWE64 (also ISA) and an old Tseng
ET4000W32 graphics card. 

I am not a Kernel Developer, neither do I have good knowledge of C, so I
don't know where to search for the Problem. 

Thanks in Advance.

so far

Falk


/proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-32160W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DCAS-32160W      Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CDR100           Rev: 1.10
  Type:   WORM                             ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:465 Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02


dmesg output after boot:
Inspecting /boot/System.map
Loaded 13637 symbols from /boot/System.map.
Symbols match kernel version 2.4.0.
Loaded 74 symbols from 3 modules.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.4.0-test11-pre7-rfs (root@tyr) (gcc version 2.95.2 19991024 (release)) #2 SMP Thu Nov 30 10:49:07 CET 2000
<4>BIOS-provided physical RAM map:
<4> BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
<4> BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
<4> BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
<4> BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
<4> BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
<4> BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
<4> BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
<4>Scan SMP from c0000000 for 1024 bytes.
<4>Scan SMP from c009fc00 for 1024 bytes.
<4>Scan SMP from c00f0000 for 65536 bytes.
<4>found SMP MP-table at 000f5a10
<4>hm, page 000f5000 reserved twice.
<4>hm, page 000f6000 reserved twice.
<4>hm, page 000f5000 reserved twice.
<4>hm, page 000f6000 reserved twice.
<4>On node 0 totalpages: 32768
<4>zone(0): 4096 pages.
<4>zone(1): 28672 pages.
<4>zone(2): 0 pages.
<4>Intel MultiProcessor Specification v1.1
<4>    Virtual Wire compatibility mode.
<4>OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
<4>Processor #0 Pentium(tm) APIC version 17
<4>    Floating point unit present.
<4>    Machine Exception supported.
<4>    64 bit compare & exchange supported.
<4>    Internal APIC present.
<4>    Bootup CPU
<4>Processor #1 Pentium(tm) APIC version 17
<4>    Floating point unit present.
<4>    Machine Exception supported.
<4>    64 bit compare & exchange supported.
<4>    Internal APIC present.
<4>Bus #0 is PCI   
<4>Bus #1 is ISA   
<4>I/O APIC #2 Version 17 at 0xFEC00000.
<4>Int: type 3, pol 0, trig 0, bus 1, IRQ 00, APIC ID 2, APIC INT 00
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 01, APIC ID 2, APIC INT 01
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 00, APIC ID 2, APIC INT 02
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 03, APIC ID 2, APIC INT 03
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 04, APIC ID 2, APIC INT 04
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 05, APIC ID 2, APIC INT 05
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 06, APIC ID 2, APIC INT 06
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 07, APIC ID 2, APIC INT 07
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 08, APIC ID 2, APIC INT 08
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 09, APIC ID 2, APIC INT 09
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 0a, APIC ID 2, APIC INT 0a
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 0b, APIC ID 2, APIC INT 0b
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 0c, APIC ID 2, APIC INT 0c
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 0d, APIC ID 2, APIC INT 0d
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 0e, APIC ID 2, APIC INT 0e
<4>Int: type 0, pol 0, trig 0, bus 1, IRQ 0f, APIC ID 2, APIC INT 0f
<4>Int: type 0, pol 3, trig 3, bus 0, IRQ 20, APIC ID 2, APIC INT 10
<4>Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID 2, APIC INT 11
<4>Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
<4>Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 13
<4>Int: type 2, pol 0, trig 0, bus 1, IRQ 00, APIC ID 2, APIC INT 17
<4>Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
<4>Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
<4>Processors: 2
<4>mapped APIC to ffffe000 (fee00000)
<4>mapped IOAPIC to ffffd000 (fec00000)
<4>Kernel command line: BOOT_IMAGE=linux24 ro root=803 idebus=33
<4>Initializing CPU#0
<4>Detected 233.868 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 466.94 BogoMIPS
<4>Memory: 126512k/131072k available (1445k kernel code, 4172k reserved, 73k data, 172k init, 0k highmem)
<4>Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
<4>Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
<4>CPU: Before vendor init, caps: 008003bf 00000000 00000000, vendor = 0
<6>Intel Pentium with F0 0F bug - workaround enabled.
<4>CPU: After vendor init, caps: 008003bf 00000000 00000000 00000000
<4>CPU: After generic, caps: 008003bf 00000000 00000000 00000000
<4>CPU: Common caps: 008003bf 00000000 00000000 00000000
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>CPU: Before vendor init, caps: 008003bf 00000000 00000000, vendor = 0
<4>CPU: After vendor init, caps: 008003bf 00000000 00000000 00000000
<4>CPU: After generic, caps: 008003bf 00000000 00000000 00000000
<4>CPU: Common caps: 008003bf 00000000 00000000 00000000
<4>CPU0: Intel Pentium MMX stepping 03
<4>per-CPU timeslice cutoff: 160.32 usecs.
<4>Getting VERSION: 30010
<4>Getting VERSION: 30010
<4>Getting ID: 0
<4>Getting ID: f000000
<4>Getting LVT0: 700
<4>Getting LVT1: 400
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>CPU present map: 3
<4>Booting processor 1/1 eip 2000
<4>Setting warm reset code and vector.
<4>1.
<4>2.
<4>3.
<4>Asserting INIT.
<4>Waiting for send to finish...
<4>+Deasserting INIT.
<4>Waiting for send to finish...
<4>+#startup loops: 2.
<4>Sending STARTUP #1.
<4>After apic_write.
<4>Startup point 1.
<4>Waiting for send to finish...
<4>Initializing CPU#1
<4>+CPU#1 (phys ID: 1) waiting for CALLOUT
<4>Sending STARTUP #2.
<4>After apic_write.
<4>Startup point 1.
<4>Waiting for send to finish...
<4>+After Startup.
<4>Before Callout 1.
<4>CALLIN, before setup_local_APIC().
<4>After Callout 1.
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 466.94 BogoMIPS
<4>Stack at about c1237fbc
<4>CPU: Before vendor init, caps: 008003bf 00000000 00000000, vendor = 0
<4>CPU: After vendor init, caps: 008003bf 00000000 00000000 00000000
<4>CPU: After generic, caps: 008003bf 00000000 00000000 00000000
<4>CPU: Common caps: 008003bf 00000000 00000000 00000000
<4>OK.
<4>CPU1: Intel Pentium MMX stepping 03
<4>CPU has booted.
<4>Before bogomips.
<6>Total of 2 processors activated (933.89 BogoMIPS).
<4>Before bogocount - setting activated=1.
<4>Boot done.
<4>ENABLING IO-APIC IRQs
<6>...changing IO-APIC physical APIC ID to 2 ... ok.
<4>Synchronizing Arb IDs.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
<6>..TIMER: vector=49 pin1=2 pin2=0
<6>activating NMI Watchdog ... done.
<7>number of MP IRQ sources: 21.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.... register #01: 00170011
<7>.......     : max redirection entries: 0017
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 003 03  0    0    0   0   0    1    1    39
<7> 02 003 03  0    0    0   0   0    1    1    31
<7> 03 003 03  0    0    0   0   0    1    1    41
<7> 04 003 03  0    0    0   0   0    1    1    49
<7> 05 003 03  0    0    0   0   0    1    1    51
<7> 06 003 03  0    0    0   0   0    1    1    59
<7> 07 003 03  0    0    0   0   0    1    1    61
<7> 08 003 03  0    0    0   0   0    1    1    69
<7> 09 003 03  0    0    0   0   0    1    1    71
<7> 0a 003 03  0    0    0   0   0    1    1    79
<7> 0b 003 03  0    0    0   0   0    1    1    81
<7> 0c 003 03  0    0    0   0   0    1    1    89
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 003 03  0    0    0   0   0    1    1    91
<7> 0f 003 03  0    0    0   0   0    1    1    99
<7> 10 003 03  1    1    0   1   0    1    1    A1
<7> 11 003 03  1    1    0   1   0    1    1    A9
<7> 12 003 03  1    1    0   1   0    1    1    B1
<7> 13 003 03  1    1    0   1   0    1    1    B9
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 2
<7>IRQ1 -> 1
<7>IRQ3 -> 3
<7>IRQ4 -> 4
<7>IRQ5 -> 5
<7>IRQ6 -> 6
<7>IRQ7 -> 7
<7>IRQ8 -> 8
<7>IRQ9 -> 9
<7>IRQ10 -> 10
<7>IRQ11 -> 11
<7>IRQ12 -> 12
<7>IRQ13 -> 13
<7>IRQ14 -> 14
<7>IRQ15 -> 15
<7>IRQ16 -> 16
<7>IRQ17 -> 17
<7>IRQ18 -> 18
<7>IRQ19 -> 19
<6>.................................... done.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 233.8670 MHz.
<4>..... host bus clock speed is 66.8187 MHz.
<4>cpu: 0, clocks: 668187, slice: 222729
<4>CPU0<T0:668176,T1:445440,D:7,S:222729,C:668187>
<4>cpu: 1, clocks: 668187, slice: 222729
<4>CPU1<T0:668176,T1:222704,D:14,S:222729,C:668187>
<4>checking TSC synchronization across CPUs: passed.
<4>Setting commenced=1, go go go
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=0
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<4>PCI->APIC IRQ transform: (B0,I9,P0) -> 17
<4>PCI->APIC IRQ transform: (B0,I12,P0) -> 19
<6>Limiting direct PCI/PCI transfers.
<6>Activating ISA DMA hang workarounds.
<4>isapnp: Scanning for Pnp cards...
<7>isapnp: Calling quirk for 01:00
<6>ISAPnP: SB audio device quirk - increasing port range
<7>isapnp: Calling quirk for 01:02
<6>isapnp: AWE32 quirk - adding two ports
<4>isapnp: Card 'Creative SB AWE64  PnP'
<4>isapnp: Card '3Com 3C509B EtherLink III'
<4>isapnp: 2 Plug & Play cards detected total
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Starting kswapd v1.8
<4>pty: 256 Unix98 ptys configured
<6>SCSI subsystem driver Revision: 1.00
<6>(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 0/12/0
<6>(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
<6>(scsi0) Downloading sequencer code... 422 instructions downloaded
<6>scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
<4>       <Adaptec AIC-7880 Ultra SCSI host adapter>
<6>(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
<4>  Vendor: IBM       Model: DCAS-32160W       Rev: S65A
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<6>(scsi0:0:3:0) Synchronous at 40.0 Mbyte/sec, offset 8.
<4>  Vendor: IBM       Model: DCAS-32160W       Rev: S65A
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: YAMAHA    Model: CDR100            Rev: 1.10
<4>  Type:   WORM                               ANSI SCSI revision: 02
<6>(scsi0:0:6:0) Synchronous at 20.0 Mbyte/sec, offset 15.
<4>  Vendor: NEC       Model: CD-ROM DRIVE:465  Rev: 1.03
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
<4>SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3
<4>SCSI device sdb: 4226725 512-byte hdwr sectors (2164 MB)
<6> sdb: sdb1
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 1024 buckets, 8Kbytes
<4>TCP: Hash tables configured (established 8192 bind 8192)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<3>kmem_create: Forcing size word alignment - nfs_fh
<4>reiserfs: checking transaction log (device 08:03) ...
<4>Using tea hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.18
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<4>Freeing unused kernel memory: 172k freed
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PIIX3: IDE controller on PCI bus 00 dev 39
<4>PIIX3: chipset revision 0
<4>PIIX3: not 100% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
<4>hda: IBM-DHEA-38451, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<6>hda: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=16383/16/63, (U)DMA
<6> hda: hda1 hda4
<6>Adding Swap: 64256k swap-space (priority -1)
<3>APIC error on CPU0: 02(00)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Kernel config (2.4.0-test11-pre7 with Reiserfs patch):
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
# CONFIG_M686 is not set
# CONFIG_M686FXSR is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
CONFIG_ATALK=m
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=m

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=5
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
# CONFIG_VORTEX is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
# CONFIG_NCPFS_NDS_DOMAINS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
