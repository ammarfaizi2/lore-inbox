Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271317AbTHCW3p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 18:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTHCW3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 18:29:45 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:6603
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S271295AbTHCW3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 18:29:14 -0400
Date: Sun, 3 Aug 2003 18:31:15 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030803223115.GA1132@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org> <20030803015510.GB4696@blazebox.homeip.net> <20030802190737.3c41d4d8.akpm@osdl.org> <20030803214755.GA1010@blazebox.homeip.net> <20030803145211.29eb5e7c.akpm@osdl.org> <20030803222313.GA1090@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20030803222313.GA1090@blazebox.homeip.net>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.4.21-xfs
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 03, 2003 at 06:23:13PM -0400, Diffie wrote:
> On Sun, Aug 03, 2003 at 02:52:11PM -0700, Andrew Morton wrote:
> > Diffie <diffie@blazebox.homeip.net> wrote:
> > >
> > > I think this bug is due to me using the aic7xxx_old code ver 5.x.x.
> > >=20
> > >  Under kernel 2.4.21 the aic7xxx (new) is ver 6.2.8 and it works great
> > >  with Adaptec AHA-2940U2W controller i have.
> > >=20
> > >  On 2.6.0-test2-mm3 (tried Linus test1,test2,mm1 and mm2) the NEW aic=
7xxx
> > >  uses ver 6.2.35 and will not scan my IBM drive even though it
> > >  initializes the correct SCSI ID,LUN etc...
> > >=20
> > >  I would like to contact and report this issue to the aic7xxx maintan=
er
> > >  and perhaps get it resolved.Where would be the best place to report =
this
> > >  kind of problem?
> > >=20
> > >  I have taken few screen captures which are available at:
> > >  http://www.blazebox.homeip.net:81/diffie/images/2.6.0-test2/ and show
> > >  the aic7xxx (new) failure.
> >=20
> > An appropriate way to report this would be to email Justin (CC'ed here)
> > and linux-scsi@vger.kernel.org.
> >=20
> >=20
>=20
> Andrew,
>=20
> Thank you for all your help.Sorry but i gave the wrong URL in previous
> email.The correct one is http://www.blazebox.homeip.net:81/diffie/images/=
linux-2.6.0-test2/=20
>=20
> Attached is the dmesg,lspci and aic7xxx /proc information from 2.4.21
> kernel.
>=20
> Regards,
>=20
> Paul B.
>=20

I am sorry again for not including the attachement.


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.4.txt"

Linux version 2.4.21-xfs (root@blaze.homeip.net) (gcc version 3.2.2) #1 Mon Jun 30 10:29:27 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000f52c0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=Slackware-2.4 ro root=803 rootflags=quota acpi=off
Initializing CPU#0
Detected 2204.995 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4404.01 BogoMIPS
Memory: 1032968k/1048512k available (1930k kernel code, 15156k reserved, 347k data, 284k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 3200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2205.0712 MHz.
..... host bus clock speed is 400.9219 MHz.
cpu: 0, clocks: 4009219, slice: 2004609
CPU0<T0:4009216,T1:2004592,D:15,S:2004609,C:4009219>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfad30, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI-XFS CVS-2003-06-14_05:00_UTC with ACLs, no debug enabled
SGI XFS Quota Management subsystem
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
spurious 8259A interrupt: IRQ7.
keyboard: Timeout - AT keyboard not present?(00)
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-372200, ATA DISK drive
blk: queue c03b01c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 44150400 sectors (22605 MB) w/1966KiB Cache, CHS=2920/240/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
ldm_validate_partition_table(): Disk read failed.
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue f7eca494, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7eca594, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7eca694, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7eca794, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
XFS mounting filesystem sd(8,3)
Ending clean XFS mount for filesystem: sd(8,3)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 284k freed
Adding Swap: 248968k swap-space (priority -1)
XFS mounting filesystem sd(8,1)
Ending clean XFS mount for filesystem: sd(8,1)
NTFS driver v1.1.22 [Flags: R/O MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
XFS mounting filesystem sd(8,5)
Ending clean XFS mount for filesystem: sd(8,5)
XFS mounting filesystem sd(8,6)
Ending clean XFS mount for filesystem: sd(8,6)
XFS mounting filesystem sd(8,7)
Ending clean XFS mount for filesystem: sd(8,7)
XFS mounting filesystem sd(8,8)
Ending clean XFS mount for filesystem: sd(8,8)
XFS mounting filesystem sd(8,9)
Ending clean XFS mount for filesystem: sd(8,9)
XFS mounting filesystem ide0(3,1)
Ending clean XFS mount for filesystem: ide0(3,1)
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xf8850000, IRQ 11
usb-ohci.c: usb-00:02.0, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xf8852000, IRQ 9
usb-ohci.c: usb-00:02.1, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
hub.c: new USB device 00:02.0-1, assigned address 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 00:02.0-2, assigned address 3
input0: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb1:3.0
hub.c: new USB device 00:02.0-1.1, assigned address 4
input1: USB HID v1.10 Keyboard [045e:001d] on usb1:4.0
input2: USB HID v1.10 Pointer [045e:001d] on usb1:4.1
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
ohci1394: $Rev: 896 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ce084000-ce0847ff]  Max Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
hub.c: new USB device 00:02.1-1, assigned address 2
Intel 810 + AC97 Audio, version 0.24, 10:34:08 Jun 30 2003
PCI: Setting latency timer of device 00:06.0 to 64
i810: NVIDIA nForce Audio found at IO 0xd000 and 0xe400, MEM 0x0000 and 0x0000, IRQ 5
usb.c: USB device 2 (vend/prod 0x46d/0x840) is not claimed by any active driver.
ieee1394: Host added: Node[00:1023]  GUID[8a1cc7ffff0020ed]  [Linux OHCI-1394]
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value = 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
PCI: Setting latency timer of device 00:02.2 to 64
ehci-hcd 00:02.2: PCI device 10de:0068 (nVidia Corporation)
ehci-hcd 00:02.2: irq 5, pci mem f88c0000
usb.c: new USB bus registered, assigned bus number 3
PCI: 00:02.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:02.2 PCI cache line size corrected to 64.
ehci-hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
usb.c: USB disconnect on device 00:02.1-1 address 2
usb.c: USB disconnect on device 00:02.0-1 address 2
usb.c: USB disconnect on device 00:02.0-1.1 address 4
usb.c: USB disconnect on device 00:02.0-2 address 3
hub.c: new USB device 00:02.0-1, assigned address 5
hub.c: USB hub found
hub.c: 3 ports detected
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
hub.c: new USB device 00:02.0-2, assigned address 6
input0: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb1:6.0
hub.c: new USB device 00:02.0-1.1, assigned address 7
input1: USB HID v1.10 Keyboard [045e:001d] on usb1:7.0
input2: USB HID v1.10 Pointer [045e:001d] on usb1:7.1
hub.c: new USB device 00:02.1-1, assigned address 3
usb.c: USB device 3 (vend/prod 0x46d/0x840) is not claimed by any active driver.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
[fglrx] Maximum main memory to use for locked dma buffers: 927 MBytes.
[fglrx] module loaded - fglrx 2.9.13 [Jun 12 2003] on minor 0
Fire GL built-in AGP-support
Based on agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 512M @ 0xa0000000
[fglrx] AGP detected, AgpState   = 0x1f000217 (hardware caps of chipset)
AGP: Found 2 AGPv2 devices
AGP: Doing enable for AGPv2
[fglrx] To use AGP on this CPU with this kernel, you really should have 4MB pages disabled. Use `mem=nopentium` on the bootloader commandline.
[fglrx] AGP enabled,  AgpCommand = 0x1f000314 (selected caps)
[fglrx] free  AGP = 524562432
[fglrx] max   AGP = 524562432
[fglrx] free  LFB = 49283072
[fglrx] max   LFB = 49283072
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
keyboard: Timeout - AT keyboard not present?(f4)
mtrr: no MTRR for c0000000,400000 found
mtrr: no MTRR for c0400000,200000 found
mtrr: no MTRR for c0600000,100000 found
[fglrx] free  AGP = 524562432
[fglrx] max   AGP = 524562432
[fglrx] free  LFB = 49283072
[fglrx] max   LFB = 49283072
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)
mtrr: no MTRR for c0000000,400000 found
mtrr: no MTRR for c0400000,200000 found
mtrr: no MTRR for c0600000,100000 found
[fglrx] module unloaded - fglrx 2.9.13 [Jun 12 2003] on minor 0
[fglrx] Maximum main memory to use for locked dma buffers: 927 MBytes.
[fglrx] module loaded - fglrx 2.9.13 [Jun 12 2003] on minor 0
Fire GL built-in AGP-support
Based on agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 512M @ 0xa0000000
[fglrx] AGP detected, AgpState   = 0x1f000217 (hardware caps of chipset)
AGP: Found 2 AGPv2 devices
AGP: Doing enable for AGPv2
[fglrx] To use AGP on this CPU with this kernel, you really should have 4MB pages disabled. Use `mem=nopentium` on the bootloader commandline.
[fglrx] AGP enabled,  AgpCommand = 0x1f000314 (selected caps)
[fglrx] free  AGP = 524562432
[fglrx] max   AGP = 524562432
[fglrx] free  LFB = 49283072
[fglrx] max   LFB = 49283072
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-2.4.txt"

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at a0000000 (32-bit, prefetchable) [size=512M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Giga-byte Technology: Unknown device 0c11
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Giga-byte Technology: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at dc00 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ce087000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at ce082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at ce083000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Giga-byte Technology: Unknown device e000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ce086000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
	Subsystem: nVidia Corporation: Unknown device 0c11
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ce000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: nVidia Corporation: Unknown device 4144
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e400 [size=256]
	Region 1: I/O ports at d000 [size=128]
	Region 2: Memory at ce080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00008000-0000afff
	Memory behind bridge: cc000000-cdffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology: Unknown device 5002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ce084000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ce085000 (32-bit, non-prefetchable) [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ca000000-cbffffff
	Prefetchable memory behind bridge: c0000000-c7ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
	Subsystem: Adaptec AHA-2940U2W SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at 8000 [disabled] [size=256]
	Region 1: Memory at cd020000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 3013
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at cd000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 8400 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at cb000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] (Secondary) (rev 01)
	Subsystem: ATI Technologies Inc: Unknown device 0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at c4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at cb010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aic7xxx-proc.txt"
Content-Transfer-Encoding: quoted-printable

Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TW   Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Adaptec AIC7xxx driver version: 6.2.8
aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

Serial EEPROM:
0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb=20
0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb=20
0xb8e4 0x745d 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff=20
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x0250 0x934e=20

Channel A Target 0 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
	Goal: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
	Curr: 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
	Channel A Target 0 Lun 0 Settings
		Commands Queued 11825
		Commands Active 0
		Command Openings 8
		Max Tagged Openings 8
		Device Queue Frozen Count 0
Channel A Target 1 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
	Channel A Target 3 Lun 0 Settings
		Commands Queued 36
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
	Goal: 20.000MB/s transfers (20.000MHz, offset 16)
	Curr: 20.000MB/s transfers (20.000MHz, offset 16)
	Channel A Target 4 Lun 0 Settings
		Commands Queued 3
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 5 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 255, 16bit)

--EeQfGwPcQSOJBaQU--

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LY0zIymMQsXoRDARAtBxAKCGZqqBM1N+/Q+xCTElytqADxSq6gCffTCo
elaTxPqTYCJ4/vvsBN/ALCU=
=DEkY
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
