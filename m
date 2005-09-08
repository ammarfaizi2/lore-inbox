Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVIHVSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVIHVSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVIHVSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:18:54 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:30370 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S964945AbVIHVSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:18:52 -0400
Date: Thu, 8 Sep 2005 16:18:31 -0500
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: axboe@suse.de, akpm@osdl.org
Subject: can't boot 2.6.13
Message-ID: <20050908211831.GA17560@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am not able to boot the 2.6.13 version of the kernel. I've tried different systems, tried downloading again, still nothing. Here's the last thing I see from the serial port:

md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
input: AT Translated Set 2 keyboard on isa0060/serio0
VFS: Mounted root (ext2 filesystem).
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
SCSI subsystem initialized
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation

The console shows the reiserfs module loaded and then the message

waiting for /dev/sda2 to appear

It then dumps a list of devices and sda is not one of them. I've attached the entire boot log if any one is interested.

I've tried statically linking cciss on another system and the same basic results. Apparently, MPT cannot be statically linked unless I missed something.

What do I have to do to get 2.6.13 to boot up?

Thanks,
mikem

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="2613boot.txt"
Content-Transfer-Encoding: quoted-printable

crap
0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 09)
0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port=
 A0 (rev 09)
0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port=
 B0 (rev 09)
0000:00:05.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port=
 B1 (rev 09)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #=
4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI =
Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to P=
CI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (re=
v 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 1=
00 Storage Controller (rev 02)
0000:01:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 2=
7)
0000:01:04.0 System peripheral: Compaq Computer Corporation Integrated Ligh=
ts Out Controller (rev 01)
0000:01:04.2 System peripheral: Compaq Computer Corporation Integrated Ligh=
ts Out  Processor (rev 01)
0000:02:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
0000:02:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
0000:03:02.0 RAID bus controller: Hewlett-Packard Company: Unknown device 3=
220
0000:03:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI=
-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
0000:03:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI=
-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
0000:07:01.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 02)
0000:07:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gi=
gabit Ethernet (rev 10)
0000:08:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 6=
4xx (rev 01)
0000:08:05.0 RAID bus controller: Compaq Computer Corporation Smart Array 6=
4xx (rev 01)
0000:0b:00.0 RAID bus controller: Hewlett-Packard Company: Unknown device 3=
230 (rev 01)
Module                  Size  Used by
joydev                 12416  0=20
sg                     43960  0=20
st                     42660  0=20
sr_mod                 20004  0=20
floppy                 66000  0=20
ipv6                  280192  17=20
ehci_hcd               35848  0=20
hw_random               7072  0=20
cciss                  48392  0=20
uhci_hcd               34336  0=20
evdev                  11776  0=20
usbcore               130192  3 ehci_hcd,uhci_hcd
tg3                    88708  0=20
dm_mod                 63808  0=20
reiserfs              253680  1=20
mptscsih               38836  0=20
mptbase                46944  1 mptscsih
sd_mod                 20352  3=20
scsi_mod              148176  6 sg,st,sr_mod,cciss,mptscsih,sd_mod
md: stopping all md devices.
md: md0 switched to read-only mode.
Restarting system.
machine restart
machine restart
=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=FC=FC=80=FC=FC=8E=1C=FC=E0=F0=FC=FC=9E=E0=
=9Ef=E6x=FC=CF



ProLiant System BIOS - P50 (12/02/2004)
Copyright 1982, 2004 Hewlett-Packard Development Group, L.P. 5120 MB Detect=
ed
Processor 1 initialized at 3.40 GHz/800 MHz(1 Mbyte L2)
Advanced Memory Protection Mode: Advanced ECC Support
Redundant ROM Detected - This system contains a valid backup system ROM.

                    5120 MB Initialized /  5120 MB Detected                =
    =20
                                                                           =
    =20
ProLiant System BIOS - P50 (12/02/2004)                                    =
    =20
Copyright 1982, 2004 Hewlett-Packard Development Group, L.P.               =
    =20
                                                                           =
    =20
                                                                           =
    =20
