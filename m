Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263459AbTC2Un1>; Sat, 29 Mar 2003 15:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263460AbTC2Un1>; Sat, 29 Mar 2003 15:43:27 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:516
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263459AbTC2UnV>; Sat, 29 Mar 2003 15:43:21 -0500
Message-ID: <002401c2f635$8033c050$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - dmesg
Date: Sat, 29 Mar 2003 15:55:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmesg:

Linux version 2.5.66-bk3 (root@coredump) (gcc version 3.2.3 20030208
(prerelease)) #1 Thu Mar 27 12:24:43 EST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffd9c0 (usable)
 BIOS-e820: 0000000007ffd9c0 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32765
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28669 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 IBM                        ) @ 0x000fdfe0
ACPI: RSDT (v001 IBM    CDTPWSNV 00000.04112) @ 0x07ffff80
ACPI: FADT (v001 IBM    CDTPWSNV 00000.04112) @ 0x07ffff00
ACPI: DSDT (v001 IBM    CDTPWSNV 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=newlinux ro root=301
rootflags=data=writeback pci=noacpi console=ttyS2,9600n8
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 448.002 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 884.73 BogoMIPS
Memory: 125148k/131060k available (2735k kernel code, 5376k reserved, 752k
data, 340k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 447.0971 MHz.
..... host bus clock speed is 99.0548 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd83c, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 242 entries (12 bytes)
biovec pool[1]:   4 bvecs: 242 entries (48 bytes)
biovec pool[2]:  16 bvecs: 242 entries (192 bytes)
biovec pool[3]:  64 bvecs: 242 entries (768 bytes)
biovec pool[4]: 128 bvecs: 121 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  60 entries (3072 bytes)
ACPI: Subsystem revision 20030228
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:....................................................................
...........................
Table [DSDT] - 250 Objects with 29 Devices 95 Methods 7 Regions
ACPI Namespace successfully loaded at root c04d4afc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode
successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at
000000000000FD0C
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to
GPE15
Executing all Device _STA and_INI methods:.............................
29 Devices found containing: 29 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package
initialization:.........................
Initialized 2/7 Regions 1/6 Fields 13/15 Buffers 9/9 Packages (250 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Linux Plug and Play Support v0.95 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Found PnP BIOS installation structure at 0xc00fde50
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x587a, dseg 0xf0000
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: match found with the PnP device '00:0d' and the driver 'system'
pnp: match found with the PnP device '00:0e' and the driver 'system'
pnp: match found with the PnP device '00:0f' and the driver 'system'
pnp: match found with the PnP device '00:10' and the driver 'system'
pnp: match found with the PnP device '00:15' and the driver 'system'
PnPBIOS: 21 nodes reported by PnP BIOS; 21 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:02.0
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Capability LSM initialized
There is already a security framework initialized, register_security failed.
Failure registering Root Plug module with the kernel
Failure registering Root Plug  module with primary security module.
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
pnp: Calling quirk for 01:01.00
pnp: SB audio device quirk - increasing port range
pnp: Calling quirk for 01:01.02
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
isapnp: 2 Plug & Play cards detected total
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60
seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:12' and the driver 'serial'
pnp: match found with the PnP device '00:13' and the driver 'serial'
pnp: match found with the PnP device '01:02.00' and the driver 'serial'
pnp: res: the device '01:02.00' has been activated.
ttyS3 at I/O 0x2e8 (irq = 5) is a 16550A
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:14' and the driver 'parport_pc'
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:02.2
e100: selftest OK.
Freeing alive device c7ed8000, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:02.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L040L2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CRD-8400B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: host protected area => 1
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63, UDMA(33)
 hda: hda1 hda2
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
PCI: Found IRQ 9 for device 00:12.0
PCI: Sharing IRQ 9 with 01:01.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: HP        Model: T4000s            Rev: 1.10
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver
v2.0
PCI: Found IRQ 11 for device 00:02.2
PCI: Sharing IRQ 11 with 00:03.0
uhci-hcd 00:02.2: Intel Corp. 82371AB/EB/MB PIIX4
uhci-hcd 00:02.2: irq 11, io base 0000ff00
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:02.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 00:02.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4
usb usb1: Manufacturer: Linux 2.5.66-bk3 uhci-hcd
drivers/usb/host/uhci-hcd.c: ff00: suspend_hc
usb usb1: SerialNumber: 00:02.2
usb usb1: usb_new_device - registering interface 1-0:0
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
sb: Init: Starting Probe...
pnp: the driver 'OSS SndBlstr' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'OSS
SndBlstr'
pnp: res: the device '01:01.00' has been activated.
sb: PnP: Found Card Named = "Audio", Card PnP id = CTL0048, Device PnP id =
CTL0031
sb: PnP:      Detected at: io=0x220, irq=10, dma=1, dma16=5
<Sound Blaster 16 (4.13)> at 0x220 irq 10 dma 1,5
sb: Turning on MPU
<Sound Blaster 16> at 0x300 irq 10
sb: Init: Done
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 128 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 2340)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,1): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 985881
EXT3-fs: ide0(3,1): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with writeback data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 340k freed
Adding 72284k swap on /dev/hda2.  Priority:1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
e100: eth0 NIC Link is Up 100 Mbps Full duplex

----- Original Message -----
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, March 29, 2003 3:45 PM
Subject: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings


> Panic from 2.5.66-bk3 w/ ksymoops dump:
>
> In both panics below c012e9b4 does not exist as a kernel symbol in
> System.map:
> =======================================================
>
> Unable to handle kernel paging request at virtual address 6b6b6b6f
>  printing eip:
> c012e9b4
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c012e9b4>]    Not tainted
> EFLAGS: 00010012
> EIP is at run_timer_softirq+0xe4/0x3f0
> eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: c2e7e150   edx: 6b6b6b6b
> esi: 6b6b6b6b   edi: c114a000   ebp: c0419860   esp: c114bf0c
> ds: 007b   es: 007b   ss: 0068
> Process init (pid: 1, threadinfo=c114a000 task=c114e000)
> Stack: c041a8b0 c011282e c114bf94 c114bf24 c114e5d4 c114bfc4 00000011
> c114a000
>        000000e7 00000092 00000001 c04c9c48 fffffffd 00000046 c012963a
> c04c9c48
>        c114a000 c114a000 00000000 c04183a0 c010cd75 00000000 c114bf94
> c04183a0
> Call Trace:
>  [<c011282e>] timer_interrupt+0x19e/0x3f0
>  [<c012963a>] do_softirq+0x9a/0xa0
>  [<c010cd75>] do_IRQ+0x235/0x370
>  [<c017a557>] sys_stat64+0x37/0x40
>  [<c010ac18>] common_interrupt+0x18/0x20
>  [<c010a2bb>] restore_all+0x1/0xe
>
> Code: 89 50 04 89 02 c7 41 30 00 00 00 00 81 3d 60 98 41 c0 3c 4b
>  kernel/timer.c:258: spin_lock(kernel/timer.c:c0419860) already locked by
> kernel/timer.c/398
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>
>
> ksymoops dump:
>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   89 50 04                  mov    %edx,0x4(%eax)
> Code;  00000003 Before first symbol
>    3:   89 02                     mov    %eax,(%edx)
> Code;  00000005 Before first symbol
>    5:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
> Code;  0000000c Before first symbol
>    c:   81 3d 60 98 41 c0 3c      cmpl   $0x4b3c,0xc0419860
> Code;  00000013 Before first symbol
>   13:   4b 00 00
>
>
> We know this is poisioned ('6b') EIP c012e9b4 is not present in
System.map.
> The machine was on for several hours 8+
>
>
> ................

