Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbTKOTyi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTKOTyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:54:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:55243 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262048AbTKOTyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:54:17 -0500
From: <sven@w9y.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16310.33941.131249.530851@thing.w9y.de>
Date: Sat, 15 Nov 2003 20:55:01 +0100
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops when de-registering USB
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

first of all: sorry for sending to this address, I'm not sure where
the problem really is.

Description:

With the gentoo development-sources 2.6.0-test9 kernel I sometimes,
but not always get a kernel oops when shutting down.

System information:

This is a Intel D865PERLK mainboard with its on-board USB hub(s),
connected to it is a Lian Li USB 2.0 card reader (i.e. I got the oops
with only that connected).

Here are the files/outputs:

/var/log/messages:
------------------

  After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 022 02  1    0    0   0   0    0    2    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2393.0703 MHz.
..... host bus clock speed is 199.0475 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:1f[A] -> 2-18 -> IRQ 18
Pin 2-16 already programmed
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 2-19 -> IRQ 19
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:03:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:03:00[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:03:00[B] -> 2-22 -> IRQ 22
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-22 already programmed
Pin 2-21 already programmed
Pin 2-20 already programmed
Pin 2-23 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-18 already programmed
Pin 2-23 already programmed
Pin 2-16 already programmed
Pin 2-20 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SP1614N, ATA DISK drive
hdb: AOPEN CD-RW CRW5224 1.06 20030129, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD_RW ND-1300A, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
registering 0-0050
registering 0-0052
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
reiserfs: replayed 10 transactions in 1 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 144k freed
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
PCI: Setting latency timer of device 0000:02:01.0 to 64
eth0: Intel(R) PRO/1000 Network Connection
ttpci_eeprom: module license 'unspecified' taints kernel.
saa7146: register extension 'budget dvb'.
saa7146: register extension 'budget_ci dvb'.
saa7146: found saa7146 @ mem f8948800 (revision 1, irq 22) (0x13c2,0x1011).
DVB: registering new adapter (TT-Budget/WinTV-NOVA-T  PCI).
TT-Budget/WinTV-NOVA-T  PCI adapter 0 has MAC addr = 00:d0:5c:03:21:1e
saa7146: found saa7146 @ mem f894a400 (revision 1, irq 19) (0x13c2,0x1011).
DVB: registering new adapter (TT-Budget/WinTV-NOVA-T  PCI).
TT-Budget/WinTV-NOVA-T  PCI adapter 1 has MAC addr = 00:d0:5c:03:21:82
tda1004x: Detected Philips TDA10045H.
tda1004x: Detected Philips TDM1316L tuner.
DVB: registering frontend 0:0 (Philips TDA10045H)...
tda1004x: Detected Philips TDA10045H.
tda1004x: Detected Philips TDM1316L tuner.
DVB: registering frontend 1:0 (Philips TDA10045H)...
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 48000
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f8cc7c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000cc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000d000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
hub 1-0:1.0: new USB device on port 8, assigned address 2
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000d400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
uhci_hcd 0000:00:1d.3: UHCI Host Controller
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0128
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0128
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi0, channel 0, id 0, lun 1,  type 0
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0000d800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0128
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg2 at scsi0, channel 0, id 0, lun 2,  type 0
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0128
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg3 at scsi0, channel 0, id 0, lun 3,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
eth0: no IPv6 routers present
inserting floppy driver for 2.6.0-test9
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-8: USB disconnect, address 2
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 2 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb3: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 3 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb4: USB disconnect, address 1
uhci_hcd 0000:00:1d.2: USB bus 4 deregistered
uhci_hcd 0000:00:1d.3: remove, state 1
usb usb5: USB disconnect, address 1
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f8c92ba7
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f8c92ba7>]    Tainted: P  
EFLAGS: 00010246
EIP is at usb_disconnect+0x58/0xe6 [usbcore]
eax: 00000000   ebx: 00000000   ecx: f5aede24   edx: f5999000
esi: 00000000   edi: f5aede00   ebp: f5aede24   esp: f4181e94
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 4713, threadinfo=f4180000 task=f5af32e0)
Stack: f4181ec8 f4181ea4 f5aedf28 00000000 00000001 00000003 f594ce00 f594ce24 
       f8c92c2b f594cfbc f8c9f898 f594cf28 00000001 f5999000 f7e32854 f7e32800 
       00000000 f8c9a8d2 f4181eec f8ccdccc f7e328b0 00000001 00000000 f7e32800 
Call Trace:
 [<f8c92c2b>] usb_disconnect+0xdc/0xe6 [usbcore]
 [<f8c9a8d2>] usb_hcd_pci_remove+0x88/0x16a [usbcore]
 [<c01c9cc9>] pci_device_remove+0x3b/0x3d
 [<c020818e>] device_release_driver+0x64/0x66
 [<c02081b0>] driver_detach+0x20/0x2e
 [<c02083cd>] bus_remove_driver+0x3d/0x75
 [<c0208778>] driver_unregister+0x13/0x28
 [<c01c9e6a>] pci_unregister_driver+0x16/0x26
 [<f8ccdbda>] uhci_hcd_cleanup+0xf/0x59 [uhci_hcd]
 [<c0134eec>] sys_delete_module+0x14d/0x1ae
 [<c0148300>] do_munmap+0xc7/0x183
 [<c010b327>] syscall_call+0x7/0xb

