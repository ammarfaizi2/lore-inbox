Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUFWJhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUFWJhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 05:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFWJhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 05:37:16 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:14677 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S265248AbUFWJg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 05:36:27 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Wed, 23 Jun 2004 11:34:38 +0200
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org,
       Marc Waeckerlin <Marc.Waeckerlin@siemens.com>, laflipas@telefonica.net,
       t.hirsch@web.de
References: <200406220953.01363.Marc.Waeckerlin@siemens.com> <200406220807.47328.dtor_core@ameritech.net>
In-Reply-To: <200406220807.47328.dtor_core@ameritech.net>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u6U2AoDGAA1lBAA"
Message-Id: <200406231134.39093.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 23 Jun 2004 09:34:40.0285 (UTC) FILETIME=[4EAC74D0:01C45905]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_u6U2AoDGAA1lBAA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I CC this mail to laflipas and t.hirsch because they have the same problem.

Am Dienstag, 22. Juni 2004 16.18 schrieben Sie unter "RE: Touchpad on Kernel 
Mailinglist: Question":
> Marc Waeckerlin wrote:

> > > Here your touchpad can be rest back to relative mode.
> > How?
> What I meant is that act of plugging in your keyboard may cause
> the touchpad revert back in relative mode and we _do not_ want
> this happening. Hence the option psmouse.resetafter to try to
> re-initialize the touchpad after so many bad packets.

> > > Does passing psmouse.resetafter=3 to the kernel helps things a bit?
> >
> > Do you mean as boot-prompt parameter to GRUB/LILO?
>
> If your psmouse module is compiled it then use "psmouse.resetafter=3"
> as a boot parameter. If psmouse is a module then put
> "options psmouse resetafer=3" in your /etc/modprobe.conf

I am sorry, both options do not help at all - well, perhaps the jumping of the 
cursor when using the touchpad without external keyboard/mouse disconnected 
may be slightly better. But as soon as I plug in the external keyboard, the 
old problem occurs.

Also I have a problem not yet mentioned, but it happened again this morning: 
Sometimes - without external keyboard/mouse, only using touchpad and internal 
keyboard -, sometimes the keyboard does not work anymore. If I hit any 
arbitrary key, nothing happens anymore. The mouse still works with the 
touchpad. Since I am often mobile, I can't acces the notebook through LAN and 
sice keynoard does not work anymore, I cant hit ctrl-alt-f1 or so to switch 
to a terminal or to watch the syslog on ctrl-alt-f10. The only thing I can do 
is to reboot using the mouse only.


> You know, could you send me your dmesg so I get a feeling of your
> laptop. What make/model is that?

It's a Pentium III, SIS-Chipset noname (the only notebook I could buy without 
Microsoft tax), as you can see in the attached dmesg.

I have my notebook for 2 1/2 years now and I never had similar problem with 
the previous 2.4.x kernels. Also there are other people with the same 
problem, so I think it's no hardware defect.


> Also, if you don't use any external 
> devices do you still have touchpad troubles?

Doesn't help.


> Do they go away if you 
> boot with acpi=off boot parameter?

No, that's one of the first things I tried. SuSE sets up a "Failsafe" boot 
parameter, that disables ACPI, APM, ISE-SCSI and other things. But it still 
does not work.


> I wish I could provide you with a canned solution, there just too
> many unknowns.

