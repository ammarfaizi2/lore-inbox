Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbRE2W1G>; Tue, 29 May 2001 18:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbRE2W0z>; Tue, 29 May 2001 18:26:55 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:28429 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S262232AbRE2W0p>; Tue, 29 May 2001 18:26:45 -0400
Date: Wed, 30 May 2001 00:26:32 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new aic7xxx oopses with AHA2940
Message-ID: <20010530002632.A7734@lisa.links2linux.home>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010527042129.A12765@lisa.links2linux.home> <200105291855.f4TIteU27159@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105291855.f4TIteU27159@aslan.scsiguy.com>; from gibbs@scsiguy.com on Tue, May 29, 2001 at 12:55:40PM -0600
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Justin T. Gibbs schrieb am 29.05.01 um 20:55 Uhr:
> >OK. Now I cut out the Oops out of my /var/log/messages, then did
> 
> Can you provide the full dmesg from a working kernel for you system?
> I need to know the type of controller in use as well as some other
> system attributes.
> 

sure. but its only the old aic7xxx driver. The new one is not
working . I was one thing missing, sorry: 

The new driver has been working.
He did it since I installed Wi***** 2k on the 4G scsi-disk (maybe
random?). Maybe
that fuc**** Billysoft has "tuned" my Controller firmware?? I don't
think (hope!) thats possible...

dmesg:


Linux version 2.4.5 (root@homer) (gcc version 2.95.2 19991024 (release)) #5 Sun May 27 13:11:31 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01884000)
Kernel command line: auto BOOT_IMAGE=linux ro root=307
Initializing CPU#0
Detected 807.220 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1608.90 BogoMIPS
Memory: 512868k/524208k available (1333k kernel code, 10952k reserved, 471k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Found VT82C686A, not applying VIA latency patch.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 340869kB/209797kB, 1024 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PCI: The same IRQ used for device 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hda: ST320430A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 011, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40079088 sectors (20520 MB) w/512KiB Cache, CHS=39761/16/63, UDMA(66)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 00:0d.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
(scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/13/0
(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AHA-294X SCSI host adapter>
(scsi0:0:2:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: PLEXTOR   Model: CD-ROM PX-8XCS    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: TEAC      Model: CD-R58S           Rev: 1.0K
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: DVD-ROM DVD-105   Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 2, lun 0
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
 sda: sda1
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
Detected scsi CD-ROM sr2 at scsi1, channel 0, id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: APM is already active, exiting
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 265568k swap-space (priority -1)
reiserfs: checking transaction log (device 03:0a) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
NTFS version 010116
Warning! NTFS volume version is Win2k+: Mounting read-only
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.259 $ time 17:21:57 May 26 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
usb-uhci.c: USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus2/2, assigned device number 2
hub.c: USB hub found
hub.c: 4 ports detected
Creative EMU10K1 PCI Audio Driver, version 0.7, 17:21:48 May 26 2001
PCI: Found IRQ 10 for device 00:0b.0
PCI: The same IRQ used for device 00:11.0
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xa400-0xa41f, IRQ 10
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:0c.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:0F:5E:23, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 697680-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
/dev/vmmon: Module vmmon: registered with major=10 minor=165 tag=$Name: build-1118 $
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 363 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
NVRM: loading NVIDIA kernel module version 1.0-1251
/dev/vmnet: open called by PID 533 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened



-- 
|             ...and don't forget: Linux rulez!                    |
|                                                                  |
| http://www.links2linux.de <-- Von Linux-Usern fuer Linux-User    |

