Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTIQVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbTIQVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:17:59 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:56766 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262838AbTIQVRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:17:21 -0400
Date: Wed, 17 Sep 2003 17:17:19 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait_on_irq, CPU 1:
In-Reply-To: <Pine.LNX.4.58.0309171709580.12413@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.58.0309171713581.12413@filesrv1.baby-dragons.com>
References: <20030917210545.GS1758@ovh.net> <Pine.LNX.4.58.0309171709580.12413@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All ,  Something I did figure for myself others may need .
	/proc/cpuinfo & a dmesg .  Hth & Tia ,  JimL

  # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 849.161
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1690.82

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 849.161
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1697.38

 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

  # dmesg
IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  1    1    0   1   0    1    1    81
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  1    1    0   1   0    1    1    89
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 003 03  1    1    0   1   0    1    1    91
 08 003 03  1    1    0   1   0    1    1    99
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    A1
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  1    1    0   1   0    1    1    A9
 0d 003 03  1    1    0   1   0    1    1    B1
 0e 003 03  1    1    0   1   0    1    1    B9
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ17 -> 1:1
IRQ20 -> 1:4
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ26 -> 1:10
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 849.1716 MHz.
..... host bus clock speed is 99.9020 MHz.
cpu: 0, clocks: 999020, slice: 333006
CPU0<T0:999008,T1:666000,D:2,S:333006,C:999020>
cpu: 1, clocks: 999020, slice: 333006
CPU1<T0:999008,T1:332992,D:4,S:333006,C:999020>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdbc1, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B0,I1,P0) -> 29
PCI->APIC IRQ transform: (B0,I1,P1) -> 28
PCI->APIC IRQ transform: (B0,I2,P0) -> 30
PCI->APIC IRQ transform: (B0,I5,P0) -> 20
PCI->APIC IRQ transform: (B0,I7,P0) -> 23
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I0,P0) -> 17
PCI->APIC IRQ transform: (B2,I1,P0) -> 24
PCI->APIC IRQ transform: (B2,I2,P0) -> 26
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/W]
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
udf: registering filesystem
aty128fb: Rage128 BIOS located at segment C00C0000
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 32M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 80x30
fb0: ATY Rage128 frame buffer device on PCI
mtrr: type mismatch for f4000000,2000000 old: uncachable new: write-combining
aty128fb: Rage128 MTRR set to ON
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
fore200e: FORE Systems 200E-series ATM driver - version 0.3e
fore200e: device PCA-200E found at 0xfe600000, IRQ 20
fore200e: device PCA-200E-0 mapped to 0xfa81e000
fore200e: device PCA-200E-0 self-test passed
fore200e: device PCA-200E-0 firmware started
fore200e: device PCA-200E-0 initialized
fore200e: device PCA-200E-0, rev. A, S/N: 59897, ESI: 00:20:48:04:e9:f9
fore200e: IRQ 20 reserved for device PCA-200E-0
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
ThunderLAN driver v1.15
TLAN: 0 devices installed, PCI: 0  EISA: 0
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
eth0: ns83820.c: 0x22c: f022100b, subsystem: 100b:f022
eth0: detected 64 bit PCI data bus.
eth0: enabling optical transceiver
eth0: ns83820 v0.20: DP83820 v1.3: 00:40:f4:66:df:ed io=0xfebff000 irq=24 f=sg
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:E0:81:04:D2:78, IRQ 23.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1920M
agpgart: AGP aperture is 32M @ 0xee000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Serverworks HE @ 0xee000000 32MB
[drm] Initialized r128 2.2.0 20010917 on minor 1
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
PCI: Enabling device 00:0f.1 (0000 -> 0001)
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
SCSI subsystem driver Revision: 1.00
sym.0.1.1: setting PCI_COMMAND_PARITY...
sym.0.1.0: setting PCI_COMMAND_PARITY...
sym0: <1010-66> rev 0x1 on pci bus 0 device 1 function 0 irq 29
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-66> rev 0x1 on pci bus 0 device 1 function 1 irq 28
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.19-pre3
scsi1 : sym-2.1.19-pre3
  Vendor: SEAGATE   Model: ST118273LW        Rev: 6246
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
  Vendor: COMPAQ    Model: ST34371W          Rev: 0940
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:1:0: tagged command queuing enabled, command queue depth 16.
sym0:2:0: tagged command queuing enabled, command queue depth 16.
  Vendor: COMPAQ    Model: TSL-9000          Rev: 2.06
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: TSL-9000          Rev: 2.06
  Type:   Medium Changer                     ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 at faa48000 size=100000 irq=26
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001
TID 525  Vendor: ADAPTEC      Device: RAID-5       Rev: 380E
scsi2 : Vendor: Adaptec  Model: 2110S            FW:380E
  Vendor: ADAPTEC   Model: RAID-5            Rev: 380E
  Type:   Direct-Access                      ANSI SCSI revision: 02
