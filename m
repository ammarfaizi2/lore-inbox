Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUEPTGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUEPTGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbUEPTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:06:49 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:10898 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264788AbUEPTGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:06:05 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Sun, 16 May 2004 21:06:26 +0200
User-Agent: KMail/1.6.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
References: <200405161222.48581.lkml@kcore.org> <200405161218.37521.dtor_core@ameritech.net>
In-Reply-To: <200405161218.37521.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yu7pAsLUdn86txP"
Message-Id: <200405162106.29858.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yu7pAsLUdn86txP
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 16 May 2004 19:18, Dmitry Torokhov wrote:
> Hmm.. there was no changes to PS/2 processing between 2.6.5 and 2.6.6
> except for some Logitech tweaking, but it should not affect Synaptics
> handling in any way...
>
> Could you check if you still have DMA enabled on your disks, check your
> time source (TSC, ACPI PM timer, etc) and probably boot with acpi off?
>
> Thank you.

Dmitry,

Booting with acpi=off fixes the problem, although I'm curious to what the
problem actually is.

I've attached the dmesgs from 2.6.6, 2.6.5, and 2.6.6 with acpi=off.

There is a line that says "Invalid control registers" that I wonder where it
comes from, but you might see something more here than I do.

Jan

- --
Your boss climbed the corporate ladder, wrong by wrong.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp7u0UQQOfidJUwQRAg2LAJ4h/azGgeCPVcW3ysd9kWr4TAqoVwCfWVgw
icYQJ0Nnp90bKBy1JYYdmVo=
=T0l7
-----END PGP SIGNATURE-----

--Boundary-00=_yu7pAsLUdn86txP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.5"

