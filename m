Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUBKJLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 04:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUBKJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 04:11:14 -0500
Received: from tuxhome.net ([217.160.179.19]:22470 "EHLO tuxhome.net")
	by vger.kernel.org with ESMTP id S263793AbUBKJK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 04:10:56 -0500
From: Markus Hofmann <markus@gofurther.de>
Organization: gofurther.de
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.2 - System clock runs too fast
Date: Wed, 11 Feb 2004 10:07:50 +0100
User-Agent: KMail/1.6
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200402101332.26552.markus@gofurther.de> <1076442533.1351.35.camel@cog.beaverton.ibm.com>
In-Reply-To: <1076442533.1351.35.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402111007.50549.markus@gofurther.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John

Thank you for answering.
In the meantime I heard that apm could cause this problem. I tested this by 
compiling acpi. The result was that the clock runs normal with acpi.
But I want to use apm. So I removed the acpi and now the system clock is too 
slow with only apm.

I think this is a very curious thing! :-(

Here is my dmegs output:

Wed Feb 11 09:47:01 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7e000 (ACPI data)
 BIOS-e820: 000000001ff7e000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux2.6.2 ro root=301 hdc=ide-scsi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1998.471 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514844k/523712k available (1803k kernel code, 8120k reserved, 787k 
data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3948.54 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7070
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9d7e, dseg 0x400
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: match found with the PnP device '00:0e' and the driver 'system'
PnPBIOS: 21 nodes reported by PnP BIOS; 21 recorded by driver
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 09 [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/248c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 6 for device 0000:00:1f.1
PCI: Sharing IRQ 6 with 0000:00:1d.2
PCI: Sharing IRQ 6 with 0000:02:00.2
PCI: Sharing IRQ 6 with 0000:02:02.0
radeonfb_pci_register BEGIN
PCI: Found IRQ 9 for device 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:02:00.0
radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch = 1000044
radeonfb: panel ID string: 1600x1200
radeonfb: detected DFP panel size from BIOS: 1600x1200
radeonfb: ATI Radeon M7 LX DDR SGRAM 64 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
NTFS driver 2.1.6 [Flags: R/W DEBUG].
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
hStart = 1656, hEnd = 1848, hTotal = 2160
vStart = 1200, vEnd = 1203, vTotal = 1250
h_total_disp = 0xc7010d    hsync_strt_wid = 0x980672
v_total_disp = 0x4af04e1           vsync_strt_wid = 0x8304af
post div = 0x1
fb_div = 0x48
ppll_div_3 = 0x48
ron = 1568, roff = 16184
vclk_freq = 16200, per = 578
Console: switching to colour frame buffer device 200x75
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 6 for device 0000:00:1f.1
PCI: Sharing IRQ 6 with 0000:00:1d.2
PCI: Sharing IRQ 6 with 0000:02:00.2
PCI: Sharing IRQ 6 with 0000:02:02.0
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4160N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3
Console: switching to colour frame buffer device 200x75
Intel ISA PCIC probe: <6>pnp: Device 00:19 activated.

  Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (default) = 3,4,5,7,9,10,11,12 polling interval = 1000 ms
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 10.12.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 
2003 UTC).
PCI: Found IRQ 5 for device 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.6
PCI: Sharing IRQ 5 with 0000:02:00.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0x1c00, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 982792k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 10 for device 0000:02:08.0
eth0: 0000:02:08.0, 00:02:8A:36:97:19, IRQ 10.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Bluetooth: Core ver 2.3
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
NET: Registered protocol family 23
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:16' and the driver 'parport_pc'
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as 
device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: RW/DVD GCC-4160N  Rev: 0013
  Type:   CD-ROM                             ANSI SCSI revision: 02
orinoco_pci.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> & Jean 
Tourrilhes <jt@hpl.hp.com>)
PCI: Found IRQ 6 for device 0000:02:02.0
PCI: Sharing IRQ 6 with 0000:00:1d.2
PCI: Sharing IRQ 6 with 0000:00:1f.1
PCI: Sharing IRQ 6 with 0000:02:00.2
Detected Orinoco/Prism2 PCI device at 0000:02:02.0, mem:0xF8000000 to 
0xF8000FFF -> 0xe4912000, irq:6
Reset 
done....................................................................................................................................................................................................................................................;
Clear 
Reset........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFBAEC0 - FFFBACCC
eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.3.6
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:20:E0:8F:A0:87
eth1: Station name "Prism  I"
eth1: ready
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring 
Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 
3.5
drivers/usb/core/usb.c: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 6 for device 0000:02:00.2
PCI: Sharing IRQ 6 with 0000:00:1d.2
PCI: Sharing IRQ 6 with 0000:00:1f.1
PCI: Sharing IRQ 6 with 0000:02:02.0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[6]  MMIO=[d0201000-d02017ff]  
Max Packet=[2048]
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
PCI: Found IRQ 9 for device 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:02:00.0
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.1
uhci_hcd 0000:00:1d.1: UHCI Host Controller
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b0010046c1e]
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 6 for device 0000:00:1d.2
PCI: Sharing IRQ 6 with 0000:00:1f.1
PCI: Sharing IRQ 6 with 0000:02:00.2
PCI: Sharing IRQ 6 with 0000:02:02.0
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 6, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.1
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
hub 2-0:1.0: new USB device on port 1, assigned address 2
input: USB HIDBP Mouse 04b3:3107 on usb-0000:00:1d.1-1
PCI: Found IRQ 9 for device 0000:02:00.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0185]
Yenta: ISA IRQ mask 0x0098, PCI irq 9
Socket status: 30000006
PCI: Found IRQ 5 for device 0000:02:00.1
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.6
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0185]
Yenta: ISA IRQ mask 0x0098, PCI irq 5
Socket status: 30000006
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
eth1: New link status: Association Failed (0006)
eth1: New link status: Connected (0001)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x3c0-0x3e7 0x3f8-0x3ff
cs: IO port probe 0x0a00-0x0aff: clean.
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
PCI: Found IRQ 9 for device 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:00:1d.0
PCI: Sharing IRQ 9 with 0000:02:00.0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
spurious 8259A interrupt: IRQ7.
----------------------

Am Dienstag, 10. Februar 2004 20:48 schrieb john stultz:
> On Tue, 2004-02-10 at 04:32, Markus Hofmann wrote:
> > Hello together
> >
> > I've a problem with my system clock. It runs too fast. In realtime 5
> > minutes my notebook runs 8 minutes. The BIOS-Time doesn't run.
> > With kernel 2.4.24 everything is ok but when I boot my new 2.6.2 the
> > clock runs.
> >
> > Could it be that the compiled speedstepping caused this problem?
> > Or is there an another causing?
>
> Could you send me your dmesg?
>
> thanks
> -john
