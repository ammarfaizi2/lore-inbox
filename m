Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbULFL7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbULFL7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbULFL7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:59:43 -0500
Received: from pop.gmx.net ([213.165.64.20]:25018 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261504AbULFL62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:58:28 -0500
X-Authenticated: #3340650
Subject: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB Devices
	do not work
From: florian <florian_kr@gmx.de>
To: Kernel-list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m+5/lqAGHd4j7owd2KIU"
Date: Mon, 06 Dec 2004 12:48:55 +0100
Message-Id: <1102333735.5095.4.camel@orange-bud>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m+5/lqAGHd4j7owd2KIU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Distribution: Fedora Core 3
Kernel: upgraded to 2.6.9-1.681_FC3

Hardware:=20
Mainboard - Unknown (I think it's from Medion)
Graphikcard - Ati Radeon 9100 PRO IGP
Sound: ATI AC'97
Harddisk - 120 GB IDE
DVD: Medion DVD-RW+/-
USB 2.0

USB devices:
Mouse - optical wheel mouse USB - vendor: Elta
Printer - HP deskjet
Scanner - Mustek 600 CU
USB 4 Port Hub (only the mous is connectet with the hub)

Subject: [<02282da7>] (usb_hcd_irq+0x0/0x4b)
Disabling IRQ #5 - USB Devices do not work

Description:

My first problem ist the "USB Legacy Support" (to enable/disable in the
BIOS). If this is enabled the system is going to hang. And there is only
this message "Disabling IRQ #3". I can't start the "Fedora core 3" and
"Fedora Core 1" installation if "Legacy Support" is enabeld. If I
disable this, I can install "Fedora Core 1/3". After the installation I
tryed to enable "Legacy Support" but the same problem takes affect.

In "Fedora Core 2" this problem don't exist but no USB device works. And
after I updated the system ("yum update") the same problem like in FC3
is the result.

Now I'm using FC3, "Legacy Support" is disabeld. But there still exist
some problems. My printer and my scanner won't work. Both devices worked
correctly on my old PC with FC1.=20

CUPS hangs if I try to start the daemon and XSANE don't find any device.

At boottime some messages like "irq 5: nobody cared! ... please report a
bug...." was displayed.

I have already tryed "acpi=3Doff"
I have build my own kernel 2.6.9 with ACPI on/off and device management
for BIOS and the kernel

My Questions:

How can I enable "USB Legacy Support" without errors?
How can I resolve the problem with the USB devices?

I've found via google some BIOS Bugs for "USB Legacy Support", but this
bug occurs only on Windows XP (I don't found this for Linux). I tried
allready to update my BIOS and now USB is disabled for all devices
(Mouse, Printer, Scanner, USB-FlashMemory)

[florian@orange-bud ~]$ cat /proc/interrupts
           CPU0
  0:    1405240          XT-PIC  timer
  1:       1422          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     100012          XT-PIC  ehci_hcd, ohci_hcd, ohci_hcd
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:       2174          XT-PIC  ATI IXP, eth0
 12:      83685          XT-PIC  i8042
 14:      62240          XT-PIC  ide0
 15:         22          XT-PIC  ide1
NMI:          0
ERR:          6
[florian@orange-bud ~]$         =20

this is the output from dmesg:

this is like the message at boottime there stands IRQ 3 in the past and
now (after BIOS update) IRQ 5.

irq 5: nobody cared! (screaming interrupt?)
irq 5: Please try booting with acpi=3Doff and report a bug
Stack pointer is garbage, not printing trace
handlers:
[<02282da7>] (usb_hcd_irq+0x0/0x4b)
Disabling IRQ #5

dmesg before the BIOS was updated:
the current dmesg is at the bottom

Linux version 2.6.9-1.681_FC3 (bhcompile@tweety.build.redhat.com) (gcc
version3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Thu Nov 18 15:10:10 EST
2004
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
BIOS-e820: 000000001bef0000 - 000000001bef3000 (ACPI NVS)
BIOS-e820: 000000001bef3000 - 000000001bf00000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
446MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 114416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110320 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 FIC                                   ) @ 0x000f6a00
ACPI: RSDT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef3000
ACPI: FADT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef3040
ACPI: DSDT (v001 FIC    AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/  hdc=3Dide-scsi rhgb quiet
ide_setup: hdc=3Dide-scsi
mapped 4G/4G trampoline to ffff4000.
Initializing CPU#0
CPU 0 irqstacks, hard=3D023db000 soft=3D023da000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2793.878 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449444k/457664k available (2084k kernel code, 7684k reserved,
651k data, 148k init, 0k highmem)
Calibrating delay loop... 5537.79 BogoMIPS (lpj=3D2768896)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        bfebf3ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Celeron(R) CPU 2.80GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs... it is
Freeing initrd memory: 383k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb450, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *12
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:14.2[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1101309616.763:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 5E743E255A7478EF
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Thermal Zone [THRM] (-127 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported Ati chipset (device id: 7833)
irq 12: nobody cared! (screaming interrupt?)
irq 12: Please try booting with acpi=3Doff and report a bug
Stack pointer is garbage, not printing trace
handlers:
[<0223aede>] (i8042_interrupt+0x0/0x251)
Disabling IRQ #12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
Probing IDE interface ide1...
hdc: MEDION DVD RW DVR-MCC, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=3D16383/255/63
hda: cache flushes supported
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
irq 12: nobody cared! (screaming interrupt?)
irq 12: Please try booting with acpi=3Doff and report a bug
Stack pointer is garbage, not printing trace
handlers:
[<0223aede>] (i8042_interrupt+0x0/0x251)
Disabling IRQ #12
input: AT Translated Set 2 keyboard on isa0060/serio0
irq 12: nobody cared! (screaming interrupt?)
irq 12: Please try booting with acpi=3Doff and report a bug
Stack pointer is garbage, not printing trace
handlers:
[<0223aede>] (i8042_interrupt+0x0/0x251)
Disabling IRQ #12
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4bios S5)
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 AUDO MODM  P2P  MAC
Freeing unused kernel memory: 148k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Losing some ticks... checking if CPU frequency changed.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
spurious 8259A interrupt: IRQ7.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
inserting floppy driver for 2.6.9-1.681_FC3
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xd000, 00:40:ca:85:f7:15, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: irq 3, pci mem 1e81c000
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 3 (level, low) -> IRQ 3
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: irq 3, pci mem 1e830000
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 3 (level, low) -> IRQ 3
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: irq 3, pci mem 1e864000
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ohci_hcd 0000:00:13.0: wakeup
ohci_hcd 0000:00:13.1: wakeup
usb 2-1: new full speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 3-1: new full speed USB device using address 2
usb 3-2: new full speed USB device using address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0
alt 0 proto 2 vid 0x03F0 pid 0x7304
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 2-1.1: new low speed USB device using address 3
input: USB HID v1.00 Mouse [Cypress Sem PS2/USB Browser Combo Mouse] on
usb-0000:00:13.0-1.1
NET: Registered protocol family 10
Disabled Privacy Extensions on device 0236dc20(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
ACPI: Power Button (FF) [PWRF]
EXT3 FS on hda5, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Losing some ticks... checking if CPU frequency changed.
Adding 1020088k swap on /dev/hda9.  Priority:-1 extents:1
SCSI subsystem initialized
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=3D/dev/hdX
as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MEDION    Model: DVD RW  DVR-MCC   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x7 to 0xb, date =3D 05122004
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing too many ticks!
TSC cannot be used as a timesource.
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
divert: not allocating divert_blk for non-ethernet device ppp0
eth0: no IPv6 routers present
i2c /dev entries driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
application sox uses obsolete OSS audio interface
---------------------------------------------------------------------------=
------


dmesg before BIOS update: in modprobe.conf ohci_hcd is disabled - IRQ 12
(PS/2 Mouse) won't be disabled

Linux version 2.6.9-1.681_FC3 (bhcompile@tweety.build.redhat.com) (gcc
version3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Thu Nov 18 15:10:10 EST
2004
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
BIOS-e820: 000000001bef0000 - 000000001bef3000 (ACPI NVS)
BIOS-e820: 000000001bef3000 - 000000001bf00000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
446MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 114416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110320 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 FIC                                   ) @ 0x000f6870
ACPI: RSDT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef3000
ACPI: FADT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef3040
ACPI: MADT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef6380
ACPI: DSDT (v001 FIC    AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/  hdc=3Dide-scsi rhgb quiet
ide_setup: hdc=3Dide-scsi
mapped 4G/4G trampoline to ffff4000.
Initializing CPU#0
CPU 0 irqstacks, hard=3D023db000 soft=3D023da000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2794.523 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449444k/457664k available (2084k kernel code, 7684k reserved,
651k data, 148k init, 0k highmem)
Calibrating delay loop... 5537.79 BogoMIPS (lpj=3D2768896)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        bfebf3ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Celeron(R) CPU 2.80GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs... it is
Freeing initrd memory: 383k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb450, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 5 (level, low) -> IRQ 5
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1101687518.695:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 5E743E255A7478EF
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Thermal Zone [THRM] (-127 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported Ati chipset (device id: 7833)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
Probing IDE interface ide1...
hdc: MEDION DVD RW DVR-MCC, ATAPI CD/DVD-ROM drive
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=3D16383/255/63
hda: cache flushes supported
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4bios S5)
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 AUDO MODM  P2P  MAC UAR1 UAR2 PS2M PS2K
Freeing unused kernel memory: 148k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Losing some ticks... checking if CPU frequency changed.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Losing some ticks... checking if CPU frequency changed.
spurious 8259A interrupt: IRQ7.
inserting floppy driver for 2.6.9-1.681_FC3
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xd000, 00:40:ca:85:f7:15, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: BIOS handoff failed (160, 1010001)
ehci_hcd 0000:00:13.2: continuing after BIOS bug...
irq 5: nobody cared! (screaming interrupt?)
irq 5: Please try booting with acpi=3Doff and report a bug
Stack pointer is garbage, not printing trace
handlers:
[<02282da7>] (usb_hcd_irq+0x0/0x4b)
Disabling IRQ #5
ehci_hcd 0000:00:13.2: irq 5, pci mem 1e81c000
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: irq 5, pci mem 1e830000
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: irq 5, pci mem 1e864000
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Losing some ticks... checking if CPU frequency changed.
NET: Registered protocol family 10
Disabled Privacy Extensions on device 0236dc20(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
ACPI: Power Button (FF) [PWRF]
EXT3 FS on hda5, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Losing some ticks... checking if CPU frequency changed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1020088k swap on /dev/hda9.  Priority:-1 extents:1
SCSI subsystem initialized
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=3D/dev/hdX
as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MEDION    Model: DVD RW  DVR-MCC   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
Losing some ticks... checking if CPU frequency changed.
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x7 to 0xb, date =3D 05122004
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing too many ticks!
TSC cannot be used as a timesource.
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
divert: not allocating divert_blk for non-ethernet device ppp0
i2c /dev entries driver
eth0: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
application sox uses obsolete OSS audio interface
application xine uses obsolete OSS audio interface
[root@orange-bud ~]#                                        =20
---------------------------------------------------------------------------=
---------


current dmesg:

[florian@orange-bud ~]$ dmesg
Linux version 2.6.9-1.681_FC3 (bhcompile@tweety.build.redhat.com) (gcc
version3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Thu Nov 18 15:10:10 EST
2004
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
BIOS-e820: 000000001bef0000 - 000000001bef3000 (ACPI NVS)
BIOS-e820: 000000001bef3000 - 000000001bf00000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
446MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 114416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110320 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 FIC                                   ) @ 0x000f6870
ACPI: RSDT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef3000
ACPI: FADT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef3040
ACPI: MADT (v001 FIC    P4MRS350 0x42302e31 AWRD 0x00000000) @
0x1bef6380
ACPI: DSDT (v001 FIC    AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: ro root=3DLABEL=3D/  hdc=3Dide-scsi rhgb quiet
ide_setup: hdc=3Dide-scsi
mapped 4G/4G trampoline to ffff4000.
Initializing CPU#0
CPU 0 irqstacks, hard=3D023db000 soft=3D023da000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2794.154 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449444k/457664k available (2084k kernel code, 7684k reserved,
651k data, 148k init, 0k highmem)
Calibrating delay loop... 5537.79 BogoMIPS (lpj=3D2768896)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        bfebf3ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Celeron(R) CPU 2.80GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs... it is
Freeing initrd memory: 383k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb450, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:14.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 5 (level, low) -> IRQ 5
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1102076498.583:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 5E743E255A7478EF
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Thermal Zone [THRM] (-127 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported Ati chipset (device id: 7833)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
Probing IDE interface ide1...
hdc: MEDION DVD RW DVR-MCC, ATAPI CD/DVD-ROM drive
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=3D16383/255/63
hda: cache flushes supported
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4bios S5)
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 AUDO MODM  P2P  MAC UAR1 UAR2 PS2M PS2K
Freeing unused kernel memory: 148k freed
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing too many ticks!
TSC cannot be used as a timesource.
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda5: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1482218
ext3_orphan_cleanup: deleting unreferenced inode 1368622
ext3_orphan_cleanup: deleting unreferenced inode 1636111
ext3_orphan_cleanup: deleting unreferenced inode 16939
ext3_orphan_cleanup: deleting unreferenced inode 1370088
ext3_orphan_cleanup: deleting unreferenced inode 1744627
ext3_orphan_cleanup: deleting unreferenced inode 1636096
ext3_orphan_cleanup: deleting unreferenced inode 1370076
ext3_orphan_cleanup: deleting unreferenced inode 1641024
ext3_orphan_cleanup: deleting unreferenced inode 1370025
ext3_orphan_cleanup: deleting unreferenced inode 1370022
ext3_orphan_cleanup: deleting unreferenced inode 1368810
EXT3-fs: hda5: 12 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
inserting floppy driver for 2.6.9-1.681_FC3
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xd000, 00:40:ca:85:f7:15, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:13.2[A] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: BIOS handoff failed (160, 1010001)
ehci_hcd 0000:00:13.2: continuing after BIOS bug...
irq 5: nobody cared! (screaming interrupt?)
irq 5: Please try booting with acpi=3Doff and report a bug
Stack pointer is garbage, not printing trace
handlers:
[<02282da7>] (usb_hcd_irq+0x0/0x4b)
Disabling IRQ #5
ehci_hcd 0000:00:13.2: irq 5, pci mem 1e81c000
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: irq 5, pci mem 1e830000
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI interrupt 0000:00:13.1[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: irq 5, pci mem 1e864000
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET: Registered protocol family 10
Disabled Privacy Extensions on device 0236dc20(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ACPI: Power Button (FF) [PWRF]
EXT3 FS on hda5, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1020088k swap on /dev/hda9.  Priority:-1 extents:1
SCSI subsystem initialized
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=3D/dev/hdX
as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MEDION    Model: DVD RW  DVR-MCC   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU0 updated from revision 0x7 to 0xb, date =3D 05122004
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
divert: not allocating divert_blk for non-ethernet device ppp0
eth0: no IPv6 routers present
spurious 8259A interrupt: IRQ7.
i2c /dev entries driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
application sox uses obsolete OSS audio interface
[florian@orange-bud ~]$  =20
--=20
florian <florian_kr@gmx.de>

--=-m+5/lqAGHd4j7owd2KIU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtEcnm9XQAcbR/eIRAs97AJ9VmEEtiMXhVc51U945ofYQ3ladHACghX6n
uu824Pe0uWpI/tu+6m1m+OE=
=vMQ/
-----END PGP SIGNATURE-----

--=-m+5/lqAGHd4j7owd2KIU--

