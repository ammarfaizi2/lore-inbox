Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbTIWNv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTIWNv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:51:58 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:12525 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id S263367AbTIWNvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:51:46 -0400
Message-ID: <3F704FAF.8050000@daniel-luebke.de>
Date: Tue, 23 Sep 2003 15:50:39 +0200
From: Daniel Luebke <lkml@daniel-luebke.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: de-de, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System Freeze with Kernel 2.6.0-test5 and PCMCIA 3Com
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080607080208030100080501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607080208030100080501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody!

I just wanted to give the Kernel 2.6-test series a try and 
(un)fortunately I might be able to help by reporting a bug:
I'm using a HP Omnibook XE3, PIII, 256MB RAM, running without any 
problems under 2.4.21 (Debian/unstable).
However, when using 2.6.0-test5 and inserting a PCMCIA card, namely a 
3COM NIC (3CSH572BT, whoever invents such model names...), my system 
freezes without kernel oops (no flashing lights etc.) but only printing 
the line
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff

I attached the information about my system both for 2.4.21 (with 
inserted card) and for the 2.6 (obviously without card :-)

If some more information is needed please mail me.

With best regards

Daniel Luebke

--------------080607080208030100080501
Content-Type: text/plain;
 name="dmesg-2.4.21.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4.21.txt"

Linux version 2.4.21-5-686 (herbert@gondolin) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Sun Aug 24 15:25:33 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=302
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 696.977 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 253332k/262080k available (1052k kernel code, 8360k reserved, 398k data, 104k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9be, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 00:04.1
PCI: Sharing IRQ 11 with 01:01.0
PCI: Cannot allocate resource region 4 of device 00:07.1
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3420 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
Freeing initrd memory: 3420k freed
VFS: Mounted root (cramfs filesystem).
Freeing unused kernel memory: 104k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
blk: queue d08276c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
Journalled Block Device driver loaded
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=19485/16/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1222/255/63] p1 p2 p3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 144576k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Real Time Clock Driver v1.10e
maestro3: version 1.23 built at 16:07:10 Aug 24 2003
PCI: Found IRQ 5 for device 00:08.0
PCI: Sharing IRQ 5 with 00:08.1
maestro3: Configuring ESS Allegro found at IO 0x1400 IRQ 5
maestro3:  subvendor id: 0x0012103c
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 5 for device 00:07.2
uhci.c: USB UHCI at I/O 0x1060, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Intel PCIC probe: not found.
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 00:04.1
PCI: Sharing IRQ 11 with 01:01.0
PCI: Found IRQ 11 for device 00:04.1
PCI: Sharing IRQ 11 with 00:04.0
PCI: Sharing IRQ 11 with 01:01.0
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x158-0x15f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: OfficeConnect 572B at io 0x300, irq 3, hw_addr 00:00:86:5E:2C:E6.
  ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.
eth0: found link beat
eth0: autonegotiation complete: 100baseT-FD selected
spurious 8259A interrupt: IRQ7.

--------------080607080208030100080501
Content-Type: text/plain;
 name="dmesg-2.6.0-test5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.0-test5.txt"

Linux version 2.6.0-test5-mm3 (root@cypher) (gcc version 3.3.2 20030908 (Debian prerelease)) #2 Tue Sep 23 15:14:56 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=DesktopLinux root=302
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
current: c028f9c0
current->thread_info: c02ee000
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.117 MHz processor.
Console: colour VGA+ 80x25
Memory: 256432k/262080k available (1327k kernel code, 4924k reserved, 647k data, 112k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 1376.25 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9be, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:04.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:04.1
PCI: Sharing IRQ 11 with 0000:01:01.0
PCI: Cannot allocate resource region 4 of device 0000:00:07.1
pty: 256 Unix98 ptys configured
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: IBM-DJSA-210, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=19485/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
NET: Registered protocol family 1
Adding 144576k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Real Time Clock Driver v1.12
NET: Registered protocol family 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:00:04.1
PCI: Sharing IRQ 11 with 0000:01:01.0
Yenta: CardBus bridge found at 0000:00:04.0 [103c:0014]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0698, PCI irq11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:04.1
PCI: Sharing IRQ 11 with 0000:00:04.0
PCI: Sharing IRQ 11 with 0000:01:01.0
Yenta: CardBus bridge found at 0000:00:04.1 [103c:0014]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 0698, PCI irq11
Socket status: 30000006
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02c63a0(lo)
IPv6 over IPv4 tunneling driver

--------------080607080208030100080501
Content-Type: text/plain;
 name="lspci-2.4.21.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2.4.21.txt"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1420
00:04.1 CardBus bridge: Texas Instruments PCI1420
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
01:01.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 11)

--------------080607080208030100080501
Content-Type: text/plain;
 name="lspci-2.6.0-test5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2.6.0-test5.txt"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1420
00:04.1 CardBus bridge: Texas Instruments PCI1420
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
00:08.1 Communication controller: ESS Technology ESS Modem (rev 12)
01:01.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 11)

--------------080607080208030100080501
Content-Type: text/plain;
 name="proc_bus_pccard_drivers-2.4.21.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_bus_pccard_drivers-2.4.21.txt"

3c574_cs                 0 1

--------------080607080208030100080501
Content-Type: text/plain;
 name="proc_interrupts-2.4.21.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_interrupts-2.4.21.txt"

           CPU0       
  0:      29942          XT-PIC  timer
  1:        708          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      61277          XT-PIC  3c574_cs
  5:       6205          XT-PIC  Allegro, usb-uhci
  8:          4          XT-PIC  rtc
 11:          0          XT-PIC  Texas Instruments PCI1420, Texas Instruments PCI1420 (#2)
 12:       1502          XT-PIC  PS/2 Mouse
 14:      13333          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:         22
MIS:          0

--------------080607080208030100080501
Content-Type: text/plain;
 name="proc_interrupts-2.6.0.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_interrupts-2.6.0.txt"

           CPU0       
  0:     104032          XT-PIC  timer
  1:        258          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
 11:          0          XT-PIC  yenta, yenta
 12:         26          XT-PIC  i8042
 14:      91232          XT-PIC  ide0
 15:         10          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

--------------080607080208030100080501
Content-Type: text/plain;
 name="uname-2.4.21.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uname-2.4.21.txt"

Linux cypher 2.4.21-5-686 #1 Sun Aug 24 15:25:33 EST 2003 i686 GNU/Linux

--------------080607080208030100080501
Content-Type: text/plain;
 name="uname-2.6.0-test5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uname-2.6.0-test5.txt"

Linux cypher 2.6.0-test5-mm3 #2 Tue Sep 23 15:14:56 CEST 2003 i686 GNU/Linux

--------------080607080208030100080501--