Processor 1 initialized at 3.40 GHz/800 MHz(1 Mbyte L2)                    =
    =20
                                                                           =
    =20
Advanced Memory Protection Mode: Advanced ECC Support                      =
    =20
Redundant ROM Detected - This system contains a valid backup system ROM.   =
    =20
                                                                           =
    =20
LSI Logic Corp. MPT BIOS
Copyright 1995-2004 LSI Logic Corp.
MPTBIOS-5.05.18                                                   =20
HP Build

<<<Press F8 for configuration options>>>                                   =
           Searching for device at HBA 0, ID  0, LUN 0                     =
  Searching for device at HBA 0, ID  0, LUN 1                       Searchi=
ng for device at HBA 0, ID  0, LUN 2                       Searching for de=
vice at HBA 0, ID  0, LUN 3                       Searching for device at H=
BA 0, ID  0, LUN 4                       Searching for device at HBA 0, ID =
 0, LUN 5                       Searching for device at HBA 0, ID  0, LUN 6=
                       Searching for device at HBA 0, ID  0, LUN 7         =
                                                            Searching for d=
evice at HBA 0, ID  1, LUN 0                                               =
                      Searching for device at HBA 0, ID  2, LUN 0          =
                                                           Searching for de=
vice at HBA 0, ID  3, LUN 0                                                =
                     Searching for device at HBA 0, ID  4, LUN 0           =
                                                          Searching for dev=
ice at HBA 0, ID  5, LUN 0                                                 =
                    Searching for device at HBA 0, ID  6, LUN 0            =
                                                         Searching for devi=
ce at HBA 0, ID  8, LUN 0                                                  =
                   Searching for device at HBA 0, ID  9, LUN 0             =
                                                        Searching for devic=
e at HBA 0, ID 10, LUN 0                                                   =
                  Searching for device at HBA 0, ID 11, LUN 0              =
                                                       Searching for device=
 at HBA 0, ID 12, LUN 0                                                    =
                 Searching for device at HBA 0, ID 13, LUN 0               =
                                                      Searching for device =
at HBA 0, ID 14, LUN 0                                                     =
                Searching for device at HBA 0, ID 15, LUN 0                =
                                                     HBA ID LUN VENDOR   PR=
ODUCT              REV  SYNC  WIDE   CAPACITY
--- -- --- -------- ---------------- -------- ----- ---- ------------
 0   0  0  COMPAQ   BD0186349B           3B12  80.0  16        18 GB   *
 0   7  0  LSILogic LSI1030-IT        1032700 320.0  16 =20

List of non INT13 devices from additional channels:

Slot Port ID LUN VENDOR   PRODUCT              REV  SYNC  WIDE   CAPACITY
---- ---- -- --- -------- ---------------- -------- ----- ---- ------------
   0   01  7  0  LSILogic LSI1030-IT        1032700 320.0  16 =20

This device has been validated to run at 80MB/s and should support,
(*) 160MB/s, when the operating system is loaded.

LSI Logic Corp. MPT boot ROM successfully installed!
Integrated Lights-Out press [F8] to configure  =08 =08=08 =08=08 =08=08 =08=
=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =
=08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =081.=
70 Feb 11 2005=20

Slot 2                                                            HP Smart =
Array P600 Controller                        Initializing...  \|/-\|/-\|/-\=
|/-\|/-\|/-\|/-\|/-\|/                               (256MB, v1.20)   1 Log=
ical Drive






Press <F8> to run the Option ROM Configuration for Arrays Utility          =
 Press <ESC> to skip configuration and continue                            =
 =20

Slot 3                                                            HP Smart =
Array 6400 Controller                        Initializing...  \|/-\|/-\|/-\=
|/-\|                               (192MB, v2.46)   1 Logical Drive






Press <F8> to run the Option ROM Configuration for Arrays Utility          =
 Press <ESC> to skip configuration and continue                            =
 =20

