Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269407AbRHTVEa>; Mon, 20 Aug 2001 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHTVEY>; Mon, 20 Aug 2001 17:04:24 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:38555 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269350AbRHTVEK>; Mon, 20 Aug 2001 17:04:10 -0400
Date: Mon, 20 Aug 2001 23:04:10 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820230410.A28323@oisec.net>
In-Reply-To: <20010820105520.A22087@oisec.net> <200108202027.f7KKRnY41946@aslan.scsiguy.com> <20010820224536.A28179@oisec.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20010820224536.A28179@oisec.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 20, 2001 at 10:45:36PM +0200, Cliff Albert wrote:

> On Mon, Aug 20, 2001 at 02:27:49PM -0600, Justin T. Gibbs wrote:
> 
> > >I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
> > >the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
> > >i've been getting these errors since 2.4.3.
> > >
> > >> booting with append="noapic", gives the same errors
> > 
> > Can you send me the full messages when you boot with "aic7xxx=verbose"?
> > That should help indicate the source of your problems.  I also
> > need to see the devices that are attached to the bus, so a full dmesg
> > from a successful boot with the old driver would be helpful.
> 
> Well booting is successful on my board, but the same errors that almost
> everyone is getting are the same i'm getting. I just turned on verbose.
> 
> Most debugging info i already send to the linux-kernel mailinglist, i'll
> forward it on to you. The verbose info will be send also in about a few 
> hours.

And here they are, the dmesg is my bootup dmesg with the devices drivers 
and stuff, and the second dmesg is the actual errors (verbose turned on)

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.8-ac7 (root@neve) (gcc version 2.95.4 20010810 (Debian prerelease)) #16 Sun Aug 19 13:58:17 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffd000 (usable)
 BIOS-e820: 0000000017ffd000 - 0000000017fff000 (ACPI data)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98301
zone(0): 4096 pages.
zone(1): 94205 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=Linux248ac7 ro root=805 parport=0x378,7 parport=0x278,5 console=ttyS0,9600 aic7xxx=verbose
Initializing CPU#0
Detected 400.915 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 384040k/393204k available (1358k kernel code, 8776k reserved, 409k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU: Intel Celeron (Covington) stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 400.8949 MHz.
..... host bus clock speed is 100.2236 MHz.
cpu: 0, clocks: 1002236, slice: 501118
CPU0<T0:1002224,T1:501104,D:2,S:501118,C:1002236>
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI: Found IRQ 14 for device 00:04.2
PCI: Sharing IRQ 14 with 00:06.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
Journalled Block Device driver loaded
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
0x278: FIFO is 16 bytes
0x278: writeIntrThreshold is 16
0x278: readIntrThreshold is 16
0x278: PWord is 8 bits
0x278: Interrupts are ISA-Pulses
0x278: ECP port cfgA=0x14 cfgB=0x40
0x278: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport1: PC-style at 0x278 (0x678), irq 5, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport1: cpp_daisy: aa5500ff87(b8)
parport1: assign_addrs: aa5500ff87(b8)
parport1: cpp_daisy: aa5500ff87(b8)
parport1: assign_addrs: aa5500ff87(b8)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (interrupt-driven).
lp1: using parport1 (interrupt-driven).
Real Time Clock Driver v1.10d
ppdev: user-space parallel port driver
block: queued sectors max/low 254930kB/123858kB, 768 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PCI: Enabling device 00:04.1 (0000 -> 0001)
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: neither IDE port enabled (BIOS)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 11 for device 00:0c.0
eth0: RealTek RTL-8029 found at 0xa000, IRQ 11, 00:40:05:5A:6B:90.
8139too Fast Ethernet driver 0.9.18a
PCI: Found IRQ 15 for device 00:0a.0
eth1: RealTek RTL8139 Fast Ethernet at 0xd8800000, 00:50:bf:51:7a:42, IRQ 15
eth1:  Identified 8139 chip type 'RTL-8139C'
PCI: Found IRQ 10 for device 00:0b.0
eth2: RealTek RTL8139 Fast Ethernet at 0xd8802000, 00:50:bf:21:62:9a, IRQ 10
eth2:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 14 for device 00:06.0
PCI: Sharing IRQ 14 with 00:04.2
ahc_pci:0:6:0: Reading SEEPROM...done.
ahc_pci:0:6:0: Manual SE Termination
ahc_pci:0:6:0: Manual LVD Termination
ahc_pci:0:6:0: BIOS eeprom is present
ahc_pci:0:6:0: Primary Low Byte termination Enabled
ahc_pci:0:6:0: Primary High Byte termination Enabled
ahc_pci:0:6:0: Downloading Sequencer Program... 422 instructions downloaded
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: QUANTUM   Model: FIREBALL ST6.4S   Rev: 0F0C
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:0:1): Sending SDTR period c, offset 7f
(scsi0:A:0:1): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 0 synchronous at 20.0MHz, offset = 0xf
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0H
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5:1): Sending SDTR period c, offset 7f
(scsi0:A:5:1): Received SDTR period c, offset 7
	Filtered to period c, offset 7
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 7)
scsi0: target 5 synchronous at 20.0MHz, offset = 0x7
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6:1): Sending SDTR period c, offset 7f
(scsi0:A:6:1): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 6 synchronous at 20.0MHz, offset = 0xf
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 4, lun 0
(scsi0:A:0:0): Sending SDTR period c, offset f
(scsi0:A:0:0): Received SDTR period c, offset f
	Filtered to period c, offset f
