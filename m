Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310378AbSCGQD4>; Thu, 7 Mar 2002 11:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310372AbSCGQDo>; Thu, 7 Mar 2002 11:03:44 -0500
Received: from [151.17.201.167] ([151.17.201.167]:41482 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S310378AbSCGQD0>;
	Thu, 7 Mar 2002 11:03:26 -0500
Message-ID: <3C878FC8.86FCC3@teamfab.it>
Date: Thu, 07 Mar 2002 17:05:28 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
Subject: [OOPS] Linux 2.2.21pre[23]
In-Reply-To: <E16LkAs-0003tY-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------9532B6BAFB579C7EAE579ADE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9532B6BAFB579C7EAE579ADE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan,

I have a fully reproducible oops on boot with 2.2.21pre2 and 2.2.21pre3.
Kernels 2.2.19, 2.2.21pre1 and 2.4.18rc2 works great.

oops
----
CPU serial number disabled.
Unable to handle kernel paging request at virtual address 756e654f
current->tss.cr3 = 00101000,%cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0278bc1>]
EFLAGS: 00010246
eax: 00000002  ebx: 756e6547  ecx: 6c65746e  edx: 49656e69
:
:

just tel me if I must hand copy the rest of the screen :(

ciao,
luca

my 0.2 euro on: [Backport a lot of x86 setup] ;)
--------------9532B6BAFB579C7EAE579ADE
Content-Type: text/plain; charset=us-ascii;
 name="detail.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="detail.txt"

verlinux
--------
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.16
util-linux             2.10q
mount                  2.10q
modutils               2.3.23
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.7
Net-tools              1.53
Kbd                    0.99
Sh-utils               1.16

lspci
-----
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
00:0c.0 SCSI storage controller: Adaptec 7896
00:0c.1 SCSI storage controller: Adaptec 7896
00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23)
01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)

2.4.18rc2 dmesg
---------------
Linux version 2.4.18-rc2 (root@localhost.localdomain.net) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 SMP Tue Feb 19 10:43:39 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6b50
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: root=/dev/sda1 vga=0x303 gui=yes  mem=262080K
Initializing CPU#0
Detected 696.417 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 255360k/262080k available (1213k kernel code, 6332k reserved, 349k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.76 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1392.64 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2782.00 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-16, 2-17, 2-18, 2-20, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    91
 14 000 00  1    0    0   0   0    0    0    00
 15 003 03  1    1    0   1   0    1    1    99
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ19 -> 0:19
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 696.3313 MHz.
..... host bus clock speed is 99.4758 MHz.
cpu: 0, clocks: 994758, slice: 331586
CPU0<T0:994752,T1:663152,D:14,S:331586,C:994758>
cpu: 1, clocks: 994758, slice: 331586
CPU1<T0:994752,T1:331568,D:12,S:331586,C:994758>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdab0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
vesafb: framebuffer at 0xf6000000, mapped to 0xd0800000, size 2048k
vesafb: mode is 800x600x8, linelength=800, pages=3
vesafb: protected mode interface info at c000:3017
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2860-0x2867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2868-0x286f, BIOS settings: hdc:DMA, hdd:pio
hdc: CRD-8520B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:D0:B7:A7:91:2F, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 265064k swap-space (priority -1)

.config
-------
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M686 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_SMP=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_OPTIMIZE is not set
CONFIG_PCI_OLD_PROC=y
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_BINFMT_JAVA is not set
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_APM is not set
# CONFIG_TOSHIBA is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_VIA82C586 is not set
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_IDE_CHIPSETS is not set

#
# Additional Block Devices
#
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_NETLINK is not set
# CONFIG_FIREWALL is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y
# CONFIG_IPV6 is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_CPU_IS_SLOW is not set

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
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
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
# CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT is not set
CONFIG_AIC7XXX_CMDS_PER_DEVICE=24
# CONFIG_AIC7XXX_PROC_STATS is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_RTL8139 is not set
# CONFIG_RTL8139TOO is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_EISA=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_LP486E is not set
# CONFIG_CS89x0 is not set
# CONFIG_DM9102 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DEC_ELCP is not set
# CONFIG_DEC_ELCP_OLD is not set
# CONFIG_DGRS is not set
CONFIG_EEXPRESS_PRO100=y
# CONFIG_LNE390 is not set
# CONFIG_NE3210 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SIS900 is not set
# CONFIG_ES3210 is not set
# CONFIG_EPIC100 is not set
# CONFIG_ZNET is not set
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
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_HDLC is not set
# CONFIG_DLCI is not set
# CONFIG_XPEED is not set
# CONFIG_SBNI is not set

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
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_PRINTER_READBACK is not set
CONFIG_MOUSE=y

#
# Mice
#
# CONFIG_ATIXL_BUSMOUSE is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_MS_BUSMOUSE is not set
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=y
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_RU is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

--------------9532B6BAFB579C7EAE579ADE--