Slot 3                                                            HP Smart =
Array 6400 EM Controller                     Initializing...  -\|/-\|/-\|/-=
\|/-\|                               (192MB, v2.46)   0 Logical Drives
1785-Slot 3 Drive Array Not Configured
     No Drives Detected

Slot 5                                                            HP Smart =
Array P400 Controller                        Initializing...  \|/-\|/-\|/-\=
|/-\|/-\|/-\|/-\|/-\|/                               (256MB, v0.13)   0 Log=
ical Drives
1785-Slot 5 Drive Array Not Configured
     No Drives Detected



HP Ethernet Boot Agent v7.0.3
Copyright (C) 2000,2003 Hewlett-Packard Development Company, L.P.
All rights reserved.
Press Ctrl-S to Enter Configuration Menu ...
 Press "F9" key for ROM-Based Setup Utility
 Press "F10" key for System Maintenance Menu
 Press "F12" key for PXE boot
 For access via BIOS Serial Console
 Press "ESC+9" for ROM-Based Setup Utility
 Press "ESC+0" for System Maintenance Menu
 Press "ESC+@" for PXE boot
Attempting Boot FromCD-ROMAttempting Boot FromFloppy Drive (A:)Attempting B=
oot FromHard Drive (C:)GRUB Loading stage2..

Initializing gfx code...
Memory: 0x34950 - 0x63f80, img data at 0x40e90
kernel (hd0,1)/boot/vmlinuz-2613-pass2  root=3D/dev/sda2 vga=3D0x31a selinu=
x=3D0 cons
ole=3DttyS0,115200 console=3Dtty0 resume=3D/dev/sda3 elevator=3Dcfq
   [Linux-bzImage, setup=3D0x1c00, size=3D0x1ab701]
initrd (hd0,1)/boot/initrd-2613-pass2
   [Linux-initrd @ 0x37e8b000, 0x164fbf bytes]

Bootdata ok (command line is root=3D/dev/sda2 vga=3D0x31a selinux=3D0 conso=
le=3DttyS0,115200 console=3Dtty0 resume=3D/dev/sda3 elevator=3Dcfq)
Linux version 2.6.13 (root@aries) (gcc version 3.3.3 (SuSE Linux)) #1 SMP T=
hu Sep 8 15:51:41 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfff3000 (usable)
 BIOS-e820: 00000000dfff3000 - 00000000dfffb000 (ACPI data)
 BIOS-e820: 00000000dfffb000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000015bfff000 (usable)
No NUMA configuration found
Faking a node at 0000000000000000-000000015bfff000
Bootmem setup node 0 0000000000000000-000000015bfff000
ACPI: PM-Timer IO Port: 0x908
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80100] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80100, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e0000000 (gap: e0000000:1ec00000)
Checking aperture...
Built 1 zonelists
Kernel command line: root=3D/dev/sda2 vga=3D0x31a selinux=3D0 console=3Dtty=
S0,115200 console=3Dtty0 resume=3D/dev/sda3 elevator=3Dcfq
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 3400.271 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Placing software IO TLB between 0x689d000 - 0x889d000
Memory: 5047236k/5701628k available (2402k kernel code, 0k reserved, 1210k =
data, 220k init)
Calibrating delay using timer specific routine.. 6810.87 BogoMIPS (lpj=3D13=
621745)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6800.69 BogoMIPS (lpj=3D13=
601395)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -132 cycles, maxerr 935 cycle=
s)
Brought up 2 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 7 10 *11)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Cannot allocate resource region 4 of device 0000:00:1d.0
PCI: Cannot allocate resource region 4 of device 0000:00:1d.1
PCI: Cannot allocate resource region 4 of device 0000:00:1d.2
PCI: Cannot allocate resource region 4 of device 0000:00:1d.3
PCI: Bridge: 0000:02:00.0
  IO window: 4000-4fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: e0000000-e02fffff
PCI: Bridge: 0000:07:01.0
  IO window: 5000-5fff
  MEM window: fdd00000-fddfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.2
  IO window: 5000-5fff
  MEM window: fdc00000-fddfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 4000-5fff
  MEM window: fdb00000-fddfffff
  PREFETCH window: e0000000-e02fffff
