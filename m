Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280201AbRKEEoP>; Sun, 4 Nov 2001 23:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280199AbRKEEoG>; Sun, 4 Nov 2001 23:44:06 -0500
Received: from cogent.ecohler.net ([216.135.202.106]:41347 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S280201AbRKEEnx>; Sun, 4 Nov 2001 23:43:53 -0500
Date: Sun, 4 Nov 2001 23:43:50 -0500
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Subject: P4 xeon 2.4.13-ac5: WARNING: unexpected IO-APIC and Unknown CPU
Message-ID: <20011104234350.A28124@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23-current-20011027i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   2 x 1.7 Pentium 4 xeon machine - dell 530 - 1 Gb memory 
   dell branded ATI radeon video card, cd, cd-rw. 
   Redhat 7.2, with 2.4.13-ac5 (same message on RH stock 2.4.7-10 kernel0

   Complains on boot:

   WARNING: unexpected IO-APIC. 

   and it also says:

   Processor #0 Unknown CPU [15:1] APIC version 20
   Processor #1 Unknown CPU [15:1] APIC version 20

   Machine boots and seems to run fine.

   Provided below are /proc/cpuinfo, lspci and boot messages.

----------------------------------------------------------
   # cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.894
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm
bogomips	: 3381.65

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.894
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm
bogomips	: 3381.65

----------------------------------------------------------
   # lspci

00:00.0 Host bridge: Intel Corporation 82850 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)
00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge (rev 04)
00:02.0 PCI bridge: Intel Corporation 82860 860 (Wombat) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 04)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 04)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 04)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 04)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5159
02:1f.0 PCI bridge: Intel Corporation 82806AA PCI64 Hub PCI Bridge (rev 03)
03:00.0 PIC: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01)
03:0e.0 SCSI storage controller: Adaptec 7892P (rev 02)
04:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
04:0c.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
04:0d.0 SCSI storage controller: Adaptec 7892A (rev 02)
04:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
04:0e.1 Input device controller: Creative Labs SB Live! (rev 08)
----------------------------------------------------------
   Boot messages appended:

