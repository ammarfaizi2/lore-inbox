Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUJRTBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUJRTBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUJRS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:59:45 -0400
Received: from smtp08.web.de ([217.72.192.226]:22957 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S267497AbUJRSzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:55:18 -0400
Message-ID: <41741194.6070901@web.de>
Date: Mon, 18 Oct 2004 20:55:16 +0200
From: Nils Rennebarth <Nils.Rennebarth@web.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Suspend development list <softwaresuspend-devel@lists.berlios.de>
Subject: X is killed when trying to suspend with USB Mouse plugged in
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0988617C07BB89FC649B86D2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0988617C07BB89FC649B86D2
Content-Type: multipart/mixed;
 boundary="------------030102000202080702020705"

This is a multi-part message in MIME format.
--------------030102000202080702020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

When I try to suspend 2.6.9-rc[1-4] when X is runnning and my USB Mouse 
is plugged in, I get an Ooops. X is killed and the suspend as well.

Attached is the oops with 2.6.9-rc4
The oops comes at the moment, that uhci_hcd is removed. If I do not 
remove that module, suspend does work but the laptop hangs hard during 
resume.

That only happens if I use /dev/input/mouse1 as input device for the 
mouse. With /dev/input/mice I can suspend and resume successfully.

So is using /dev/input/mouse1 something I shouldn't have done in the 
first place (came from some experimentation when trying to use the 
synaptics driver for my alps touchpad) or does it point to a bug in the 
uhci driver? Or a bug in X?



-- 
                                      ______
                                     (Muuuhh)
Global Village Sau  ==>        ^..^ |/¯¯¯¯¯
(Kann Fremdsprache) ==>        (oo)

--------------030102000202080702020705
Content-Type: text/plain;
 name="oops-2.6.9-rc4-usb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-2.6.9-rc4-usb.txt"

00000001ffae000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130990
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126894 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
ACPI: RSDT (v001 DELL    CPi R   0x27d3091e ASL  0x00000061) @ 0x1fff0000
ACPI: FADT (v001 DELL    CPi R   0x27d3091e ASL  0x00000061) @ 0x1fff0400
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux ro root=306 resume2=swap:/dev/hda5
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2194.146 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515224k/523960k available (1954k kernel code, 8200k reserved, 942k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4341.76 BogoMIPS (lpj=2170880)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebf9ff 00000000 00000000 00000080
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc97e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.1[A] -> GSI 11 (level, low) -> IRQ 11
pnp: 00:01: ioport range 0x800-0x85f could not be reserved
pnp: 00:01: ioport range 0x860-0x87f has been reserved
pnp: 00:01: ioport range 0x880-0x8bf has been reserved
pnp: 00:01: ioport range 0x8c0-0x8ff has been reserved
pnp: 00:01: ioport range 0x3f0-0x3f1 has been reserved
pnp: 00:01: ioport range 0x900-0x97f has been reserved
pnp: 00:01: ioport range 0xf400-0xf4fe has been reserved
NTFS driver 2.1.20 [Flags: R/O].
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM] (52 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N080ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
alps.c: E6 report: 00 00 64
alps.c: E7 report: 63 03 c8
alps.c: E6 report: 00 00 64
alps.c: E7 report: 63 03 c8
alps.c: Status: 10 00 64
ALPS Touchpad (Dualpoint) detected
  Disabling hardware tapping
alps.c: Status: 00 00 64
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4093 buckets, 32744 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
Software Suspend Core
Software Suspend text mode support loading.
Software Suspend LZF Compression Driver registering.
Software Suspend Swap Writer registering.
ACPI: (supports S0 S1 S3 S4 S4bios S5)
ACPI wakeup devices: 
 LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE 
Software Suspend 2.1-rc2: Swap space signature found.
Software Suspend 2.1-rc2: Suspending enabled.
Software Suspend 2.1-rc2: Checking for image...
Software Suspend 2.1-rc2: This is normal swap space.
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 995988k swap on /dev/hda5.  Priority:-1 extents:1
NTFS volume version 3.1.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000bf80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0000bf40
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000bf20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem e099ac00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb 1-1: USB disconnect, address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hw_random: cannot enable RNG, aborting
usb 1-1: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49534 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 7 (level, low) -> IRQ 7
b44.c:v0.94 (May 4, 2004)
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0b:db:9a:5f:e7
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.0 [1028:013e]
Yenta: ISA IRQ mask 0x0478, PCI irq 11
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.1[A] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[faffd800-faffdfff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[364fc00014676010]
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
b44: eth0: Link is down.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: irq 7 in use, resorting to polled operation
lp0: using parport0 (polling).
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb4: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 4 deregistered
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-1: USB disconnect, address 3
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb3: USB disconnect, address 1
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
Unable to handle kernel paging request at virtual address e09be7c8
 printing eip:
e09d9b43
*pde = 1ff9d067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: ds parport_pc lp parport eth1394 ohci1394 ieee1394 yenta_socket pcmcia_core b44 mii 8250_pci snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore usbhid usbcore 8250_pnp 8250 serial_core joydev nls_iso8859_1
CPU:    0
EIP:    0060:[<e09d9b43>]    Not tainted VLI
EFLAGS: 00013286   (2.6.9-rc4) 
EIP is at hcd_pci_release+0x17/0x1e [usbcore]
eax: e09be7a0   ebx: df179854   ecx: e09ebba0   edx: df179800
esi: c039769c   edi: c03976c0   ebp: e09ebbb4   esp: dbc3be04
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 3332, threadinfo=dbc3a000 task=df0f5560)
Stack: df179800 e09d5239 df179800 c023d6df df17984c dee522e0 df5531c4 e09d7ebc 
       c01d3c83 df179854 df17986c c01d3c85 c0397480 dfe07868 c01d3fce df179854 
       e09d8a57 dff89200 e09d7ebc df7ebc00 c0397468 c01d3cad df17986c c01d3c85 
Call Trace:
 [<e09d5239>] usb_host_release+0x1d/0x1f [usbcore]
 [<c023d6df>] class_dev_release+0x58/0x5c
 [<e09d7ebc>] usb_release_interface_cache+0x0/0x3a [usbcore]
 [<c01d3c83>] kobject_cleanup+0x98/0x9a
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3fce>] kref_put+0x39/0x93
 [<e09d8a57>] usb_destroy_configuration+0xe4/0x11a [usbcore]
 [<e09d7ebc>] usb_release_interface_cache+0x0/0x3a [usbcore]
 [<c01d3cad>] kobject_put+0x1e/0x22
 [<c01d3c85>] kobject_release+0x0/0xa
 [<e09d176a>] usb_release_dev+0x3f/0x57 [usbcore]
 [<c023b830>] device_release+0x58/0x5c
 [<c01d3c83>] kobject_cleanup+0x98/0x9a
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3fce>] kref_put+0x39/0x93
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3c7c>] kobject_cleanup+0x91/0x9a
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3cad>] kobject_put+0x1e/0x22
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3fce>] kref_put+0x39/0x93
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3c7c>] kobject_cleanup+0x91/0x9a
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3cad>] kobject_put+0x1e/0x22
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c01d3fce>] kref_put+0x39/0x93
 [<c01d3cad>] kobject_put+0x1e/0x22
 [<c01d3c85>] kobject_release+0x0/0xa
 [<c0184539>] sysfs_hash_and_remove+0xbd/0xbf
 [<c023d5b7>] class_device_dev_unlink+0x1a/0x1e
 [<c023da17>] class_device_del+0x75/0xb6
 [<c023da6b>] class_device_unregister+0x13/0x23
 [<c0275984>] mousedev_free+0x1e/0x3c
 [<c0275a90>] mousedev_release+0x90/0x9e
 [<c015939d>] __fput+0xea/0xfc
 [<c0157d6d>] filp_close+0x59/0x86
 [<c0157dea>] sys_close+0x50/0x5f
 [<c0105e7b>] syscall_call+0x7/0xb
Code: 90 d2 90 df e9 2a fa ff ff e8 aa d2 90 df e9 3e fa ff ff 90 83 ec 04 8b 44 24 08 8b 50 34 85 d2 74 0c 8b 82 0c 01 00 00 89 14 24 <ff> 50 28 83 c4 04 c3 55 57 56 53 83 ec 2c 8b 5c 24 44 e8 1e 82 
 

--------------030102000202080702020705--

--------------enig0988617C07BB89FC649B86D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBdBGcqgAZ+sZlgs4RAuKFAJ9pG8uozuuGdLqnJXAlCodluGh92ACdF9mI
ZXGUbpjBoVgyeZA7lBVzcmw=
=tVmL
-----END PGP SIGNATURE-----

--------------enig0988617C07BB89FC649B86D2--