Code: 8b 00 c7 04 24 60 04 ca f8 89 44 24 04 e8 86 ea 48 c7 8d 04 
 <3>hub 5-0:1.0: hub_port_status failed (err = -19)
hub 5-0:1.0: hub_port_status failed (err = -19)
hub 5-0:1.0: hub_port_status failed (err = -19)
hub 5-0:1.0: hub_port_status failed (err = -19)
hub 5-0:1.0: hub_port_status failed (err = -19)
hub 5-0:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
hub 5-0:1.0: cannot disable port 2 (err = -19)
hub 5-0:1.0: hub_hub_status failed (err = -19)
hub 5-0:1.0: get_hub_status failed


ksymopts:
---------

ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
WARNING: USB Mass Storage data integrity not assured
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Unable to handle kernel NULL pointer dereference at virtual address 00000000
f8c92ba7
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f8c92ba7>]    Tainted: P  
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: f5aede24   edx: f5999000
esi: 00000000   edi: f5aede00   ebp: f5aede24   esp: f4181e94
ds: 007b   es: 007b   ss: 0068
Stack: f4181ec8 f4181ea4 f5aedf28 00000000 00000001 00000003 f594ce00 f594ce24 
       f8c92c2b f594cfbc f8c9f898 f594cf28 00000001 f5999000 f7e32854 f7e32800 
       00000000 f8c9a8d2 f4181eec f8ccdccc f7e328b0 00000001 00000000 f7e32800 
Call Trace:
 [<f8c92c2b>] usb_disconnect+0xdc/0xe6 [usbcore]
 [<f8c9a8d2>] usb_hcd_pci_remove+0x88/0x16a [usbcore]
 [<c01c9cc9>] pci_device_remove+0x3b/0x3d
 [<c020818e>] device_release_driver+0x64/0x66
 [<c02081b0>] driver_detach+0x20/0x2e
 [<c02083cd>] bus_remove_driver+0x3d/0x75
 [<c0208778>] driver_unregister+0x13/0x28
 [<c01c9e6a>] pci_unregister_driver+0x16/0x26
 [<f8ccdbda>] uhci_hcd_cleanup+0xf/0x59 [uhci_hcd]
 [<c0134eec>] sys_delete_module+0x14d/0x1ae
 [<c0148300>] do_munmap+0xc7/0x183
 [<c010b327>] syscall_call+0x7/0xb
Code: 8b 00 c7 04 24 60 04 ca f8 89 44 24 04 e8 86 ea 48 c7 8d 04 


>>EIP; f8c92ba7 <__crc_pci_find_bus+21370c/304b83>   <=====

>>ecx; f5aede24 <__crc___inode_dir_notify+63038/4335ff>
>>edx; f5999000 <__crc_tty_wait_until_sent+19f9b7/1bbd29>
>>edi; f5aede00 <__crc___inode_dir_notify+63014/4335ff>
>>ebp; f5aede24 <__crc___inode_dir_notify+63038/4335ff>
>>esp; f4181e94 <__crc_remove_shrinker+2b7c92/4ce5d5>

Trace; f8c92c2b <__crc_pci_find_bus+213790/304b83>
Trace; f8c9a8d2 <__crc_pci_find_bus+21b437/304b83>
Trace; c01c9cc9 <pci_device_remove+3b/3d>
Trace; c020818e <device_release_driver+64/66>
Trace; c02081b0 <driver_detach+20/2e>
Trace; c02083cd <bus_remove_driver+3d/75>
Trace; c0208778 <driver_unregister+13/28>
Trace; c01c9e6a <pci_unregister_driver+16/26>
Trace; f8ccdbda <__crc_pci_find_bus+24e73f/304b83>
Trace; c0134eec <sys_delete_module+14d/1ae>
Trace; c0148300 <do_munmap+c7/183>
Trace; c010b327 <syscall_call+7/b>

Code;  f8c92ba7 <__crc_pci_find_bus+21370c/304b83>
00000000 <_EIP>:
Code;  f8c92ba7 <__crc_pci_find_bus+21370c/304b83>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  f8c92ba9 <__crc_pci_find_bus+21370e/304b83>
   2:   c7 04 24 60 04 ca f8      movl   $0xf8ca0460,(%esp,1)
Code;  f8c92bb0 <__crc_pci_find_bus+213715/304b83>
   9:   89 44 24 04               mov    %eax,0x4(%esp,1)
Code;  f8c92bb4 <__crc_pci_find_bus+213719/304b83>
   d:   e8 86 ea 48 c7            call   c748ea98 <_EIP+0xc748ea98>
Code;  f8c92bb9 <__crc_pci_find_bus+21371e/304b83>
  12:   8d 04 00                  lea    (%eax,%eax,1),%eax


1 warning and 1 error issued.  Results may not be reliable.


(It was the same kernel/module setup.)


Please feel free to contact me if you need more information.

And thanks for the nice work!


Bye
  Sven

-- 
Sven Wischnowsky                             sven@w9y.de