Nov  4 23:13:46 flash kernel: Linux version 2.4.13-ac5 (root@flash) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #2 SMP Sun Nov 4 23:04:01 EST 2001
Nov  4 23:13:46 flash kernel: BIOS-provided physical RAM map:
Nov  4 23:13:46 flash kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 0000000000100000 - 000000003ff77000 (usable)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 000000003ff79000 - 0000000040000000 (reserved)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
Nov  4 23:13:46 flash kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Nov  4 23:13:46 flash kernel: 127MB HIGHMEM available.
Nov  4 23:13:46 flash kernel: found SMP MP-table at 000fe710
Nov  4 23:13:46 flash kernel: hm, page 000fe000 reserved twice.
Nov  4 23:13:46 flash kernel: hm, page 000ff000 reserved twice.
Nov  4 23:13:46 flash kernel: hm, page 000f0000 reserved twice.
Nov  4 23:13:46 flash kernel: On node 0 totalpages: 262007
Nov  4 23:13:46 flash kernel: zone(0): 4096 pages.
Nov  4 23:13:46 flash kernel: zone(1): 225280 pages.
Nov  4 23:13:46 flash kernel: zone(2): 32631 pages.
Nov  4 23:13:46 flash rpc.statd[635]: Version 0.3.1 Starting
Nov  4 23:13:46 flash nfslock: rpc.statd startup succeeded
Nov  4 23:13:46 flash kernel: Intel MultiProcessor Specification v1.4
Nov  4 23:13:46 flash kernel:     Virtual Wire compatibility mode.
Nov  4 23:13:46 flash kernel: OEM ID: DELL     Product ID: WS 530       APIC at: 0xFEE00000
Nov  4 23:13:46 flash kernel: Processor #0 Unknown CPU [15:1] APIC version 20
Nov  4 23:13:46 flash kernel: Processor #1 Unknown CPU [15:1] APIC version 20
Nov  4 23:13:46 flash kernel: I/O APIC #2 Version 32 at 0xFEC00000.
Nov  4 23:13:46 flash kernel: Processors: 2
Nov  4 23:13:46 flash kernel: Kernel command line: ro root=/dev/sda3 #hdd=ide-scsi
Nov  4 23:13:46 flash kernel: Initializing CPU#0
Nov  4 23:13:46 flash kernel: Detected 1694.894 MHz processor.
Nov  4 23:13:46 flash kernel: Console: colour VGA+ 80x25
Nov  4 23:13:46 flash keytable: Loading keymap:  succeeded
Nov  4 23:13:46 flash kernel: Calibrating delay loop... 3381.65 BogoMIPS
Nov  4 23:13:46 flash kernel: Memory: 1027444k/1048028k available (1543k kernel code, 20200k reserved, 462k data, 236k init, 130524k highmem)
Nov  4 23:13:46 flash kernel: Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Nov  4 23:13:46 flash kernel: Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Nov  4 23:13:46 flash keytable: Loading system font:  succeeded
Nov  4 23:13:46 flash kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Nov  4 23:13:46 flash kernel: Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Nov  4 23:13:46 flash kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Nov  4 23:13:46 flash kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Nov  4 23:13:46 flash kernel: CPU: L2 cache: 256K
Nov  4 23:13:46 flash kernel: Intel machine check architecture supported.
Nov  4 23:13:46 flash random: Initializing random number generator:  succeeded
Nov  4 23:13:46 flash kernel: Intel machine check reporting enabled on CPU#0.
Nov  4 23:13:46 flash kernel: Enabling fast FPU save and restore... done.
Nov  4 23:13:47 flash kernel: Enabling unmasked SIMD FPU exception support... done.
Nov  4 23:13:47 flash kernel: Checking 'hlt' instruction... OK.
Nov  4 23:13:47 flash kernel: POSIX conformance testing by UNIFIX
Nov  4 23:13:47 flash kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Nov  4 23:13:47 flash kernel: mtrr: detected mtrr type: Intel
Nov  4 23:13:47 flash kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Nov  4 23:13:47 flash kernel: CPU: L2 cache: 256K
Nov  4 23:13:47 flash kernel: Intel machine check reporting enabled on CPU#0.
Nov  4 23:13:47 flash kernel: CPU0: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
Nov  4 23:13:47 flash kernel: per-CPU timeslice cutoff: 731.73 usecs.
Nov  4 23:13:47 flash netfs: Mounting other filesystems:  succeeded
Nov  4 23:13:47 flash kernel: enabled ExtINT on CPU#0
Nov  4 23:13:47 flash kernel: ESR value before enabling vector: 00000040
Nov  4 23:13:47 flash kernel: ESR value after enabling vector: 00000000
Nov  4 23:13:47 flash kernel: Booting processor 1/1 eip 2000
Nov  4 23:13:47 flash kernel: Initializing CPU#1
Nov  4 23:13:47 flash kernel: masked ExtINT on CPU#1
Nov  4 23:13:47 flash kernel: ESR value before enabling vector: 00000000
Nov  4 23:13:47 flash kernel: ESR value after enabling vector: 00000000
Nov  4 23:13:47 flash kernel: Calibrating delay loop... 3381.65 BogoMIPS
Nov  4 23:13:47 flash kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Nov  4 23:13:47 flash kernel: CPU: L2 cache: 256K
Nov  4 23:13:47 flash kernel: Intel machine check reporting enabled on CPU#1.
Nov  4 23:13:47 flash kernel: CPU1: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
Nov  4 23:13:47 flash kernel: Total of 2 processors activated (6763.31 BogoMIPS).
Nov  4 23:13:47 flash autofs: automount startup succeeded
Nov  4 23:13:47 flash kernel: ENABLING IO-APIC IRQs
Nov  4 23:13:47 flash kernel: Setting 2 in the phys_id_present_map
Nov  4 23:13:47 flash kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Nov  4 23:13:47 flash kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Nov  4 23:13:47 flash kernel: testing the IO APIC.......................
Nov  4 23:13:47 flash kernel: 
Nov  4 23:13:47 flash rc: Starting pcmcia:  succeeded
Nov  4 23:13:47 flash kernel:  WARNING: unexpected IO-APIC, please mail
Nov  4 23:13:47 flash kernel:           to linux-smp@vger.kernel.org
Nov  4 23:13:48 flash sshd: Starting sshd:
Nov  4 23:13:48 flash kernel: .................................... done.
Nov  4 23:13:48 flash kernel: Using local APIC timer interrupts.
Nov  4 23:13:48 flash kernel: calibrating APIC timer ...
Nov  4 23:13:48 flash kernel: ..... CPU clock speed is 1694.8341 MHz.
Nov  4 23:13:48 flash kernel: ..... host bus clock speed is 99.6960 MHz.
Nov  4 23:13:48 flash kernel: cpu: 0, clocks: 996960, slice: 332320
Nov  4 23:13:48 flash kernel: CPU0<T0:996960,T1:664640,D:0,S:332320,C:996960>
Nov  4 23:13:48 flash kernel: cpu: 1, clocks: 996960, slice: 332320
Nov  4 23:13:48 flash kernel: CPU1<T0:996960,T1:332320,D:0,S:332320,C:996960>
Nov  4 23:13:48 flash kernel: checking TSC synchronization across CPUs: passed.
Nov  4 23:13:48 flash kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbe8e, last bus=4
Nov  4 23:13:48 flash kernel: PCI: Using configuration type 1
Nov  4 23:13:48 flash kernel: PCI: Probing PCI hardware
Nov  4 23:13:48 flash kernel: Unknown bridge resource 2: assuming transparent
Nov  4 23:13:48 flash last message repeated 2 times
Nov  4 23:13:48 flash kernel: PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B0,I31,P3) -> 19
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B0,I31,P1) -> 17
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B0,I31,P2) -> 23
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B3,I14,P0) -> 22
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B4,I11,P0) -> 23
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B4,I12,P0) -> 16
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B4,I13,P0) -> 17
Nov  4 23:13:48 flash kernel: PCI->APIC IRQ transform: (B4,I14,P0) -> 18
Nov  4 23:13:48 flash kernel: isapnp: Scanning for PnP cards...
Nov  4 23:13:48 flash kernel: isapnp: No Plug & Play device found
Nov  4 23:13:48 flash kernel: Linux NET4.0 for Linux 2.4
Nov  4 23:13:48 flash kernel: Based upon Swansea University Computer Society NET3.039
Nov  4 23:13:48 flash kernel: Initializing RT netlink socket
Nov  4 23:13:48 flash sshd:  succeeded
Nov  4 23:13:48 flash kernel: SBF: Simple Boot Flag extension found and enabled.
Nov  4 23:13:48 flash sshd: ^[[60G[  
Nov  4 23:13:48 flash kernel: SBF: Setting boot flags 0x80
Nov  4 23:13:48 flash sshd: 
Nov  4 23:13:30 flash rc.sysinit: Mounting proc filesystem:  succeeded 
Nov  4 23:13:48 flash kernel: Starting kswapd v1.8
Nov  4 23:13:48 flash rc: Starting sshd:  succeeded
Nov  4 23:13:30 flash sysctl: net.ipv4.ip_forward = 0 
Nov  4 23:13:48 flash kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Nov  4 23:13:30 flash sysctl: net.ipv4.conf.default.rp_filter = 1 
Nov  4 23:13:48 flash kernel: Journalled Block Device driver loaded
Nov  4 23:13:30 flash sysctl: kernel.sysrq = 0 
Nov  4 23:13:48 flash kernel: pty: 256 Unix98 ptys configured
Nov  4 23:13:30 flash rc.sysinit: Configuring kernel parameters:  succeeded 
Nov  4 23:13:48 flash kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Nov  4 23:13:30 flash date: Sun Nov  4 23:13:25 EST 2001 
Nov  4 23:13:48 flash kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov  4 23:13:30 flash rc.sysinit: Setting clock  (localtime): Sun Nov  4 23:13:25 EST 2001 succeeded 
Nov  4 23:13:48 flash kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Nov  4 23:13:30 flash rc.sysinit: Loading default keymap succeeded 
Nov  4 23:13:48 flash kernel: block: queued sectors max/low 682712kB/551640kB, 2048 slots per queue
Nov  4 23:13:30 flash rc.sysinit: Setting default font (lat0-sun16):  succeeded 
Nov  4 23:13:48 flash kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov  4 23:13:30 flash rc.sysinit: Activating swap partitions:  succeeded 
Nov  4 23:13:48 flash kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov  4 23:13:30 flash rc.sysinit: Setting hostname flash:  succeeded 
Nov  4 23:13:49 flash kernel: PIIX4: IDE controller on PCI bus 00 dev f9
Nov  4 23:13:30 flash fsck: /: clean, 178079/1151904 files, 753768/2303319 blocks 
Nov  4 23:13:49 flash kernel: PIIX4: chipset revision 4
Nov  4 23:13:30 flash rc.sysinit: Checking root filesystem succeeded 
Nov  4 23:13:49 flash kernel: PIIX4: not 100%% native mode: will probe irqs later
Nov  4 23:13:30 flash rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Nov  4 23:13:49 flash kernel: hdc: CRD-8482B, ATAPI CD/DVD-ROM drive
Nov  4 23:13:30 flash rc.sysinit: Finding module dependencies:  succeeded 
Nov  4 23:13:49 flash kernel: hdd: _NEC CD-RW NR-7800A, ATAPI CD/DVD-ROM drive
Nov  4 23:13:49 flash kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov  4 23:13:49 flash kernel: hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Nov  4 23:13:49 flash kernel: Uniform CD-ROM driver Revision: 3.12
Nov  4 23:13:49 flash kernel: hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Nov  4 23:13:31 flash fsck: /opt: clean, 14661/1275456 files, 101493/2546294 blocks 
Nov  4 23:13:49 flash kernel: Floppy drive(s): fd0 is 1.44M
Nov  4 23:13:31 flash rc.sysinit: Checking filesystems succeeded 
Nov  4 23:13:49 flash kernel: FDC 0 is a National Semiconductor PC87306
Nov  4 23:13:31 flash rc.sysinit: Mounting local filesystems:  succeeded 
Nov  4 23:13:49 flash kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Nov  4 23:13:31 flash rc.sysinit: Enabling local filesystem quotas:  succeeded 
Nov  4 23:13:49 flash kernel: 04:0b.0: 3Com PCI 3c905C Tornado at 0xcc80. Vers LK1.1.16
Nov  4 23:13:31 flash rc.sysinit: Turning on process accounting succeeded 
Nov  4 23:13:49 flash kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Nov  4 23:13:31 flash rc.sysinit: Enabling swap space:  succeeded 
Nov  4 23:13:49 flash kernel: agpgart: Maximum main memory to use for agp memory: 816M
Nov  4 23:13:33 flash init: Entering runlevel: 5 
Nov  4 23:13:49 flash kernel: agpgart: Unsupported Intel chipset (device id: 2531), you might want to try agp_try_unsupported=1.
Nov  4 23:13:49 flash kernel: SCSI subsystem driver Revision: 1.00
Nov  4 23:13:33 flash kudzu: Updating /etc/fstab succeeded 
Nov  4 23:13:49 flash kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Nov  4 23:13:43 flash kudzu:  succeeded 
Nov  4 23:13:49 flash kernel:         <Adaptec aic7892 Ultra160 SCSI adapter>
Nov  4 23:13:43 flash sysctl: net.ipv4.ip_forward = 0 
Nov  4 23:13:49 flash kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Nov  4 23:13:43 flash sysctl: net.ipv4.conf.default.rp_filter = 1 
Nov  4 23:13:49 flash kernel: 
Nov  4 23:13:43 flash sysctl: kernel.sysrq = 0 
Nov  4 23:13:49 flash kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Nov  4 23:13:49 flash kernel:         <Adaptec 29160N Ultra160 SCSI adapter>
Nov  4 23:13:43 flash network: Setting network parameters:  succeeded 
Nov  4 23:13:49 flash kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Nov  4 23:13:49 flash kernel: 
Nov  4 23:13:43 flash modprobe: modprobe: Can't locate module net-pf-4 
Nov  4 23:13:49 flash kernel:   Vendor: FUJITSU   Model: MAM3184MP         Rev: 5A01
Nov  4 23:13:43 flash modprobe: modprobe: Can't locate module net-pf-5 
Nov  4 23:13:49 flash kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov  4 23:13:43 flash network: Bringing up interface lo:  succeeded 
Nov  4 23:13:49 flash kernel: (scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Nov  4 23:13:43 flash modprobe: modprobe: Can't locate module net-pf-4 
Nov  4 23:13:49 flash kernel:   Vendor: FUJITSU   Model: MAM3184MP         Rev: 5A01
Nov  4 23:13:43 flash modprobe: modprobe: Can't locate module net-pf-5 
Nov  4 23:13:49 flash kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Nov  4 23:13:49 flash kernel: (scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Nov  4 23:13:49 flash kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Nov  4 23:13:46 flash network: Bringing up interface eth0:  succeeded 
Nov  4 23:13:49 flash kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
Nov  4 23:13:49 flash kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Nov  4 23:13:49 flash kernel: Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Nov  4 23:13:49 flash kernel: SCSI device sda: 35566478 512-byte hdwr sectors (18210 MB)
Nov  4 23:13:49 flash kernel: Partition check:
Nov  4 23:13:49 flash kernel:  sda: sda1 sda2 sda3
Nov  4 23:13:49 flash kernel: SCSI device sdb: 35566478 512-byte hdwr sectors (18210 MB)
Nov  4 23:13:49 flash kernel:  sdb: sdb1 < sdb5 > sdb2 sdb3
Nov  4 23:13:49 flash kernel: Linux Kernel Card Services 3.1.22
Nov  4 23:13:49 flash kernel:   options:  [pci] [cardbus] [pm]
Nov  4 23:13:49 flash kernel: usb.c: registered new driver usbdevfs
Nov  4 23:13:49 flash kernel: usb.c: registered new driver hub
Nov  4 23:13:50 flash kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Nov  4 23:13:50 flash kernel: PCI: Setting latency timer of device 00:1f.2 to 64
Nov  4 23:13:50 flash kernel: uhci.c: USB UHCI at I/O 0xff80, IRQ 19
Nov  4 23:13:50 flash kernel: usb.c: new USB bus registered, assigned bus number 1
Nov  4 23:13:50 flash kernel: hub.c: USB hub found
Nov  4 23:13:50 flash kernel: hub.c: 2 ports detected
Nov  4 23:13:50 flash kernel: PCI: Setting latency timer of device 00:1f.4 to 64
Nov  4 23:13:50 flash kernel: uhci.c: USB UHCI at I/O 0xff60, IRQ 23
Nov  4 23:13:50 flash kernel: usb.c: new USB bus registered, assigned bus number 2
Nov  4 23:13:50 flash kernel: hub.c: USB hub found
Nov  4 23:13:50 flash kernel: hub.c: 2 ports detected
Nov  4 23:13:50 flash kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov  4 23:13:50 flash kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Nov  4 23:13:50 flash kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Nov  4 23:13:50 flash kernel: TCP: Hash tables configured (established 262144 bind 65536)
Nov  4 23:13:50 flash kernel: Linux IP multicast router 0.06 plus PIM-SM
Nov  4 23:13:50 flash kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Nov  4 23:13:50 flash kernel: ds: no socket drivers loaded!
Nov  4 23:13:50 flash kernel: kjournald starting.  Commit interval 5 seconds
Nov  4 23:13:50 flash kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  4 23:13:50 flash kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov  4 23:13:50 flash kernel: Freeing unused kernel memory: 236k freed
Nov  4 23:13:50 flash kernel: Real Time Clock Driver v1.10e
Nov  4 23:13:50 flash kernel: Adding Swap: 2097136k swap-space (priority -1)
Nov  4 23:13:50 flash kernel: EXT3 FS 2.4-0.9.13, 21 Oct 2001 on sd(8,3), internal journal
Nov  4 23:13:50 flash kernel: kjournald starting.  Commit interval 5 seconds
Nov  4 23:13:50 flash kernel: EXT3 FS 2.4-0.9.13, 21 Oct 2001 on sd(8,18), internal journal
Nov  4 23:13:50 flash kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov  4 23:13:50 flash kernel: parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
Nov  4 23:13:50 flash kernel: parport0: irq 7 detected
Nov  4 23:13:57 flash modprobe: modprobe: Can't locate module char-major-226
Nov  4 23:13:57 flash modprobe: modprobe: Can't locate module char-major-226
Nov  4 23:14:15 flash kernel: Creative EMU10K1 PCI Audio Driver, version 0.16, 23:05:36 Nov  4 2001
Nov  4 23:14:15 flash kernel: emu10k1: EMU10K1 rev 8 model 0x8022 found, IO at 0xcc60-0xcc7f, IRQ 18
Nov  4 23:14:15 flash kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Cirrus Logic CS4297A rev B)
Nov  4 23:14:15 flash modprobe: modprobe: Can't locate module sound-service-0-0
Nov  4 23:14:20 flash kernel: cdrom: This disc doesn't have any tracks I recognize!
----------------------------------------------------------

   
   

