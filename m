Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTA2UCE>; Wed, 29 Jan 2003 15:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTA2UCE>; Wed, 29 Jan 2003 15:02:04 -0500
Received: from sccmmhc02.mchsi.com ([204.127.203.184]:60603 "EHLO
	sccmmhc02.mchsi.com") by vger.kernel.org with ESMTP
	id <S267198AbTA2UCA>; Wed, 29 Jan 2003 15:02:00 -0500
From: Chuck Burns <zex0s@mchsi.com>
To: linux-kernel@vger.kernel.org
Subject: failure of 3c556b and 2.4.21pre3 with attached files
Date: Wed, 29 Jan 2003 14:11:16 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kVDO+kWpOl8lGYn"
Message-Id: <200301291411.16783.zex0s@mchsi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_kVDO+kWpOl8lGYn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, January 28 2003 8:09 pm, you wrote:
> Chuck Burns <zex0s@mchsi.com> wrote:
> > Having recently upgraded my Mandrake 9.0 Laptop to the latest Mandrake
> > cooker (9.1beta) it uses the 2.4.21pre3 kernel.  A problem has occured
> > somewhere between 2.4.19 and 2.4.21pre3, with regards to the 3c59x driver
> > module.  It incorrectly returns the MAC address for my IBM Thinkpad a20m
> > with 3com integrated PCI 10/100M ethernet/Modem combo card. (the Nic is a
> > 3com 3c556b, which is supported under the 3c59x module)  The 2.4.19
> > kernel module accurately reports the MAC address.
> >
> > The 2.4.21pre3 MAC address reported for my card is FF:FF:FF:FF:FF:FF,
> > which, obviously, is incorrect.  I have never submitted a bug report
> > before, so I am not quite sure what all information you need.. there is
> > no error message associated with this
>
> Yup, seen a couple of these.  It appears that the PCI and/or Cardbus code
> broke the 3com driver.
>
> Please send the full `dmesg' output so we can see the kernel boot messages
> and also the `lspci -vx -s' output for that device.
Attached are files with the output of:
/proc/cpuinfo
dmesg
lspcidrake -f -v (thats the closest thing to lspci I have.. the -f -v says do 
a full probe, and be verbose.. if thats not enough info, I will try to find 
sources versions of the lspcitools and compile them....)

-- 
Chuck Burns, Jr <zex0s@mchsi.com>
-----------==========-----------
When the cup is full, carry it level.
-- 
Chuck Burns, Jr <zex0s@mchsi.com>
-----------===========-----------
Yow!  I want my nose in lights!

--Boundary-00=_kVDO+kWpOl8lGYn
Content-Type: text/plain;
  charset="us-ascii";
  name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cpuinfo"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 1
cpu MHz		: 498.787
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 996.14


--Boundary-00=_kVDO+kWpOl8lGYn
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg"

Linux version 2.4.21pre3-2mdk (quintela@bi.mandrakesoft.com) (gcc version 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk)) #1 Thu Jan 23 23:18:06 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bffec00 (ACPI data)
 BIOS-e820: 000000000bffec00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
191MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6b30
ACPI: RSDT (v001 PTLTD    RSDT   01540.04384) @ 0x0bff596d
ACPI: FADT (v001 IBM    TP-A20M  01540.04384) @ 0x0bffeb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.04384) @ 0x0bffebd9
ACPI: DSDT (v001 IBM    TP A20m  01540.04384) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: BOOT_IMAGE=linux ro root=302 devfs=mount
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 498.794 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 996.14 BogoMIPS
Memory: 191632k/196544k available (1330k kernel code, 4524k reserved, 512k data, 144k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021212
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
    ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PSER] (off)
ACPI: Power Resource [PSIO] (on)
ACPI: Embedded Controller [EC] (gpe 9)
schedule_task(): keventd has not started
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DARA-206000, ATA DISK drive
blk: queue c0325100, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA CD-ROM XM-7002B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 11733120 sectors (6007 MB) w/418KiB Cache, CHS=776/240/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 82k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 23:52:44 Jan 23 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usbdevfs: remount parameter error
hub.c: new USB device 00:07.2-1, assigned address 2
ide: no cache flush required.
ide: no cache flush required.
usb.c: USB device 2 (vend/prod 0x47d/0x101f) is not claimed by any active driver.
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 514040k swap-space (priority -1)
usb.c: registered new driver usb_mouse
input0: Kensington Kensington PocketMouse Pro on usb1:2.0
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
PCI: Enabling device 00:03.0 (0000 -> 0003)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1400. Vers LK1.1.16
PCI: Setting latency timer of device 00:03.0 to 64
eth0: command 0x5800 did not complete! Status=0xffff
eth0: command 0x2804 did not complete! Status=0xffff
Linux Kernel Card Services Kernel Version
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
lp0: using parport0 (polling).

--Boundary-00=_kVDO+kWpOl8lGYn
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci"

agpgart         : Intel Corporation|440BX/ZX - 82443BX/ZX Host bridge [BRIDGE_HOST] (vendor:8086 device:7190)
unknown         : Intel Corporation|440BX/ZX - 82443BX/ZX AGP bridge [BRIDGE_PCI] (vendor:8086 device:7191)
yenta_socket    : Texas Instruments|PCI1221 PC card CardBus Controller [BRIDGE_CARDBUS] (vendor:104c device:ac1b subv:4000 subd:0000)
yenta_socket    : Texas Instruments|PCI1221 PC card CardBus Controller [BRIDGE_CARDBUS] (vendor:104c device:ac1b subv:4800 subd:0000)
3c59x           : 3Com Corporation|3C556 10/100 Mini PCI Fast Ethernet Adapter [NETWORK_ETHERNET] (vendor:10b7 device:6056 subv:10b7 subd:6356)
unknown         : 3Com Corporation|3C556 V.90 Mini-PCI Modem [COMMUNICATION_OTHER] (vendor:10b7 device:1007 subv:10b7 subd:6159)
snd-cs46xx      : Cirrus Logic|CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] [MULTIMEDIA_AUDIO] (vendor:1013 device:6003 subv:1014 subd:0153)
unknown         : Intel Corporation|82371AB PIIX4 ISA [BRIDGE_OTHER] (vendor:8086 device:7110)
unknown         : Intel Corporation|82371AB PIIX4 IDE [STORAGE_IDE] (vendor:8086 device:7111)
usb-uhci        : Intel Corporation|82371AB PIIX4 USB [SERIAL_USB] (vendor:8086 device:7112)
sonypi          : Intel Corporation|82371AB PIIX4 ACPI - Bus Master IDE Controller [BRIDGE_OTHER] (vendor:8086 device:7113)
Card:ATI Rage Mobility: ATI|Rage Mobility P/M AGP 2x [DISPLAY_VGA] (vendor:1002 device:4c4d subv:1014 subd:0154)
unknown         : Unknown|USB UHCI Root Hub [Hub|Root Hub] (vendor:0000 device:0000)
unknown         : Kensington|Kensington PocketMouse Pro [Human Interface Devices|Boot Interface Subclass|Mouse] (vendor:047d device:101f)

--Boundary-00=_kVDO+kWpOl8lGYn--

