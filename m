Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVAUIID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVAUIID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVAUIID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:08:03 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:23752 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261274AbVAUIGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:06:44 -0500
Message-ID: <41F0B807.6000606@kolivas.org>
Date: Fri, 21 Jan 2005 19:06:31 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
References: <20050119213818.55b14bb0.akpm@osdl.org>
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEBF8E953F28412FAD3E1091F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBF8E953F28412FAD3E1091F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm2/
> 
> - There are a bunch of ioctl() and compat_ioctl() changes in here which seem
>   to be of dubious maturity.  Could people involved in this area please
>   review, test and let me know?
> 
> - A revamp of the kexec and crashdump patches.  Anyone who is interested in
>   this work, please help to get this ball rolling a little faster?
> 
> - This kernel isn't particularly well-tested, sorry.  I've been a bit tied
>   up with other stuff.

Wont boot.

Stops after BIOS check successful.
Tried reverting a couple of patches mentioning boot or reboot and had no 
luck. Any ideas?

P4HT3.06 on a P4PE motherboard.

dmesg of working boot:
Linux version 2.6.10-ck5 (con@localhost) (gcc version 3.4.3) #1 SMP Tue 
Jan 18 19:45:16 EST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
  BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
  BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1023MB LOWMEM available.
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=ck5 ro root=305 
netconsole=6665@192.168.1.251/eth0,6666@192.168.1.1/
netconsole: local port 6665
netconsole: local IP 192.168.1.251
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.1.1
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
Initializing CPU#0
CPU 0 irqstacks, hard=b03b7000 soft=b03b5000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3105.371 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1035036k/1048496k available (1565k kernel code, 12932k reserved, 
1012k data, 168k init, 0k h
ighmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
per-CPU timeslice cutoff: 1462.74 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=b03b8000 soft=b03b6000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
Total of 2 processors activated (12320.76 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1e50, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x3a set to 0x80
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Initializing Cryptographic API
vesafb: framebuffer at 0xdc000000, mapped to 0xf0880000, using 1875k, 
total 65536k
vesafb: mode is 800x600x16, linelength=1600, pages=2
vesafb: protected mode interface info at c000:ed00
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin 
is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
elevator: using cfq as default io scheduler
nbd: registered device at major 43
b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 20 (level, low) -> IRQ 20
eth0: Broadcom 4400 10/100BaseT Ethernet 00:e0:18:ed:a2:29
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
netconsole: network logging started
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON DVDRW SOHW-1653S, ATAPI CD/DVD-ROM drive
hdd: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, 
UDMA(100)
  hda: hda1 hda2 < hda5 hda6 hda7 >
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
ACPI wakeup devices:
PCI0 PCI1 PCI2 UAR1 USB0 USB1 USB2 US20 AC97
ACPI: (supports S0 S1 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed


lspci output:
00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM 
Controller/Host-Hub Interface (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP 
Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 
EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge 
(rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) 
UltraATA-100 IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 
440 AGP 8x] (rev a4)
02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
02:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)



--------------enigEBF8E953F28412FAD3E1091F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8LgKZUg7+tp6mRURAopAAJ9EG0gbNB2F6W6DVPzxvQ+tEHqhYgCfUK7w
wCAPDYfTfLfKKSLurxGl6wU=
=0c85
-----END PGP SIGNATURE-----

--------------enigEBF8E953F28412FAD3E1091F--
