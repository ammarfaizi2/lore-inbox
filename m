Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRCGBhM>; Tue, 6 Mar 2001 20:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRCGBhD>; Tue, 6 Mar 2001 20:37:03 -0500
Received: from thunderer.concentric.net ([207.155.252.72]:2272 "EHLO
	thunderer.cnchost.com") by vger.kernel.org with ESMTP
	id <S129830AbRCGBgs>; Tue, 6 Mar 2001 20:36:48 -0500
Message-ID: <3AA590FF.5080203@devries.tv>
Date: Tue, 06 Mar 2001 20:38:07 -0500
From: Peter DeVries <peter@devries.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Drive corruption with VIA VT82C686A (ABIT KT7-RAID) - Still -
In-Reply-To: <3AA57268.3070603@devries.tv> <3AA57458.F13C44AB@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------060301060309040808090201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060301060309040808090201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

tried both 2.4.3-pre2 and 2.4.2-ac12.  Same results with each. Let me 
know which reports are most important so I don't post more than 
necassary.  I was able to get lspci -vvxxx, dmesg, hdparm -i, 
cat/proc/ide/via.  I did notice it is detecting a 40w cable even though 
I am using a 80w.  Could that possibly be the problem?   Although I have 
tried switching cables and had the same problem.

As soon as the drive has to do any work (hdparm -tT /dev/hda, cp'ing, 
mv'ing) the system will lock.  I can get the drive working after a few 
fsck's in 2.2.16 but if I were to try booting into 2.4.x and running 
fsck I will soon get lost inodes and the system will fail to operate.

Please CC me with responses.  I am not subscribed to the list.

Thanks


Jeff Garzik wrote:

> If you haven't already, would it be possible for you to try two patches
> for 2.4.2 (separately)?
> 
> Linus' latest testing patch, 2.4.3-pre2, is available from
> ftp://ftp.<country-code>.kernel.org/pub/linux/kernel/testing/
> 
> Alan Cox's latest patchkit, 2.4.2-ac12, is available from
> ftp://ftp.<country-code>.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> Both of these, actually, have the potential for solving your problem. 
> It would greatly help, IMHO, if you could try 2.4.3-pre2 and 2.4.2-ac12
> and compare the results you see with 2.4.2 kernel.
> 
> Best regards,
> 
> 	Jeff
> 
> 
> 



--------------060301060309040808090201
Content-Type: text/plain;
 name="dma-dmesg-2.4.3pre2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-dmesg-2.4.3pre2"

Linux version 2.4.3-pre2 (root@hades) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Tue Mar 6 09:32:38 EST 2001
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
Detected 800.060 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126040k/131072k available (1389k kernel code, 4644k reserved, 542k data, 220k init, 0k highmem)
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
block: queued sectors max/low 83701kB/27900kB, 256 slots per queue
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
loop: loaded (max 8 devices)
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
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
PCI: Found IRQ 11 for device 00:0d.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/255 SCBs

  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
es1371: version v0.27 time 09:34:38 Mar  6 2001
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
Freeing unused kernel memory: 220k freed
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
Unable to find swap-space signature
eth0: using NWAY autonegotiation
eth0: command 0x2800 took 33670 usecs! Please tell andrewm@uow.edu.au
hda: DMA disabled
VFS: Disk change detected on device ide1(22,0)
hdc: DMA disabled

--------------060301060309040808090201
Content-Type: text/plain;
 name="dma-hdparmi-2.4.3pre2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma-hdparmi-2.4.3pre2"

de on if ARG is positive, off otherwise.
When hideshow minor mode is on, the menu bar is augmented with hideshow
commands and the hideshow commands are enabled.
The value '(hs . t) is added to `buffer-invisibility-spec'.
Last, the normal hook `hs-minor-mode-hook' is run; see the doc
for `run-hooks'.

The main commands are: `hs-hide-all', `hs-show-all', `hs-hide-block',
`hs-show-block', `hs-hide-level' and `hs-show-region'.
Also see the documentation for the variable `hs-show-hidden-short-form'.

Turning hidesh
--------------060301060309040808090201--

