Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRCFX0T>; Tue, 6 Mar 2001 18:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRCFX0A>; Tue, 6 Mar 2001 18:26:00 -0500
Received: from marlborough.concentric.net ([207.155.248.14]:16354 "EHLO
	marlborough.cnchost.com") by vger.kernel.org with ESMTP
	id <S129696AbRCFXZs>; Tue, 6 Mar 2001 18:25:48 -0500
Message-ID: <3AA57268.3070603@devries.tv>
Date: Tue, 06 Mar 2001 18:27:36 -0500
From: Peter DeVries <peter@devries.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Drive corruption with VIA VT82C686A (ABIT KT7-RAID) - Still -
Content-Type: multipart/mixed;
 boundary="------------070505030109090302020500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070505030109090302020500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Still having drive corruption issues with 2.4+ when DMA mode is 
enabled.  Drive corruption is almost instant.  attached are output files 
for the system with kernel 2.4.2 without DMA mode and with DMA.

Immediatley after running those commands I attempted to do a copy with 
DMA on and the system locked.  If I reboot with 2.4.2 FSCK will fail and 
after a few reboots the drive will be unusable.


--------------070505030109090302020500
Content-Type: text/plain;
 name="dma-dmesg-2.4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-dmesg-2.4.2"

Linux version 2.4.2 (root@hades) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Mar 6 07:03:02 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000000e00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000100000 @ 0000000000f00000 (reserved)
 BIOS-e820: 0000000006ff0000 @ 0000000001000000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: BOOT_IMAGE=Linux-2.4 ro root=305 mem=128M
Initializing CPU#0
Detected 800.064 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126020k/131072k available (1403k kernel code, 4664k reserved, 542k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Bus master read caching disabled
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83688kB/27896kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD205BA, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=2495/255/63, UDMA(33)
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 10 for device 00:08.0
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:07.3
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0xdc00,  00:01:03:30:0f:3a, IRQ 10
  product code 'HN' rev 00.3 date 11-03-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 64MB
[drm] Initialized r128 2.1.2 20001215 on minor 63
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0d.0
(scsi0) <Adaptec AIC-7850 SCSI host adapter> found at PCI 0/13/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Cables present (Int-50 YES, Ext-50 NO)
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7850 SCSI host adapter>
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
es1371: version v0.27 time 07:05:11 Mar  6 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
PCI: Found IRQ 3 for device 00:11.0
es1371: found es1371 rev 6 at io 0xe400 irq 3
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
PCI: The same IRQ used for device 00:08.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:07.3
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:08.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
Unable to find swap-space signature
eth0: using NWAY autonegotiation
eth0: command 0x2800 took 33590 usecs! Please tell andrewm@uow.edu.au
hda: DMA disabled
VFS: Disk change detected on device ide1(22,0)
hdc: DMA disabled

--------------070505030109090302020500
Content-Type: text/plain;
 name="dma-hdparmi-2.4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-hdparmi-2.4.2"


/dev/hda:

 Model=WDC WD205BA, FwRev=16.13M16, SerialNo=WD-WM9491167491
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40088160
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 

--------------070505030109090302020500
Content-Type: text/plain;
 name="dma-procvia-2.4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-procvia-2.4.2"

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
BM-DMA base:                        0xd000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns     120ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  16.5MB/s   3.3MB/s

--------------070505030109090302020500
Content-Type: text/plain;
 name="dmesg-2.4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.2"

Linux version 2.4.2 (root@hades) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Mar 6 07:03:02 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000000e00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000100000 @ 0000000000f00000 (reserved)
 BIOS-e820: 0000000006ff0000 @ 0000000001000000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: BOOT_IMAGE=Linux-2.4 ro root=305 mem=128M
Initializing CPU#0
Detected 800.064 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126020k/131072k available (1403k kernel code, 4664k reserved, 542k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Bus master read caching disabled
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83688kB/27896kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD205BA, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=2495/255/63, UDMA(33)
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 10 for device 00:08.0
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:07.3
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0xdc00,  00:01:03:30:0f:3a, IRQ 10
  product code 'HN' rev 00.3 date 11-03-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 64MB
[drm] Initialized r128 2.1.2 20001215 on minor 63
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0d.0
(scsi0) <Adaptec AIC-7850 SCSI host adapter> found at PCI 0/13/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Cables present (Int-50 YES, Ext-50 NO)
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7850 SCSI host adapter>
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
es1371: version v0.27 time 07:05:11 Mar  6 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
PCI: Found IRQ 3 for device 00:11.0
es1371: found es1371 rev 6 at io 0xe400 irq 3
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
PCI: The same IRQ used for device 00:08.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:07.3
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:08.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
Unable to find swap-space signature
eth0: using NWAY autonegotiation
eth0: command 0x2800 took 33590 usecs! Please tell andrewm@uow.edu.au
hda: DMA disabled
VFS: Disk change detected on device ide1(22,0)
hdc: DMA disabled

--------------070505030109090302020500
Content-Type: text/plain;
 name="procvia-2.4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procvia-2.4.2"

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
BM-DMA base:                        0xd000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns     120ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  16.5MB/s   3.3MB/s

--------------070505030109090302020500
Content-Type: text/plain;
 name="hdparmi-2.4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparmi-2.4.2"


/dev/hda:

 Model=WDC WD205BA, FwRev=16.13M16, SerialNo=WD-WM9491167491
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40088160
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 

--------------070505030109090302020500--

