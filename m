Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279627AbRKVOcj>; Thu, 22 Nov 2001 09:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279722AbRKVOca>; Thu, 22 Nov 2001 09:32:30 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:28690 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S279627AbRKVOcW>;
	Thu, 22 Nov 2001 09:32:22 -0500
Date: Thu, 22 Nov 2001 14:32:16 +0000 (GMT)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA and APM/ACPI issue (xircom card problem)
In-Reply-To: <Pine.LNX.4.33.0111220956200.27255-100000@chaos.tp1.ruhr-uni-bochum.de>
Message-ID: <Pine.LNX.4.32.0111221429030.22550-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > work..
>
> So basically, the problem exists when CONFIG_ACPI=y, right? Can you try to
> boot the ACPI enabled kernel with acpi=off in the command line?

okay one kernel with ACPI it doesn't work with ACPI off it does ...
2.4.15-pre8

> Which exact error do you get from lspci? Does it give the error on both
> kernels?

lspci without ACPI dumps out:
pcilib: Cannot open /proc/bus/pci/02/00.1
lspci: Unable to read 64 bytes of configuration space.

same except 00.1 is 00.7 on the ACPI boot..

I've attached a bootup with ACPI debug switched on there seems to be some
issues but I've no idea what they mean..

Regards,
	Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person

Linux version 2.4.15-pre8-acpi (root@radon) (gcc version 2.95.2 19991024 (release)) #5 Thu Nov 22 14:17:05 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007fec000 (usable)
 BIOS-e820: 0000000007fec000 - 0000000007ff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
On node 0 totalpages: 32748
zone(0): 4096 pages.
zone(1): 28652 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Kernel command line: BOOT_IMAGE=acpi ro root=306 vga=0x0301 noinitrd
Initializing CPU#0
Detected 430.142 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 858.52 BogoMIPS
Memory: 127064k/130992k available (841k kernel code, 3540k reserved, 236k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
devfs: v0.120 (20011103) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:........................................................................................................................................................
152 Control Methods found and parsed (354 nodes total)
ACPI Namespace successfully loaded at root c0252b20
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:.........Ps_execute: method failed - \_SB_.PCI0._INI (c7fa9f08)
  nsinit-0351 [04] Ns_init_one_device    : \   /_SB_PCI0._INI failed: AE_AML_NOT_OWNER
..............Ps_execute: method failed - \_SB_.PCI0.PX40.FDC0._STA (c7fa6408)
  uteval-0337 [05] Ut_execute_STA        : _STA on FDC0 failed AE_AML_NOT_OWNER
...Ps_execute: method failed - \_SB_.PCI0.PX40.UAR1._STA (c7fa5648)
  uteval-0337 [05] Ut_execute_STA        : _STA on UAR1 failed AE_AML_NOT_OWNER
.Ps_execute: method failed - \_SB_.PCI0.PX40.IRDA._STA (c7fa5ac8)
  uteval-0337 [05] Ut_execute_STA        : _STA on IRDA failed AE_AML_NOT_OWNER
.Ps_execute: method failed - \_SB_.PCI0.PX40.ECP_._STA (c7fa5ec8)
  uteval-0337 [05] Ut_execute_STA        : _STA on ECP_ failed AE_AML_NOT_OWNER
.......................
51 Devices found: 47 _STA, 2 _INI
Completing Region and Field initialization:..
0/2 Regions, 2/10 Fields initialized (354 nodes total)
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHH2064AT, ATA DISK drive
hdc: TORiSAN DVD-ROM DRD-U624, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=789/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 200k freed
Adding Swap: 136512k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 14:24:38 Nov 22 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
usb-uhci.c: USB UHCI at I/O 0xdce0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c7cb9480, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: dce0
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7cb9480
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
Linux PCMCIA Card Services 3.1.29
  kernel build: 2.4.15-pre8-acpi #5 Thu Nov 22 14:17:05 GMT 2001
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
  TI 1225 rev 01 PCI-to-CardBus at slot 00:03, mem 0x10000000
    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 4/4]
    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 5/5]
    ISA irqs (scanned) = 3,4,7,10 PCI status changes
cs: cb_alloc(bus 4): vendor 0xffff, device 0xffff
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
apm: overridden by ACPI.
PCI: Found IRQ 5 for device 00:08.0
maestro: Configuring ESS Maestro 2E found at IO 0xD800 IRQ 5
maestro:  subvendor id: 0x00ab1028
maestro: PCI power management capability: 0x7622
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 14:24:22 Nov 22 2001