PCI: Bridge: 0000:00:04.0
  IO window: 6000-6fff
  MEM window: fde00000-fdffffff
  PREFETCH window: e0300000-e03fffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=E0=FC=FC=80=FC=FC=8E=1C=FC=E0=F0=FC=FC=9E=E0=
=9Ef=E6x=FC=CF



ProLiant System BIOS - P50 (12/02/2004)
Copyright 1982, 2004 Hewlett-Packard Development Group, L.P. 5120 MB Detect=
ed
Processor 1 initialized at 3.40 GHz/800 MHz(1 Mbyte L2)
Advanced Memory Protection Mode: Advanced ECC Support
Redundant ROM Detected - This system contains a valid backup system ROM.

                    5120 MB Initialized /  5120 MB Detected                =
    =20
                                                                           =
    =20
ProLiant System BIOS - P50 (12/02/2004)                                    =
    =20
Copyright 1982, 2004 Hewlett-Packard Development Group, L.P.               =
    =20
                                                                           =
    =20
                                                                           =
    =20
Processor 1 initialized at 3.40 GHz/800 MHz(1 Mbyte L2)                    =
    =20
                                                                           =
    =20
Advanced Memory Protection Mode: Advanced ECC Support                      =
    =20
Redundant ROM Detected - This system contains a valid backup system ROM.   =
    =20
                                                                           =
    =20
LSI Logic Corp. MPT BIOS
Copyright 1995-2004 LSI Logic Corp.
MPTBIOS-5.05.18                                                   =20
HP Build

<<<Press F8 for configuration options>>>                                   =
           Searching for device at HBA 0, ID  0, LUN 0                     =
  Spinning up the device!
Searching for device at HBA 0, ID  0, LUN 1                       Searching=
 for device at HBA 0, ID  0, LUN 2                       Searching for devi=
ce at HBA 0, ID  0, LUN 3                       Searching for device at HBA=
 0, ID  0, LUN 4                       Searching for device at HBA 0, ID  0=
, LUN 5                       Searching for device at HBA 0, ID  0, LUN 6  =
                     Searching for device at HBA 0, ID  0, LUN 7           =
                                                          Searching for dev=
ice at HBA 0, ID  1, LUN 0                                                 =
                    Searching for device at HBA 0, ID  2, LUN 0            =
                                                         Searching for devi=
ce at HBA 0, ID  3, LUN 0                                                  =
                   Searching for device at HBA 0, ID  4, LUN 0             =
                                                        Searching for devic=
e at HBA 0, ID  5, LUN 0                                                   =
                  Searching for device at HBA 0, ID  6, LUN 0              =
                                                       Searching for device=
 at HBA 0, ID  8, LUN 0                                                    =
                 Searching for device at HBA 0, ID  9, LUN 0               =
                                                      Searching for device =
at HBA 0, ID 10, LUN 0                                                     =
                Searching for device at HBA 0, ID 11, LUN 0                =
                                                     Searching for device a=
t HBA 0, ID 12, LUN 0                                                      =
               Searching for device at HBA 0, ID 13, LUN 0                 =
                                                    Searching for device at=
 HBA 0, ID 14, LUN 0                                                       =
              Searching for device at HBA 0, ID 15, LUN 0                  =
                                                   Searching for device at =
HBA 0, ID  0, LUN 0                                                        =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                         HBA ID LUN VENDOR =
  PRODUCT              REV  SYNC  WIDE   CAPACITY
--- -- --- -------- ---------------- -------- ----- ---- ------------
 0   0  0  COMPAQ   BD0186349B           3B12  80.0  16        18 GB   *
 0   7  0  LSILogic LSI1030-IT        1032700 320.0  16 =20

List of non INT13 devices from additional channels:

