Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbTIZSbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIZSbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:31:16 -0400
Received: from xs.heimsnet.is ([193.4.194.50]:2465 "EHLO cg.c.is")
	by vger.kernel.org with ESMTP id S261554AbTIZSat convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:30:49 -0400
From: =?iso-8859-1?q?B=F6rkur=20Ingi=20J=F3nsson?= <bugsy@isl.is>
Reply-To: bugsy@isl.is
To: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Date: Fri, 26 Sep 2003 18:43:10 +0000
User-Agent: KMail/1.5.3
References: <200309261724.56616.bugsy@isl.is> <200309261827.28606.bugsy@isl.is> <20030926182229.GA17041@kroah.com>
In-Reply-To: <20030926182229.GA17041@kroah.com>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309261843.10099.bugsy@isl.is>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 September 2003 18:22, you wrote:
> On Fri, Sep 26, 2003 at 06:27:28PM +0000, Börkur Ingi Jónsson wrote:
> >  Friday 26 September 2003 18:03, you wrote:
> > > On Fri, Sep 26, 2003 at 05:24:56PM +0000, Börkur Ingi Jónsson wrote:
> > > > Ps. in english this means that. On my computer khubd is using 100% of
> > > > my cpu... any fix on this?
> > >
> > > As I asked for in your bugzilla.kernel.org filing, what does the kernel
> > > log showing?  Is there lots of USB activity?  Are there any USB devices
> > > plugged into the system?  Does this also happen for 2.4?  Are you using
> > > ACPI?  (I can go on, but that's a good start.  You need to provide a
> > > much better bug report than this...)
> > >
> > > greg k-h
> >
> > Ok Hi,
> >
> > I sent an earlier email (
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0409.html )
> > asking what kind of info dev's wanted for a report and where I could get
> > it.
> >
> > 1. Where can I find the kernel log?
>
> Run 'dmesg'

O.k  dmesg gave me this : 

Linux version 2.6.0-test5 (root@localhost) (gcc version 3.2.3 20030422 (Gentoo 
Linux 1.4 3.2.3-r1, propolice)) #3 Fri Sep 26 01:39:31 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AWARD                                     ) @ 0x000f76d0
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x2fff3040
ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root /dev/hda3
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1395.209 MHz processor.
Console: colour VGA+ 80x25
Memory: 773680k/786368k available (2766k kernel code, 11896k reserved, 973k 
data, 136k init, 0k highmem)
Calibrating delay loop... 2744.32 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb130, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15, enabled at 
IRQ 9)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
Applying VIA southbridge workaround.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
parport_pc: Via 686A parallel port: io=0x378
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xec00. Vers LK1.1.19
eth0: Dropping NETIF_F_SG since no checksum feature.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdd: CD-ROM 56X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 56X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 9, io base 0000d400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:07.3: UHCI Host Controller
uhci-hcd 0000:00:07.3: irq 9, io base 0000d800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 
2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:07.5 to 64
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
hub 1-1:0: USB hub found
hub 1-1:0: 2 ports detected
ALSA device list:
  #0: VIA 82C686A/B rev50 at 0xdc00, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 3
found reiserfs format "3.6" with standard journal
spurious 8259A interrupt: IRQ7.
Reiserfs journal params: device hda3, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Adding 305224k swap on /dev/hda2.  Priority:-1 extents:1
drivers/usb/input/hid-core.c: ctrl urb status -104 received
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb-0000:00:07.2-1.1
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 
16 19:03:09 PDT 2003
0: NVRM: AGPGART: unable to retrieve symbol table

>
> > 2. I have a usb keyboard plugged in It's packard Bell model number 9201
> >
> > 3. This did not happen with 2.4
> >
> > 4. ACPI is for laptops correct? I'm using a desktop and I've never
> > installed anything ACPI related..
>
> But is ACPI configured in your kernel?
>


I checked the config and ACPI was configured.. Now compiling without ACPI. Is 
that the reason? I think it was selected by default. 


> > I'm sorry for a bad bug report It's just that it was my first :) Hope
> > this helps
>
> Try reading the REPORTING-BUGS file in the main directory of the kernel
> source code for more information on useful things to send.
>
> thanks,
>
> greg k-h

