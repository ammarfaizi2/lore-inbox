Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278203AbRJRXdp>; Thu, 18 Oct 2001 19:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278210AbRJRXdg>; Thu, 18 Oct 2001 19:33:36 -0400
Received: from web20206.mail.yahoo.com ([216.136.226.61]:27403 "HELO
	web20206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278203AbRJRXd0>; Thu, 18 Oct 2001 19:33:26 -0400
Message-ID: <20011018233359.2084.qmail@web20206.mail.yahoo.com>
Date: Thu, 18 Oct 2001 16:33:59 -0700 (PDT)
From: jimmy <x55k@yahoo.com>
Subject: UNABLE TO BOOT WITH 2nd SCSI DRIVE
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope you can shed a light to my problem. The server
works just fine with a single SCSI drive.
Unfortunately, when we add the 2nd SCSI drive, the
system does not boot.

VFS: Cannot open root dev "802" or 08:02
Please append correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:02

We have tried all SCSI ID combinations with no
success. LILO 'append="root=/dev/sda2"' command line
does not work. 802 above is our /dev/sda2 root
partition. We thought Adaptec driver is reshuffling
the drives however 'AIC7XXX=no_reset' LILO command
line does not work either.

I would be forever grateful if someone can offer a
hand.

Many thanks in advance for taking your time.

Jimmy

PS: Sorry if it looks like a cross-post. Server is
running out of disk space and we need to get the 2nd
drive added to the system. My apologies.

Here is some diagnostic information:

P3 866 MHz, BX M/b, 512 MB Ram, 9.1 GB SCSI IBM hd.
(works fine)
2nd HD: Cheetah 15000 RPM 36 GB hd (gives problem when
added to the system)
Adaptec 29160 Ultra160 SCSI adapter

Redhat 7.1, 2.4.2 Enterprise kernel (Adaptec Driver is
built into the kernel, not as module)

Kernel command line:
auto BOOT_IMAGE=x ro root=802
BOOT_FILE=/boot/vmlinuz-2.4.2-2enterprise
root=/dev/sda2

/proc/scsi/scsi:
Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SAH0
  Type:   Direct-Access                    ANSI SCSI
revision: 03

/etc/lilo.conf:
boot=/dev/sda
map=/boot/map
install=/boot/boot.b
prompt
timeout=5
message=/boot/message
linear
default=x
append="root=/dev/sda2"

image=/boot/vmlinuz-2.4.2-2
        label=linux
        initrd=/boot/initrd-2.4.2-2.img
        read-only
        root=/dev/sda2

image=/boot/vmlinuz-2.4.2-2enterprise
        label=x5
#       initrd=/boot/initrd-2.4.2-2enterprise.img
        read-only
        root=/dev/sda2


DMESG:
Linux version 2.4.2-2enterprise (root@localhost) (gcc
version 2.96 20000731 (X Net 5.0 2.96-81)) #1 Sun May
13 12:35:36 GM
T+4 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000
(usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00
(usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000
(reserved)
 BIOS-e820: 0000000000500000 @ 00000000ffb00000
(reserved)
 BIOS-e820: 000000001fdf0000 @ 0000000000100000
(usable)
 BIOS-e820: 000000000000d000 @ 000000001fef3000 (ACPI
data)
 BIOS-e820: 0000000000003000 @ 000000001fef0000 (ACPI
NVS)
Scan SMP from 40000000 for 1024 bytes.
Scan SMP from 4009fc00 for 1024 bytes.
Scan SMP from 400f0000 for 65536 bytes.
Scan SMP from 40000000 for 4096 bytes.
On node 0 totalpages: 130800
zone(0): 4096 pages.
zone DMA has max 32 cached pages.
zone(1): 126704 pages.
zone Normal has max 989 cached pages.
zone(2): 0 pages.
zone HighMem has max 1 cached pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Kernel command line: auto BOOT_IMAGE=x ro root=802
BOOT_FILE=/boot/vmlinuz-2.4.2-2enterprise
root=/dev/sda2
Initializing CPU#0
Detected 868.653 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1730.15 BogoMIPS
Memory: 512088k/523200k available (1451k kernel code,
10724k reserved, 78k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7,
524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5,
131072 bytes)
Page-cache hash table entries: 131072 (order: 8,
1048576 bytes)
Inode-cache hash table entries: 32768 (order: 6,
262144 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0387fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000
00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383fbff 00000000 00000000
00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
calibrating APIC timer ...
..... CPU clock speed is 868.6803 MHz.
..... host bus clock speed is 133.6430 MHz.
cpu: 0, clocks: 1336430, slice: 668215
CPU0<T0:1336416,T1:668192,D:9,S:668215,C:1336430>
mtrr: v1.37 (20001109) Richard Gooch
(rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb120, last
bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 340021kB/208949kB, 1024
slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
hdc: ATAPI 48X CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
NET4: Frame Diverter 0.46
loop: loaded (max 8 devices)
i810_rng: cannot reserve RNG region
Software Watchdog Timer: 0.05, timer margin: 60 sec
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by
Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 12 for device 01:02.0
divert: allocating divert_blk for eth0
eth0: Intel Corporation 82557 [Ethernet Pro 100],
00:D0:B7:BD:D2:84, I/O at 0xc400, IRQ 12.
  Board assembly 721383-009, Physical connectors
present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
cipcb: CIPE driver vers 1.4.5 (c) Olaf Titz 1996-2000,
100 channels, debug=1
cipcb: cipe_alloc_dev 0
divert: not allocating divert_blk for non-ethernet
device cipcb0
divert: not allocating divert_blk for non-ethernet
device dummy0
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
438M
agpgart: agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on Intel i810 @ 0xd0000000 64MB
[drm] Initialized i810 1.1.0 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
PCI: Found IRQ 11 for device 01:00.0
IRQ routing conflict in pirq table for device 00:1f.4
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER,
Rev 6.1.7
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Wide Channel A, SCSI Id=7, 32/255
SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI
revision: 03
scsi0:0:6:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 6, lun
0
(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset
31, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173
MB)
Partition check:
 sda: sda1 sda2 sda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind
32768)
ip_conntrack (4087 buckets, 32696 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding Swap: 120476k swap-space (priority -1)

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