Slot Port ID LUN VENDOR   PRODUCT              REV  SYNC  WIDE   CAPACITY
---- ---- -- --- -------- ---------------- -------- ----- ---- ------------
   0   01  7  0  LSILogic LSI1030-IT        1032700 320.0  16 =20

This device has been validated to run at 80MB/s and should support,
(*) 160MB/s, when the operating system is loaded.

LSI Logic Corp. MPT boot ROM successfully installed!
Integrated Lights-Out press [F8] to configure  =08 =08=08 =08=08 =08=08 =08=
=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =
=08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =081.=
70 Feb 11 2005=20

Slot 2                                                            HP Smart =
Array P600 Controller                        Initializing...  \|/-\|/-\|/-\=
|/-\|/-\|/-\|/-\|/-\|/                               (256MB, v1.20)   1 Log=
ical Drive






Press <F8> to run the Option ROM Configuration for Arrays Utility          =
 Press <ESC> to skip configuration and continue                            =
 =20

Slot 3                                                            HP Smart =
Array 6400 Controller                        Initializing...  \|/-\|/-\|/-\=
|/-\|                               (192MB, v2.46)   1 Logical Drive






Press <F8> to run the Option ROM Configuration for Arrays Utility          =
 Press <ESC> to skip configuration and continue                            =
 =20

Slot 3                                                            HP Smart =
Array 6400 EM Controller                     Initializing...  -\|/-\|/-\|/-=
\|/-\|                               (192MB, v2.46)   0 Logical Drives
1785-Slot 3 Drive Array Not Configured
     No Drives Detected

Slot 5                                                            HP Smart =
Array P400 Controller                        Initializing...  \|/-\|/-\|/-\=
|/-\|/-\|/-\|/-\|/-\|/                               (256MB, v0.13)   0 Log=
ical Drives
1785-Slot 5 Drive Array Not Configured
     No Drives Detected



HP Ethernet Boot Agent v7.0.3
Copyright (C) 2000,2003 Hewlett-Packard Development Company, L.P.
All rights reserved.
Press Ctrl-S to Enter Configuration Menu ...
 Press "F9" key for ROM-Based Setup Utility
 Press "F10" key for System Maintenance Menu
 Press "F12" key for PXE boot
 For access via BIOS Serial Console
 Press "ESC+9" for ROM-Based Setup Utility
 Press "ESC+0" for System Maintenance Menu
 Press "ESC+@" for PXE boot
Attempting Boot FromCD-ROMAttempting Boot FromFloppy Drive (A:)Attempting B=
oot FromHard Drive (C:)GRUB Loading stage2..

Initializing gfx code...
Memory: 0x34950 - 0x63f80, img data at 0x40e90
kernel (hd0,1)/boot/vmlinuz-2613  root=3D/dev/sda2 vga=3D0x31a selinux=3D0 =
console=3Dtt
yS0,115200 console=3Dtty0 resume=3D/dev/sda3 elevator=3Dcfq
   [Linux-bzImage, setup=3D0x1c00, size=3D0x18c960]
initrd (hd0,1)/boot/initrd-2613
   [Linux-initrd @ 0x37d26000, 0x2c9f20 bytes]

Bootdata ok (command line is root=3D/dev/sda2 vga=3D0x31a selinux=3D0 conso=
le=3DttyS0,115200 console=3Dtty0 resume=3D/dev/sda3 elevator=3Dcfq)
Linux version 2.6.13 (root@aries) (gcc version 3.3.3 (SuSE Linux)) #1 SMP T=
hu Sep 8 14:22:46 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfff3000 (usable)
 BIOS-e820: 00000000dfff3000 - 00000000dfffb000 (ACPI data)
 BIOS-e820: 00000000dfffb000 - 00000000e0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000015bfff000 (usable)
