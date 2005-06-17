Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVFQK67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVFQK67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 06:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVFQK66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 06:58:58 -0400
Received: from pppoe240-static-luxdsl-128.pt.lu ([213.135.240.128]:43609 "EHLO
	server.intern.prnet.org") by vger.kernel.org with ESMTP
	id S261944AbVFQK4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 06:56:09 -0400
Message-ID: <42B2AC3E.5090602@prnet.org>
Date: Fri, 17 Jun 2005 12:55:58 +0200
From: David Arendt <admin@prnet.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.10 software-raid,ide and usb problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a strange problem:

I used a software-raid 5 in kernel 2.6.10 with 4 ide drives, 3 on the 
mainboard buitlin ide ports, and one on an external ide controller. This 
configuration worked fine for 3 months. Until yet, usb was disabled on 
this system as there was no need for it. When I recompile the kernel 
with usb enabled, I receive DriveReady SeekComplete errrors on booting. 
They happen for hdb1 and hde1. Both disks are on different types of ide 
controllers, so it should not be a controller specific issue. When I 
recompile the same kernel without usb support everything works fine.

Any thoughts what could be the problem ?

As I am not subscribed to the mailinglist, could you please CC the reply 
to me ?

Bye,
David Arendt

For reference here the dmesg output for the failing case:

Jun 17 10:30:49 server kernel: Kernel logging (proc) stopped.
Jun 17 10:30:49 server kernel: Kernel log daemon terminating.
Jun 17 10:34:53 server kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jun 17 10:34:53 server kernel: Inspecting /boot/System.map
Jun 17 10:34:53 server kernel: Loaded 32466 symbols from /boot/System.map.
Jun 17 10:34:53 server kernel: Symbols match kernel version 2.6.10.
Jun 17 10:34:53 server kernel: No module symbols loaded - kernel modules 
not enabled.
Jun 17 10:34:53 server kernel: Linux version 2.6.10server (root@server) 
(gcc version 3.3.3) #19 Fri Jun 17 10:29:40 CEST 2005
Jun 17 10:34:53 server kernel: BIOS-provided physical RAM map:
Jun 17 10:34:53 server kernel:  BIOS-e820: 0000000000000000 - 
000000000009e800 (usable)
Jun 17 10:34:53 server kernel:  BIOS-e820: 000000000009e800 - 
00000000000a0000 (reserved)
Jun 17 10:34:53 server kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Jun 17 10:34:53 server kernel:  BIOS-e820: 0000000000100000 - 
000000001fff0000 (usable)
Jun 17 10:34:53 server kernel:  BIOS-e820: 000000001fff0000 - 
000000001fff3000 (ACPI NVS)
Jun 17 10:34:53 server kernel:  BIOS-e820: 000000001fff3000 - 
0000000020000000 (ACPI data)
Jun 17 10:34:53 server kernel:  BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
Jun 17 10:34:53 server kernel:  BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
Jun 17 10:34:53 server kernel:  BIOS-e820: 00000000ffb00000 - 
0000000100000000 (reserved)
Jun 17 10:34:53 server kernel: 511MB LOWMEM available.
Jun 17 10:34:53 server kernel: On node 0 totalpages: 131056
Jun 17 10:34:53 server kernel:   DMA zone: 4096 pages, LIFO batch:1
Jun 17 10:34:53 server kernel:   Normal zone: 126960 pages, LIFO batch:16
Jun 17 10:34:53 server kernel:   HighMem zone: 0 pages, LIFO batch:1
Jun 17 10:34:53 server kernel: DMI 2.3 present.
Jun 17 10:34:53 server kernel: ACPI: RSDP (v000 
AOpen                                 ) @ 0x000f6820
Jun 17 10:34:53 server kernel: ACPI: RSDT (v001 AOpen  AWRDACPI 
0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Jun 17 10:34:53 server kernel: ACPI: FADT (v001 AOpen  AWRDACPI 
0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Jun 17 10:34:53 server kernel: ACPI: MADT (v001 AOpen  AWRDACPI 
0x42302e31 AWRD 0x00000000) @ 0x1fff6f40
Jun 17 10:34:53 server kernel: ACPI: DSDT (v001 AOPEN  AWRDACPI 
0x00001000 MSFT 0x0100000c) @ 0x00000000
Jun 17 10:34:53 server kernel: ACPI: PM-Timer IO Port: 0x4008
Jun 17 10:34:53 server kernel: Built 1 zonelists
Jun 17 10:34:53 server kernel: Kernel command line: root=/dev/hda2
Jun 17 10:34:53 server kernel: Initializing CPU#0
Jun 17 10:34:53 server kernel: PID hash table entries: 2048 (order: 11, 
32768 bytes)
Jun 17 10:34:53 server kernel: Detected 2400.383 MHz processor.
Jun 17 10:34:53 server kernel: Using pmtmr for high-res timesource
Jun 17 10:34:53 server kernel: Console: colour VGA+ 80x25
Jun 17 10:34:53 server kernel: Dentry cache hash table entries: 131072 
(order: 7, 524288 bytes)
Jun 17 10:34:53 server kernel: Inode-cache hash table entries: 65536 
(order: 6, 262144 bytes)
Jun 17 10:34:53 server kernel: Memory: 514188k/524224k available (2990k 
kernel code, 9492k reserved, 1241k data, 148k init, 0k highmem)
Jun 17 10:34:53 server kernel: Checking if this processor honours the WP 
bit even in supervisor mode... Ok.
Jun 17 10:34:53 server kernel: Calibrating delay loop... 4751.36 
BogoMIPS (lpj=2375680)
Jun 17 10:34:53 server kernel: Mount-cache hash table entries: 512 
(order: 0, 4096 bytes)
Jun 17 10:34:53 server kernel: CPU: After generic identify, caps: 
3febfbff 00000000 00000000 00000000
Jun 17 10:34:53 server kernel: CPU: After vendor identify, caps:  
3febfbff 00000000 00000000 00000000
Jun 17 10:34:53 server kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun 17 10:34:53 server kernel: CPU: L2 cache: 512K
Jun 17 10:34:53 server kernel: CPU: After all inits, caps:        
3febfbff 00000000 00000000 00000080
Jun 17 10:34:53 server kernel: Intel machine check architecture supported.
Jun 17 10:34:53 server kernel: Intel machine check reporting enabled on 
CPU#0.
Jun 17 10:34:53 server kernel: CPU0: Intel P4/Xeon Extended MCE MSRs 
(12) available
Jun 17 10:34:53 server kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz 
stepping 04
Jun 17 10:34:53 server kernel: Enabling fast FPU save and restore... done.
Jun 17 10:34:53 server kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jun 17 10:34:53 server kernel: Checking 'hlt' instruction... OK.
Jun 17 10:34:53 server kernel: ACPI: setting ELCR to 0200 (from 0c80)
Jun 17 10:34:53 server kernel: NET: Registered protocol family 16
Jun 17 10:34:53 server kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfb160, last bus=2
Jun 17 10:34:53 server kernel: PCI: Using configuration type 1
Jun 17 10:34:53 server kernel: mtrr: v2.0 (20020519)
Jun 17 10:34:53 server kernel: ACPI: Subsystem revision 20041105
Jun 17 10:34:53 server kernel: ACPI: Interpreter enabled
Jun 17 10:34:53 server kernel: ACPI: Using PIC for interrupt routing
Jun 17 10:34:53 server kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 17 10:34:53 server kernel: PCI: Probing PCI hardware (bus 00)
Jun 17 10:34:53 server kernel: PCI: Ignoring BAR0-3 of IDE controller 
0000:00:1f.1
Jun 17 10:34:53 server kernel: PCI: Transparent bridge - 0000:00:1e.0
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.HUB0._PRT]
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 
5 6 *7 9 10 11 12 14 15)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 
5 6 7 9 10 *11 12 14 15)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 
5 6 *7 9 10 11 12 14 15)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 
5 6 7 9 *10 11 12 14 15)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 
5 6 7 9 10 11 12 14 15) *0, disabled.
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 
5 6 7 9 10 *11 12 14 15)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 
5 6 7 9 10 11 12 14 15) *0, disabled.
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 
5 6 7 9 *10 11 12 14 15)
Jun 17 10:34:53 server kernel: SCSI subsystem initialized
Jun 17 10:34:53 server kernel: usbcore: registered new driver usbfs
Jun 17 10:34:53 server kernel: usbcore: registered new driver hub
Jun 17 10:34:53 server kernel: PCI: Using ACPI for IRQ routing
Jun 17 10:34:53 server kernel: ** PCI interrupts are no longer routed 
automatically.  If this
Jun 17 10:34:53 server kernel: ** causes a device to stop working, it is 
probably because the
Jun 17 10:34:53 server kernel: ** driver failed to call 
pci_enable_device().  As a temporary
Jun 17 10:34:53 server kernel: ** workaround, the "pci=routeirq" 
argument restores the old
Jun 17 10:34:53 server kernel: ** behavior.  If this argument makes the 
device work again,
Jun 17 10:34:53 server kernel: ** please email the output of "lspci" to 
bjorn.helgaas@hp.com
Jun 17 10:34:53 server kernel: ** so I can fix the driver.
Jun 17 10:34:53 server kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Jun 17 10:34:53 server kernel: ACPI: Fan [FAN] (on)
Jun 17 10:34:53 server kernel: ACPI: Processor [CPU0] (supports 2 
throttling states)
Jun 17 10:34:53 server kernel: ACPI: Thermal Zone [THRM] (41 C)
Jun 17 10:34:53 server kernel: Real Time Clock Driver v1.12
Jun 17 10:34:53 server kernel: Linux agpgart interface v0.100 (c) Dave Jones
Jun 17 10:34:53 server kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 17 10:34:53 server kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 17 10:34:53 server kernel: Serial: 8250/16550 driver $Revision: 1.90 
$ 8 ports, IRQ sharing disabled
Jun 17 10:34:53 server kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 17 10:34:53 server kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jun 17 10:34:53 server kernel: io scheduler noop registered
Jun 17 10:34:53 server kernel: io scheduler anticipatory registered
Jun 17 10:34:53 server kernel: io scheduler deadline registered
Jun 17 10:34:53 server kernel: io scheduler cfq registered
Jun 17 10:34:53 server kernel: elevator: using anticipatory as default 
io scheduler
Jun 17 10:34:53 server kernel: Floppy drive(s): fd0 is 1.44M
Jun 17 10:34:53 server kernel: FDC 0 is a post-1991 82077
Jun 17 10:34:53 server kernel: loop: loaded (max 8 devices)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKD] enabled 
at IRQ 10
Jun 17 10:34:53 server kernel: PCI: setting IRQ 10 as level-triggered
Jun 17 10:34:53 server kernel: ACPI: PCI interrupt 0000:02:07.0[A] -> 
GSI 10 (level, low) -> IRQ 10
Jun 17 10:34:53 server kernel: 3c59x: Donald Becker and others. 
www.scyld.com/network/vortex.html
Jun 17 10:34:53 server kernel: 0000:02:07.0: 3Com PCI 3c905C Tornado at 
0x9000. Vers LK1.1.19
Jun 17 10:34:53 server kernel: Linux video capture interface: v1.00
Jun 17 10:34:53 server kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Jun 17 10:34:53 server kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Jun 17 10:34:53 server kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKC] enabled 
at IRQ 7
Jun 17 10:34:53 server kernel: PCI: setting IRQ 7 as level-triggered
Jun 17 10:34:53 server kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> 
GSI 7 (level, low) -> IRQ 7
Jun 17 10:34:53 server kernel: ICH4: chipset revision 1
Jun 17 10:34:53 server kernel: ICH4: not 100%% native mode: will probe 
irqs later
Jun 17 10:34:53 server kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:DMA
Jun 17 10:34:53 server kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:DMA, hdd:DMA
Jun 17 10:34:53 server kernel: Probing IDE interface ide0...
Jun 17 10:34:53 server kernel: hda: WDC WD800BB-00CAA1, ATA DISK drive
Jun 17 10:34:53 server kernel: hdb: Maxtor 7Y250P0, ATA DISK drive
Jun 17 10:34:53 server kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 17 10:34:53 server kernel: Probing IDE interface ide1...
Jun 17 10:34:53 server kernel: hdc: Maxtor 7Y250P0, ATA DISK drive
Jun 17 10:34:53 server kernel: hdd: Maxtor 7Y250P0, ATA DISK drive
Jun 17 10:34:53 server kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 17 10:34:53 server kernel: PDC20268: IDE controller at PCI slot 
0000:02:0b.0
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKF] enabled 
at IRQ 11
Jun 17 10:34:53 server kernel: PCI: setting IRQ 11 as level-triggered
Jun 17 10:34:53 server kernel: ACPI: PCI interrupt 0000:02:0b.0[A] -> 
GSI 11 (level, low) -> IRQ 11
Jun 17 10:34:53 server kernel: PDC20268: chipset revision 2
Jun 17 10:34:53 server kernel: PDC20268: 100%% native mode on irq 11
Jun 17 10:34:53 server kernel:     ide2: BM-DMA at 0xa400-0xa407, BIOS 
settings: hde:pio, hdf:pio
Jun 17 10:34:53 server kernel:     ide3: BM-DMA at 0xa408-0xa40f, BIOS 
settings: hdg:pio, hdh:pio
Jun 17 10:34:53 server kernel: Probing IDE interface ide2...
Jun 17 10:34:53 server kernel: hde: Maxtor 7Y250P0, ATA DISK drive
Jun 17 10:34:53 server kernel: ide2 at 0x9400-0x9407,0x9802 on irq 11
Jun 17 10:34:53 server kernel: Probing IDE interface ide3...
Jun 17 10:34:53 server kernel: Probing IDE interface ide3...
Jun 17 10:34:53 server kernel: Probing IDE interface ide4...
Jun 17 10:34:53 server kernel: ide4: Wait for ready failed before probe !
Jun 17 10:34:53 server kernel: Probing IDE interface ide5...
Jun 17 10:34:53 server kernel: ide5: Wait for ready failed before probe !
Jun 17 10:34:53 server kernel: hda: max request size: 128KiB
Jun 17 10:34:53 server kernel: hda: 156301488 sectors (80026 MB) 
w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jun 17 10:34:53 server kernel: hda: cache flushes not supported
Jun 17 10:34:53 server kernel:  hda: hda1 hda2 hda3 hda4
Jun 17 10:34:53 server kernel: hdb: max request size: 1024KiB
Jun 17 10:34:53 server kernel: hdb: 490234752 sectors (251000 MB) 
w/7936KiB Cache, CHS=30515/255/63, UDMA(100)
Jun 17 10:34:53 server kernel: hdb: cache flushes supported
Jun 17 10:34:53 server kernel:  hdb: hdb1
Jun 17 10:34:53 server kernel: hdc: max request size: 1024KiB
Jun 17 10:34:53 server kernel: hdc: 490234752 sectors (251000 MB) 
w/7936KiB Cache, CHS=30515/255/63, UDMA(100)
Jun 17 10:34:53 server kernel: hdc: cache flushes supported
Jun 17 10:34:53 server kernel:  hdc: hdc1
Jun 17 10:34:53 server kernel: hdd: max request size: 1024KiB
Jun 17 10:34:53 server kernel: hdd: 490234752 sectors (251000 MB) 
w/7936KiB Cache, CHS=30515/255/63, UDMA(100)
Jun 17 10:34:53 server kernel: hdd: cache flushes supported
Jun 17 10:34:53 server kernel:  hdd: hdd1
Jun 17 10:34:53 server kernel: hde: max request size: 1024KiB
Jun 17 10:34:53 server kernel: hde: 490234752 sectors (251000 MB) 
w/7936KiB Cache, CHS=30515/255/63, UDMA(100)
Jun 17 10:34:53 server kernel: hde: cache flushes supported
Jun 17 10:34:53 server kernel:  hde: hde1
Jun 17 10:34:53 server kernel: sbp2: $Rev: 1219 $ Ben Collins 
<bcollins@debian.org>
Jun 17 10:34:53 server kernel: USB Universal Host Controller Interface 
driver v2.2
Jun 17 10:34:53 server kernel: PCI: Enabling device 0000:00:1d.0 (0000 
-> 0001)
Jun 17 10:34:53 server kernel: ACPI: PCI Interrupt Link [LNKA] enabled 
at IRQ 7
Jun 17 10:34:53 server kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> 
GSI 7 (level, low) -> IRQ 7
Jun 17 10:34:53 server kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Jun 17 10:34:53 server kernel: PCI: Setting latency timer of device 
0000:00:1d.0 to 64
Jun 17 10:34:53 server kernel: uhci_hcd 0000:00:1d.0: irq 7, io base 0xb800
Jun 17 10:34:53 server kernel: uhci_hcd 0000:00:1d.0: new USB bus 
registered, assigned bus number 1
Jun 17 10:34:53 server kernel: hub 1-0:1.0: USB hub found
Jun 17 10:34:53 server kernel: hub 1-0:1.0: 2 ports detected
Jun 17 10:34:53 server kernel: mice: PS/2 mouse device common for all mice
Jun 17 10:34:53 server kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Jun 17 10:34:53 server kernel: input: ImExPS/2 Generic Explorer Mouse on 
isa0060/serio1
Jun 17 10:34:53 server kernel: input: PC Speaker
Jun 17 10:34:53 server kernel: i2c /dev entries driver
Jun 17 10:34:53 server kernel: md: raid5 personality registered as nr 4
Jun 17 10:34:53 server kernel: raid5: automatically using best 
checksumming function: pIII_sse
Jun 17 10:34:53 server kernel:    pIII_sse  :  3024.000 MB/sec
Jun 17 10:34:53 server kernel: raid5: using function: pIII_sse (3024.000 
MB/sec)
Jun 17 10:34:53 server kernel: md: md driver 0.90.1 MAX_MD_DEVS=256, 
MD_SB_DISKS=27
Jun 17 10:34:53 server kernel: ISDN subsystem Rev: 
1.1.2.3/1.1.2.3/1.1.2.2/none/1.1.2.2/1.1.2.2
Jun 17 10:34:53 server kernel: dss1_divert module successfully installed
Jun 17 10:34:53 server kernel: Advanced Linux Sound Architecture Driver 
Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
Jun 17 10:34:53 server kernel: ALSA device list:
Jun 17 10:34:53 server kernel:   No soundcards found.
Jun 17 10:34:53 server kernel: NET: Registered protocol family 2
Jun 17 10:34:53 server kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Jun 17 10:34:53 server kernel: TCP: Hash tables configured (established 
32768 bind 65536)
Jun 17 10:34:53 server kernel: NET: Registered protocol family 1
Jun 17 10:34:53 server kernel: NET: Registered protocol family 17
Jun 17 10:34:53 server kernel: md: Autodetecting RAID arrays.
Jun 17 10:34:53 server kernel: md: autorun ...
Jun 17 10:34:53 server kernel: md: considering hde1 ...
Jun 17 10:34:53 server kernel: md:  adding hde1 ...
Jun 17 10:34:53 server kernel: md:  adding hdd1 ...
Jun 17 10:34:53 server kernel: md:  adding hdc1 ...
Jun 17 10:34:53 server kernel: md:  adding hdb1 ...
Jun 17 10:34:53 server kernel: md: created md0
Jun 17 10:34:53 server kernel: md: bind<hdb1>
Jun 17 10:34:53 server kernel: md: bind<hdc1>
Jun 17 10:34:53 server kernel: md: bind<hdd1>
Jun 17 10:34:53 server kernel: md: bind<hde1>
Jun 17 10:34:53 server kernel: md: running: <hde1><hdd1><hdc1><hdb1>
Jun 17 10:34:53 server kernel: raid5: device hde1 operational as raid disk 3
Jun 17 10:34:53 server kernel: raid5: device hdd1 operational as raid disk 2
Jun 17 10:34:53 server kernel: raid5: device hdc1 operational as raid disk 1
Jun 17 10:34:53 server kernel: raid5: device hdb1 operational as raid disk 0
Jun 17 10:34:53 server kernel: raid5: allocated 4194kB for md0
Jun 17 10:34:53 server kernel: raid5: raid level 5 set md0 active with 4 
out of 4 devices, algorithm 2
Jun 17 10:34:53 server kernel: RAID5 conf printout:
Jun 17 10:34:53 server kernel:  --- rd:4 wd:4 fd:0
Jun 17 10:34:53 server kernel:  disk 0, o:1, dev:hdb1
Jun 17 10:34:53 server kernel:  disk 1, o:1, dev:hdc1
Jun 17 10:34:53 server kernel:  disk 2, o:1, dev:hdd1
Jun 17 10:34:53 server kernel:  disk 3, o:1, dev:hde1
Jun 17 10:34:53 server kernel: md: ... autorun DONE.
Jun 17 10:34:53 server kernel: ReiserFS: hda2: found reiserfs format 
"3.6" with standard journal
Jun 17 10:34:53 server kernel: ReiserFS: hda2: using ordered data mode
Jun 17 10:34:53 server kernel: ReiserFS: hda2: journal params: device 
hda2, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 17 10:34:53 server kernel: ReiserFS: hda2: checking transaction log 
(hda2)
Jun 17 10:34:53 server kernel: ReiserFS: hda2: Using r5 hash to sort names
Jun 17 10:34:53 server kernel: VFS: Mounted root (reiserfs filesystem) 
readonly.
Jun 17 10:34:53 server kernel: Freeing unused kernel memory: 148k freed
Jun 17 10:34:53 server kernel: Adding 1953496k swap on /dev/hda3.  
Priority:1 extents:1
Jun 17 10:34:53 server kernel: ReiserFS: hda1: found reiserfs format 
"3.6" with standard journal
Jun 17 10:34:53 server kernel: ReiserFS: hda1: using ordered data mode
Jun 17 10:34:53 server kernel: ReiserFS: hda1: journal params: device 
hda1, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 17 10:34:53 server kernel: ReiserFS: hda1: checking transaction log 
(hda1)
Jun 17 10:34:53 server kernel: ReiserFS: hda1: Using r5 hash to sort names
Jun 17 10:34:53 server kernel: ReiserFS: hda4: found reiserfs format 
"3.6" with standard journal
Jun 17 10:34:53 server kernel: ReiserFS: hda4: using ordered data mode
Jun 17 10:34:53 server kernel: ReiserFS: hda4: journal params: device 
hda4, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Jun 17 10:34:53 server kernel: ReiserFS: hda4: checking transaction log 
(hda4)
Jun 17 10:34:53 server kernel: ReiserFS: hda4: Using r5 hash to sort names
Jun 17 10:34:53 server kernel: hdb: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jun 17 10:34:53 server kernel: hdb: dma_intr: error=0x40 { 
UncorrectableError }, LBAsect=365071935, high=21, low=12750399, 
sector=365071935
Jun 17 10:34:53 server kernel: ide: failed opcode was: unknown
Jun 17 10:34:53 server kernel: end_request: I/O error, dev hdb, sector 
365071935
Jun 17 10:34:53 server kernel: raid5: Disk failure on hdb1, disabling 
device. Operation continuing on 3 devices
Jun 17 10:34:53 server kernel: RAID5 conf printout:
Jun 17 10:34:53 server kernel:  --- rd:4 wd:3 fd:1
Jun 17 10:34:53 server kernel:  disk 0, o:0, dev:hdb1
Jun 17 10:34:53 server kernel:  disk 1, o:1, dev:hdc1
Jun 17 10:34:53 server kernel:  disk 2, o:1, dev:hdd1
Jun 17 10:34:53 server kernel:  disk 3, o:1, dev:hde1
Jun 17 10:34:53 server kernel: RAID5 conf printout:
Jun 17 10:34:53 server kernel:  --- rd:4 wd:3 fd:1
Jun 17 10:34:53 server kernel:  disk 1, o:1, dev:hdc1
Jun 17 10:34:53 server kernel:  disk 2, o:1, dev:hdd1
Jun 17 10:34:53 server kernel:  disk 3, o:1, dev:hde1
Jun 17 10:34:53 server kernel: hde: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jun 17 10:34:53 server kernel: hde: dma_intr: error=0x40 { 
UncorrectableError }, LBAsect=396847679, high=23, low=10971711, 
sector=396847679
Jun 17 10:34:53 server kernel: ide: failed opcode was: unknown
Jun 17 10:34:53 server kernel: end_request: I/O error, dev hde, sector 
396847679
Jun 17 10:34:53 server kernel: raid5: Disk failure on hde1, disabling 
device. Operation continuing on 2 devices
Jun 17 10:34:53 server kernel: RAID5 conf printout:
Jun 17 10:34:53 server kernel:  --- rd:4 wd:2 fd:2
Jun 17 10:34:53 server kernel:  disk 1, o:1, dev:hdc1
Jun 17 10:34:53 server kernel:  disk 2, o:1, dev:hdd1
Jun 17 10:34:53 server kernel:  disk 3, o:0, dev:hde1
Jun 17 10:34:53 server kernel: RAID5 conf printout:
Jun 17 10:34:53 server kernel:  --- rd:4 wd:2 fd:2
Jun 17 10:34:53 server kernel:  disk 1, o:1, dev:hdc1
Jun 17 10:34:53 server kernel:  disk 2, o:1, dev:hdd1