st: Version 20020805, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi1, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi2, channel 0, id 0, lun 0
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
Partition check:
 sda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sda1 sda2
SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
 sdb:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sdb1 sdb2
SCSI device sdc: 8386000 512-byte hdwr sectors (4294 MB)
 sdc:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sdc1 sdc2
SCSI device sdd: 177827840 512-byte hdwr sectors (91048 MB)
 sdd:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sdd1 sdd2
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 6, lun 0
sym1:5: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 15)
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sym1:6: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 15)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi generic sg4 at scsi1, channel 0, id 4, lun 1,  type 8
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/usb-ohci.c: USB OHCI at membase 0xfab49000, IRQ 10
host/usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF f7c9b244, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: fab49000
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7c9b244
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver usbscanner
scanner.c: 0.4.12:USB Scanner Driver
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
hpusbscsi.c: [hpusbscsi_init:250] driver loaded, DebugLvel=0
usb.c: registered new driver hpusbscsi
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1481.600 MB/sec
   32regs    :   979.200 MB/sec
   pIII_sse  :  1690.000 MB/sec
   pII_mmx   :  1878.800 MB/sec
   p5_mmx    :  1998.800 MB/sec
raid5: using function: pIII_sse (1690.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
lec.c: Sep  4 2003 14:27:12 initialized
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Adding Swap: 525288k swap-space (priority -1)
Adding Swap: 524480k swap-space (priority -2)
eth0: link now 1000F mbps, full duplex and up.
atm_connect (TX: cl 1,bw 0-0,sdu 484; RX: cl 1,bw 0-0,sdu 484,AAL 5)
fore200e: VC 0.0.16 uses buffer scheme 1
fore200e: VC 0.0.16 opened
atmsvc: no signaling demon
atm_connect (TX: cl 1,bw 0-0,sdu 9188; RX: cl 1,bw 0-0,sdu 9188,AAL 5)
fore200e: VC 0.0.102 uses buffer scheme 1
fore200e: VC 0.0.102 opened
eth0: no IPv6 routers present
eth1: no IPv6 routers present
mtrr: type mismatch for f4000000,2000000 old: uncachable new: write-combining
mtrr: type mismatch for f4000000,2000000 old: uncachable new: write-combining
sym1:4: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 15)
st0: Block limits 1 - 16777215 bytes.
Info fld=0x4320e1, Current sd08:21: sense key Recovered Error
Additional sense indicates Recovered data with error corr. & retries applied
nessusd uses obsolete (PF_INET,SOCK_PACKET)
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
device eth0 entered promiscuous mode
device eth0 left promiscuous mode

wait_on_irq, CPU 1:
irq:  0 [ 0 0 ]
bh:   1 [ 2 0 ]
Stack dumps:
CPU 0: <unknown>
CPU 1:c2b29f34 c03f8fdd 00000001 00000020 00000000 c2b29f60 c010a79d c03f8ff2
       c04bc104 f70a8000 00000001 c2b29f7c c01f8006 c04bc104 c2b29f94 00000282
       f70a876c f70a836c c2b29f9c c01224dc f70a8000 c2b28000 c2b2865c ffffffff
Call Trace:    [<c010a79d>] [<c01f8006>] [<c01224dc>] [<c012bc0b>] [<c0107448>]


On Wed, 17 Sep 2003, Mr. James W. Laferriere wrote:

> 	Hello All ,  Any more info I can pass along ?  This got dumped
> 	into my /var/log/syslog .  Please advise .  Tia ,  JimL
>
> Sep 17 15:00:59 filesrv1 kernel:
> Sep 17 15:00:59 filesrv1 kernel: wait_on_irq, CPU 1:
> Sep 17 15:00:59 filesrv1 kernel: irq:  0 [ 0 0 ]
> Sep 17 15:00:59 filesrv1 kernel: bh:   1 [ 2 0 ]
> Sep 17 15:00:59 filesrv1 kernel: Stack dumps:
> Sep 17 15:00:59 filesrv1 kernel: CPU 0: <unknown>
> Sep 17 15:00:59 filesrv1 kernel: CPU 1:c2b29f34 c03f8fdd 00000001 00000020 00000000 c2b29f60 c010a79d c03f8ff2
> Sep 17 15:00:59 filesrv1 kernel:        c04bc104 f70a8000 00000001 c2b29f7c c01f8006 c04bc104 c2b29f94 00000282
> Sep 17 15:00:59 filesrv1 kernel:        f70a876c f70a836c c2b29f9c c01224dc f70a8000 c2b28000 c2b2865c ffffffff
> Sep 17 15:00:59 filesrv1 kernel: Call Trace:    [<c010a79d>] [<c01f8006>] [<c01224dc>] [<c012bc0b>] [<c0107448>]
> Sep 17 15:00:59 filesrv1 kernel:
>

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
