Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTGYBtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 21:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTGYBtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 21:49:16 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:31238 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S263590AbTGYBtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 21:49:03 -0400
Message-ID: <3F20900B.7040100@enterprise.bidmc.harvard.edu>
Date: Thu, 24 Jul 2003 22:03:55 -0400
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: ajoshi@kernel.crashing.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Radeon in LK 2.4.21pre7
References: <1058679793.10948.47.camel@ktkhome> <1058878512.532.10.camel@gaston>
In-Reply-To: <1058878512.532.10.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------010709060201030300040905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010709060201030300040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>This looks like erase not working properly... This usually happens
>after switching back from X as X tends to leave some garbage in some
>engine registers, and is usually cured by switching to another console
>
Interesting, I hadn't even bothered to try X at this point, was using 
the console exclusively.  Giving X a whirl, I see what you mean - it 
leaves the screen an unreadable pixel soup upon return to console mode.  
Oddly though, in my case, neither switching consoles nor a gratuitous 
fbset had any effect (though I didn't try all that exhaustively).

>Since your problem seem to not depend on XFree, I suspect something
>else hairy is going on with the engine, I don't know what yet though,
>I'll try to find some clue.
>
OK, per request, output from 'dmesg' attached in its entirety.

The system is based around a Soltek SL75-DRV2 motherboard with an Athlon 
XP, VIA KT266A/8233 and one of the early-production clock-reduced Radeon 
8500LEE boards that were sold initially in Japan (if you believe the 
user-comments on the newegg.com website).

Thanks for investigating!
Kris



I wrote originally,

>Problem #1:  When scrolling, radeonfb fails to erase the portion of the
>> screen at the bottom, leaving all sorts of random pixels in the bottom
>> line.  Further scrolling propagates these pixels upwards.
>> See http://enterprise.bidmc.harvard.edu/~ktk/temp/radeonfb/screen-1.jpg
>> (Sorry for camera-shake; hand-held in dim room...)
>


--------------010709060201030300040905
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.22-pre7 (root@ktkhome) (gcc version 2.95.3 20010315 (release)) #1 Sat Jul 19 22:13:46 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 VIA694                     ) @ 0x000f67c0
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=N22p7 ro root=301 reboot=warm hdc=ide-scsi video=radeonfb:1280x1024-8@85
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1477.531 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 2949.12 BogoMIPS
Memory: 515656k/524224k available (1551k kernel code, 8180k reserved, 594k data, 108k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1477.4883 MHz.
..... host bus clock speed is 268.6340 MHz.
cpu: 0, clocks: 2686340, slice: 1343170
CPU0<T0:2686336,T1:1343152,D:14,S:1343170,C:2686340>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
radeonfb: ref_clk=2700, ref_div=12, xclk=23000 from BIOS
Console: switching to colour frame buffer device 53x21
radeonfb: ATI Radeon 8500 QL DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe4819000, 00:c0:26:6f:2a:34, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L120AVV207-1, ATA DISK drive
hdb: CD-W524E, ATAPI CD/DVD-ROM drive
blk: queue c0363f40, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=15017/255/63, UDMA(100)
hdb: attached ide-cdrom driver.
hdb: ATAPI 40X CD-ROM CD-R/RW drive, 1404kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:09.2: NEC Corporation USB 2.0
ehci_hcd 00:09.2: irq 5, pci mem e4835000
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:09.2 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.
PCI: 00:09.2 PCI cache line size corrected to 64.
ehci_hcd 00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 5 ports detected
host/usb-uhci.c: $Revision: 1.275 $ time 22:15:54 Jul 19 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 5
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 5
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 5
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: USB OHCI at membase 0xe4837000, IRQ 11
host/usb-ohci.c: usb-00:09.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 5
hub.c: USB hub found
hub.c: 3 ports detected
host/usb-ohci.c: USB OHCI at membase 0xe4839000, IRQ 11
host/usb-ohci.c: usb-00:09.1, NEC Corporation USB (#2)
usb.c: new USB bus registered, assigned bus number 6
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: new USB device 00:09.2-5, assigned address 2
hub.c: USB hub found
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: 4 ports detected
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 108k freed
hub.c: new USB device 00:09.0-1, assigned address 2
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1004
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 2008084k swap-space (priority -1)
Adding Swap: 2008084k swap-space (priority -2)
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
PCI: Setting latency timer of device 00:11.5 to 64
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
[fglrx] module loaded - fglrx 2.5.1 [Nov 27 2002] on minor 0
hub.c: new USB device 00:09.2-5.4, assigned address 3
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Maxtor 4  Model: G160J8            Rev: GAK8
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 268435455 512-byte hdwr sectors (137439 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
spurious 8259A interrupt: IRQ7.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.

--------------010709060201030300040905--