There are other with the same problem, e.g. Thorsten on the kernel mailing 
list in Mai and the one on the link I posted in my first mail. Also, there's 
another similar thread in linuxquetions.org:
http://www.linuxquestions.org/questions/showthread.php?s=&threadid=182363&highlight=mouse+jumps+around
Do a search on Google to find more victims (possible keywords: "mouse jumps 
linux" or the syslog messages). Here's one reporting the same in spanish:
http://lists.debian.org/debian-user-spanish/2004/02/msg00127.html


Is there any alternative driver I could try? How is synaptics related to a 
PS/2 mouse and can it be disabled? Can I do something in the kernel 
configuration (please describe the xconfig menu path)?

Can I assist you somehow? I am an experienced C++ programmer, but I have never 
done kernel development or debugging.

If you send me a patch, if possible diff it against 2.6.7, that's my actual 
kernel.


Thank you
Regards
Marc

--Boundary-00=_u6U2AoDGAA1lBAA
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.7 (root@qingwa) (gcc-Version 3.3.3 (SuSE Linux)) #2 Tue Jun 22 12:23:11 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bff8000 (ACPI data)
 BIOS-e820: 000000000bff8000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000ffef0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
191MB LOWMEM available.
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fc740
ACPI: RSDT (v001 AMIINT AMIINT09 0x00001000 MSFT 0x0100000b) @ 0x0bff0000
ACPI: FADT (v001 AMIINT AMIINT09 0x00001000 MSFT 0x0100000b) @ 0x0bff0030
ACPI: DSDT (v001    SiS      630 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x5008
Built 1 zonelists
Kernel command line: root=/dev/hda2 vga=0x317 acpi=force desktop resume=/dev/hda1 splash=silent
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1097.320 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 189652k/196544k available (1887k kernel code, 6256k reserved, 876k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2179.07 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1097.0112 MHz.
..... host bus clock speed is 99.0737 MHz.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1464k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS18 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 11)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [URP1] (off)
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 6 7 11 12 14 15) *0
ACPI: PCI Interrupt Link [LNKC] (IRQs 6 7 10 12 14 15) *0
ACPI: PCI Interrupt Link [LNKD] (IRQs 11) *0
ACPI: Power Resource [FN10] (on)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
sisfb: Video ROM found and mapped to c00c0000
sisfb: Framebuffer at 0xd0000000, mapped to 0xcc80e000, size 65536k
sisfb: MMIO at 0xdfee0000, mapped to 0xd080f000, size 128k
sisfb: Memory heap starting at 12288K
sisfb: Detected LVDS transmitter and Chrontel TV encoder
sisfb: Detected LCD PanelDelayCompensation 32
sisfb: Default mode is 800x600x8 (60Hz)
sisfb: Initial vbflags 0x3000022
sisfb: Added MTRRs
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
sisfb: 2D acceleration is enabled, scrolling mode ypan (auto-max)
fb0: SIS 630/730 VGA frame buffer device, Version 1.6.25
sisfb: (C) 2001-2004 Thomas Winischhofer.
vesafb: abort, cannot reserve video memory at 0xd0000000
vesafb: framebuffer at 0xd0000000, mapped to 0xd0830000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at cae4:0008
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb1: VESA VGA frame buffer device
audit: initializing netlink socket (disabled)
audit(1087978333.470:0): initialized
Total HugeTLB memory allocated, 0
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Console: switching to colour frame buffer device 100x37
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 630 chipset
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized sis 1.1.0 20030826 on minor 0: Silicon Integrated Systems [SiS] 630/730 PCI/AGP VGA Display Adapter
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:00.1
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS630 ATA 100 (1st gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: FUJITSU MHT2080AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(33)
 hda: hda1 hda2 hda3
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 4.1
 Sensor: 8
 new absolute packet format
input: SynPS/2 Synaptics TouchPad on isa0060/serio2
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
Resume Machine: resuming from /dev/hda1
Resuming from device hda1
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
USB Universal Host Controller Interface driver v2.2
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:01.2: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:01.2: irq 11, pci mem d0b59000
ohci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:01.3: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:01.3: irq 11, pci mem d0b67000
ohci_hcd 0000:00:01.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
VFS: Mounted root (xfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 184k freed
Adding 859436k swap on /dev/hda1.  Priority:42 extents:1
Generic RTC Driver v1.07
ohci_hcd 0000:00:01.2: remote wakeup
usb 1-1: new full speed USB device using address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: USB       Model: Flash Drive       Rev: 1.11
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 253949 512-byte hdwr sectors (130 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
USB Mass Storage device found at 2
XFS mounting filesystem loop0
Ending clean XFS mount for filesystem: loop0
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:03.0 [1584:3000]
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000821
usb 1-1: USB disconnect, address 2
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
st: Version 20040403, fixed bufsize 32768, s/g segs 256
BIOS EDD facility v0.15 2004-May-17, 1 devices found
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0370d60(lo)
IPv6 over IPv4 tunneling driver
ACPI: Lid Switch [LIDD]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
Disabled Privacy Extensions on device cbdc9000(sit0)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
    ACPI-0179: *** Warning: The ACPI AML in your computer contains errors, please nag the manufacturer to correct it.
    ACPI-0182: *** Warning: Allowing relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
ACPI: Thermal Zone [THRM] (51 C)
XFS: unknown mount option [commit].
XFS: unknown mount option [commit].
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Non-volatile memory driver v1.2
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
ohci_hcd 0000:00:01.2: remote wakeup
usb 1-1: new full speed USB device using address 3
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: USB       Model: Flash Drive       Rev: 1.11
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 253949 512-byte hdwr sectors (130 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
USB Mass Storage device found at 3
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.

--Boundary-00=_u6U2AoDGAA1lBAA--