Linux version 2.6.5 (root@precious) (gcc version 3.3.3 (Debian 20040401)) #1 Sun Apr 11 16:10:28 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
ACPI: RSDT (v001 ACER   Cardinal 0x20020302  LTP 0x00000000) @ 0x1ff74c20
ACPI: FADT (v001 ACER   Cardinal 0x20020302 PTL  0x0000001e) @ 0x1ff7af64
ACPI: BOOT (v001 ACER   Cardinal 0x20020302  LTP 0x00000001) @ 0x1ff7afd8
ACPI: DSDT (v001 ACER   Cardinal 0x20020302 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=LinuxOLD ro root=306
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1599.398 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514300k/523712k available (2356k kernel code, 8640k reserved, 795k data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3162.11 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: AUO                     
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Simple Boot Flag at 0x37 set to 0x1
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
ikconfig 0.7 with /proc/config*
SGI XFS with no debug enabled
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (47 C)
Console: switching to colour frame buffer device 175x65
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 128k freed
blk: queue dfd11e00, I/O limit 4095Mb (mask 0xffffffff)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
SCSI subsystem initialized
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
input: PC Speaker
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 296 bytes per conntrack
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB2
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e18f4000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Intel 810 + AC97 Audio, version 0.24, 16:12:54 Apr 11 2004
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xd0000c00 and 0xd0000800, IRQ 10
i810: Intel ICH4 mmio at 0xe1937c00 and 0xe1955800
usb 2-1: new low speed USB device using address 2
drivers/usb/core/usb.c: registered new driver hiddev
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG64 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 48566
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
slamr: module license 'Smart Link Ltd.' taints kernel.
slamr: SmartLink AMRMO modem.
slamr: probe 8086:24c6 ICH4 card...
PCI: Setting latency timer of device 0000:00:1f.6 to 64
slamr: mc97 codec is SIL27
slamr: slamr0 is ICH4 card.
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:28:11:ca
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:06.0 [1025:001f]
Yenta: ISA IRQ mask 0x0898, PCI irq 10
Socket status: 30000006
PCI: Enabling device 0000:02:06.1 (0080 -> 0082)
Yenta: CardBus bridge found at 0000:02:06.1 [1025:001f]
Yenta: ISA IRQ mask 0x0898, PCI irq 10
Socket status: 30000410
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1172 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0209000-d02097ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000c8dfa]
b44: eth0: Link is down.
irda_init()
NET: Registered protocol family 23
nsc-ircc, Found chip at base=0x04e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Found dongle: HP HSDL-1100/HSDL-2100
irlap_change_speed(), setting speed to 9600
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=44 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=32768 DPT=7741 LEN=24 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.0 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=ICMP TYPE=8 CODE=0 ID=33030 SEQ=0 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=255 DF PROTO=ICMP TYPE=8 CODE=0 ID=33030 SEQ=0 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=96 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=76 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=96 TOS=0x00 PREC=0x00 TTL=64 ID=1 DF PROTO=UDP SPT=137 DPT=137 LEN=76 

--Boundary-00=_yu7pAsLUdn86txP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.6"

Linux version 2.6.6 (root@precious) (gcc version 3.3.3 (Debian 20040429)) #1 Mon May 10 12:58:40 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
ACPI: RSDT (v001 ACER   Cardinal 0x20020302  LTP 0x00000000) @ 0x1ff74c20
ACPI: FADT (v001 ACER   Cardinal 0x20020302 PTL  0x0000001e) @ 0x1ff7af64
ACPI: BOOT (v001 ACER   Cardinal 0x20020302  LTP 0x00000001) @ 0x1ff7afd8
ACPI: DSDT (v001 ACER   Cardinal 0x20020302 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=306
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1598.972 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515332k/523712k available (2334k kernel code, 7612k reserved, 801k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3162.11 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12) *10
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 12
PCI: Using ACPI for IRQ routing
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: AUO                     
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Simple Boot Flag at 0x37 set to 0x1
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
SGI XFS with no debug enabled
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (31 C)
Console: switching to colour frame buffer device 175x65
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 132k freed
blk: queue c1528800, I/O limit 4095Mb (mask 0xffffffff)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
Invalid control/status registers
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
SCSI subsystem initialized
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
input: PC Speaker
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 296 bytes per conntrack
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using address 2
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB2
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e18f2000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
usb 2-1: unable to read config index 0 descriptor
usb 2-1: can't read configurations, error -71
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Intel 810 + AC97 Audio, version 0.24, 13:01:14 May 10 2004
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xd0000c00 and 0xd0000800, IRQ 10
i810: Intel ICH4 mmio at 0xe1911c00 and 0xe1946800
usb 2-1: new low speed USB device using address 3
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG64 (Unknown)
usbcore: registered new driver hiddev
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 48546
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
slamr: module license 'Smart Link Ltd.' taints kernel.
slamr: SmartLink AMRMO modem.
slamr: probe 8086:24c6 ICH4 card...
PCI: Setting latency timer of device 0000:00:1f.6 to 64
slamr: mc97 codec is SIL27
slamr: slamr0 is ICH4 card.
b44.c:v0.93 (Mar, 2004)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:28:11:ca
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:06.0 [1025:001f]
Yenta: ISA IRQ mask 0x0898, PCI irq 10
Socket status: 30000006
PCI: Enabling device 0000:02:06.1 (0080 -> 0082)
Yenta: CardBus bridge found at 0000:02:06.1 [1025:001f]
Yenta: ISA IRQ mask 0x0898, PCI irq 10
Socket status: 30000410
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0209000-d02097ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000c8dfa]
b44: eth0: Link is down.
irda_init()
NET: Registered protocol family 23
nsc-ircc, Found chip at base=0x04e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Found dongle: HP HSDL-1100/HSDL-2100
irlap_change_speed(), setting speed to 9600
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=44 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=32768 DPT=7741 LEN=24 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.0 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=ICMP TYPE=8 CODE=0 ID=23815 SEQ=0 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=255 DF PROTO=ICMP TYPE=8 CODE=0 ID=23815 SEQ=0 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=96 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=76 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=96 TOS=0x00 PREC=0x00 TTL=64 ID=1 DF PROTO=UDP SPT=137 DPT=137 LEN=76 
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.40-pre
ipw2100: Copyright(c) 2003-2004 Intel Corporation
Detected ipw2100 PCI device at 0000:02:04.0, dev: eth1, mem: 0xD0206000-0xD0206FFF -> e19e8000, irq: 12
eth1: Using hotplug firmware load.
ipw2100: Associated with 'wirelessrouter' at 11Mbps, channel 6
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

--Boundary-00=_yu7pAsLUdn86txP
Content-Type: text/plain;
  charset="iso-8859-1";
  name="2.6.6-noacpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.6-noacpi"

Linux version 2.6.6 (root@precious) (gcc version 3.3.3 (Debian 20040429)) #1 Mon May 10 12:58:40 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=306 acpi=off
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1598.729 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515332k/523712k available (2334k kernel code, 7612k reserved, 801k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3153.92 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24cc] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:02:07.0
PCI: IRQ 0 for device 0000:02:06.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:06.2
PCI: Found IRQ 10 for device 0000:01:00.0
PCI: Sharing IRQ 10 with 0000:00:1d.0
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: AUO                     
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
SGI XFS with no debug enabled
Console: switching to colour frame buffer device 175x65
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:02:07.0
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 132k freed
blk: queue c1550800, I/O limit 4095Mb (mask 0xffffffff)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
SCSI subsystem initialized
input: PS/2 Generic Mouse on isa0060/serio1
input: PC Speaker
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 296 bytes per conntrack
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:1d.0
PCI: Sharing IRQ 10 with 0000:01:00.0
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 5 for device 0000:00:1d.1
PCI: Sharing IRQ 5 with 0000:02:02.0
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:07.0
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using address 2
PCI: Found IRQ 10 for device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB USB2
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e18e6000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
usb 2-1: USB disconnect, address 2
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
Intel 810 + AC97 Audio, version 0.24, 13:01:14 May 10 2004
PCI: Found IRQ 10 for device 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:06.2
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH4 found at IO 0x18c0 and 0x1c00, MEM 0xd0000c00 and 0xd0000800, IRQ 10
i810: Intel ICH4 mmio at 0xe1905c00 and 0xe193a800
usb 2-1: new low speed USB device using address 3
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG64 (Unknown)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 48689
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:06.2
slamr: module license 'Smart Link Ltd.' taints kernel.
slamr: SmartLink AMRMO modem.
slamr: probe 8086:24c6 ICH4 card...
PCI: Found IRQ 10 for device 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:06.2
PCI: Setting latency timer of device 0000:00:1f.6 to 64
slamr: mc97 codec is SIL27
slamr: slamr0 is ICH4 card.
b44.c:v0.93 (Mar, 2004)
PCI: Found IRQ 5 for device 0000:02:02.0
PCI: Sharing IRQ 5 with 0000:00:1d.1
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:28:11:ca
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:02:06.2
Yenta: CardBus bridge found at 0000:02:06.0 [1025:001f]
Yenta: ISA IRQ mask 0x0a98, PCI irq 10
Socket status: 30000006
PCI: Enabling device 0000:02:06.1 (0080 -> 0082)
PCI: Found IRQ 10 for device 0000:02:06.1
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1f.5
PCI: Sharing IRQ 10 with 0000:00:1f.6
PCI: Sharing IRQ 10 with 0000:02:06.0
PCI: Sharing IRQ 10 with 0000:02:06.2
Yenta: CardBus bridge found at 0000:02:06.1 [1025:001f]
Yenta: ISA IRQ mask 0x0a98, PCI irq 10
Socket status: 30000410
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
PCI: Found IRQ 10 for device 0000:02:07.0
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0209000-d02097ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000c8dfa]
b44: eth0: Link is down.
irda_init()
NET: Registered protocol family 23
nsc-ircc, Found chip at base=0x04e
nsc-ircc, driver loaded (Dag Brattli)
IrDA: Registered device irda0
nsc-ircc, Found dongle: HP HSDL-1100/HSDL-2100
irlap_change_speed(), setting speed to 9600
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=44 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=32768 DPT=7741 LEN=24 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.0 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=ICMP TYPE=8 CODE=0 ID=33287 SEQ=0 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=255 DF PROTO=ICMP TYPE=8 CODE=0 ID=33287 SEQ=0 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=96 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=137 DPT=137 LEN=76 
Bad packet from eth0:IN=eth0 OUT= MAC= SRC=192.168.0.40 DST=192.168.0.255 LEN=96 TOS=0x00 PREC=0x00 TTL=64 ID=1 DF PROTO=UDP SPT=137 DPT=137 LEN=76 
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
PCI: Found IRQ 10 for device 0000:01:00.0
PCI: Sharing IRQ 10 with 0000:00:1d.0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
PCI: Found IRQ 10 for device 0000:01:00.0
PCI: Sharing IRQ 10 with 0000:00:1d.0
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

--Boundary-00=_yu7pAsLUdn86txP--