No NUMA configuration found
Faking a node at 0000000000000000-000000015bfff000
Bootmem setup node 0 0000000000000000-000000015bfff000
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       <6>Product ID: PROLIANT     <6>APIC at: 0xFEE00000
Processor #0 15:3 APIC version 20
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC80000.
I/O APIC #10 Version 17 at 0xFEC80100.
Setting APIC routing to flat
Processors: 1
Allocating PCI resources starting at e0000000 (gap: e0000000:1ec00000)
Checking aperture...
Built 1 zonelists
Kernel command line: root=3D/dev/sda2 vga=3D0x31a selinux=3D0 console=3Dtty=
S0,115200 console=3Dtty0 resume=3D/dev/sda3 elevator=3Dcfq
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 3400.320 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Placing software IO TLB between 0x689d000 - 0x889d000
Memory: 5046156k/5701628k available (2098k kernel code, 0k reserved, 1214k =
data, 200k init)
Calibrating delay using timer specific routine.. 6811.38 BogoMIPS (lpj=3D13=
622771)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
Using IO-APIC 8
Using IO-APIC 9
Using IO-APIC 10
Using local APICCtimer interrupts.
Detected 12.501 MHz APIC timer.
Brought up 1 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
NET: Registered protocol family 16
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:00:05.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 193
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 185
PCI->APIC IRQ transform: 0000:00:1d.3[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 217
PCI->APIC IRQ transform: 0000:03:02.0[A] -> IRQ 58
PCI->APIC IRQ transform: 0000:03:03.0[A] -> IRQ 74
PCI->APIC IRQ transform: 0000:03:03.1[B] -> IRQ 50
PCI->APIC IRQ transform: 0000:07:03.0[A] -> IRQ 90
PCI: using PPB 0000:07:01.0[A] to get irq 50
PCI->APIC IRQ transform: 0000:08:04.0[A] -> IRQ 98
PCI: using PPB 0000:07:01.0[B] to get irq 57
PCI->APIC IRQ transform: 0000:08:05.0[B] -> IRQ 122
PCI->APIC IRQ transform: 0000:0b:00.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:01:04.0[A] -> IRQ 201
PCI->APIC IRQ transform: 0000:01:04.2[B] -> IRQ 209
PCI: Cannot allocate resource region 4 of device 0000:00:1d.0
PCI: Cannot allocate resource region 4 of device 0000:00:1d.1
PCI: Cannot allocate resource region 4 of device 0000:00:1d.2
PCI: Cannot allocate resource region 4 of device 0000:00:1d.3
PCI: Bridge: 0000:02:00.0
  IO window: 4000-4fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: e0000000-e02fffff
PCI: Bridge: 0000:07:01.0
  IO window: 5000-5fff
  MEM window: fdd00000-fddfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.2
  IO window: 5000-5fff
  MEM window: fdc00000-fddfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: 4000-5fff
  MEM window: fdb00000-fddfffff
  PREFETCH window: e0000000-e02fffff
PCI: Bridge: 0000:00:04.0
  IO window: 6000-6fff
  MEM window: fde00000-fdffffff
  PREFETCH window: e0300000-e03fffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-3fff
  MEM window: fbf00000-fcffffff
  PREFETCH window: e0400000-e04fffff
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1126195265.908:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
Intel E7520/7320/7525 detected.<6>Disabling irq balancing and affinity
IRQ lockup detection disabled
vesafb: framebuffer at 0xfc000000, mapped to 0xffffc20000080000, using 5120=
k, total 8128k
vesafb: mode is 1280x1024x16, linelength=3D2560, pages=3D2
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
mtrr: type mismatch for fc000000,400000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,200000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,100000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,80000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,40000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,20000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,10000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,8000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,4000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,2000 old: uncachable new: write-combining
mtrr: type mismatch for fc000000,1000 old: uncachable new: write-combining
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0500-0x0507, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0508-0x050f, BIOS settings: hdc:pio, hdd:pio
hda: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
md: md driver 0.90.2 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 3.38
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
input: AT Translated Set 2 keyboard on isa0060/serio0
VFS: Mounted root (ext2 filesystem).
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
SCSI subsystem initialized
Fusion MPT base driver 3.03.02
Copyright (c) 1999-2005 LSI Logic Corporation

--XsQoSWH+UP9D9v3l--