SCSI device sda: 12772516 512-byte hdwr sectors (6540 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.  
 sdb: I/O error: dev 08:10, sector 0
 unable to read partition table
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
(scsi0:A:5:0): Sending SDTR period c, offset 7
(scsi0:A:5:0): Received SDTR period c, offset 7
	Filtered to period c, offset 7
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
sr1: scsi-1 drive
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (3071 buckets, 24568 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 136512k swap-space (priority -1)
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth2: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.debug"


  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0H
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:5:1): Sending SDTR period c, offset 7f
(scsi0:A:5:1): Received SDTR period c, offset 7
	Filtered to period c, offset 7
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 7)
scsi0: target 5 synchronous at 20.0MHz, offset = 0x7
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6:1): Sending SDTR period c, offset 7f
(scsi0:A:6:1): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 6 synchronous at 20.0MHz, offset = 0xf
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 4, lun 0
(scsi0:A:0:0): Sending SDTR period c, offset f
(scsi0:A:0:0): Received SDTR period c, offset f
	Filtered to period c, offset f
SCSI device sda: 12772516 512-byte hdwr sectors (6540 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.  
 sdb: I/O error: dev 08:10, sector 0
 unable to read partition table
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
(scsi0:A:5:0): Sending SDTR period c, offset 7
(scsi0:A:5:0): Received SDTR period c, offset 7
	Filtered to period c, offset 7
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
sr1: scsi-1 drive
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (3071 buckets, 24568 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 136512k swap-space (priority -1)
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth1: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
eth2: Setting 100mbps full-duplex based on auto-negotiated partner ability 41e1.
keyboard: Timeout - AT keyboard not present?(f4)
eth0: no IPv6 routers present
eth1: no IPv6 routers present
(scsi0:A:0:0): Sending SDTR period c, offset f
(scsi0:A:0:0): Received SDTR period c, offset f
	Filtered to period c, offset f
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x5, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0x0
SCB count = 16
Kernel NEXTQSCB = 7
Card NEXTQSCB = 7
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 2:2 0:0 6:3 4:11 3:4 5:6 1:13 7:1 
QOUTFIFO entries: 
Sequencer Free SCB List: 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 2, 0, 3, 11, 4, 6, 13, 1
Kernel Free SCB list: 5 14 15 8 9 10 12 
DevQ(0:0:0): 6 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 3 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x9
ACCUM = 0x0, SINDEX = 0x7, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 2:2 0:0 4:11 3:4 5:6 1:13 7:1 
QOUTFIFO entries: 
Sequencer Free SCB List: 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 2, 0, 11, 4, 6, 13, 1
Kernel Free SCB list: 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 0 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x9
ACCUM = 0x0, SINDEX = 0x3, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 0
Card NEXTQSCB = 0
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 2:2 4:11 3:4 5:6 1:13 7:1 
QOUTFIFO entries: 
Sequencer Free SCB List: 0 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 2, 11, 4, 6, 13, 1
Kernel Free SCB list: 3 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 1 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 1
Card NEXTQSCB = 1
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 2:2 4:11 3:4 5:6 1:13 
QOUTFIFO entries: 
Sequencer Free SCB List: 7 0 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 2, 11, 4, 6, 13
Kernel Free SCB list: 0 3 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 13 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x1, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 13
Card NEXTQSCB = 13
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 2:2 4:11 3:4 5:6 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 7 0 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 2, 11, 4, 6
Kernel Free SCB list: 1 0 3 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 2 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0xd, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 4:11 3:4 5:6 
QOUTFIFO entries: 
Sequencer Free SCB List: 2 1 7 0 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 11, 4, 6
Kernel Free SCB list: 13 1 0 3 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 6 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x2, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 6
Card NEXTQSCB = 6
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 4:11 3:4 
QOUTFIFO entries: 
Sequencer Free SCB List: 5 2 1 7 0 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 11, 4
Kernel Free SCB list: 2 13 1 0 3 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 4 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x8
ACCUM = 0x0, SINDEX = 0x6, DINDEX = 0xe4, ARG_2 = 0x0
HCNT = 0x0
SCSISEQ = 0x12, SBLKCTL = 0xa
 DFCNTRL = 0x0, DFSTATUS = 0x89
LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
SSTAT0 = 0x0, SSTAT1 = 0xa
STACK == 0x3, 0x10d, 0x165, 0xec
SCB count = 16
Kernel NEXTQSCB = 4
Card NEXTQSCB = 4
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 4:11 
QOUTFIFO entries: 
Sequencer Free SCB List: 3 5 2 1 7 0 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 
Pending list: 11
Kernel Free SCB list: 6 2 13 1 0 3 7 5 14 15 8 9 10 12 
DevQ(0:0:0): 0 waiting
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:6:0): 0 waiting
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 11 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue a TARGET RESET message
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 8194
(scsi0:A:0): 3.300MB/s transfers
scsi0: target 0 using asynchronous transfers
(scsi0:A:5): 3.300MB/s transfers
scsi0: target 5 using asynchronous transfers
(scsi0:A:6): 3.300MB/s transfers
scsi0: target 6 using asynchronous transfers
scsi0: SCSI bus reset delivered. 0 SCBs aborted.
(scsi0:A:0:0): Sending SDTR period c, offset f
(scsi0:A:0:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 0 synchronous at 20.0MHz, offset = 0xf
(scsi0:A:0:0): Sending SDTR period c, offset f
(scsi0:A:0:0): Received SDTR period c, offset f
	Filtered to period c, offset f
Device not ready.  Make sure there is a disc in the drive.
(scsi0:A:5:0): Sending SDTR period c, offset 7
(scsi0:A:5:0): Received SDTR period c, offset 7
	Filtered to period c, offset 7
(scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 7)
scsi0: target 5 synchronous at 20.0MHz, offset = 0x7
(scsi0:A:5:0): Sending SDTR period c, offset 7
(scsi0:A:5:0): Received SDTR period c, offset 7
	Filtered to period c, offset 7
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
scsi0: target 6 synchronous at 20.0MHz, offset = 0xf
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
(scsi0:A:6:0): Sending SDTR period c, offset f
(scsi0:A:6:0): Received SDTR period c, offset f
	Filtered to period c, offset f
Device not ready.  Make sure there is a disc in the drive.
device eth0 entered promiscuous mode

--ibTvN161/egqYuK8--
