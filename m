Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132163AbRAASgE>; Mon, 1 Jan 2001 13:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRAASfy>; Mon, 1 Jan 2001 13:35:54 -0500
Received: from web1103.mail.yahoo.com ([128.11.23.123]:21776 "HELO
	web1103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132174AbRAASfo>; Mon, 1 Jan 2001 13:35:44 -0500
Message-ID: <20010101180517.27929.qmail@web1103.mail.yahoo.com>
Date: Mon, 1 Jan 2001 10:05:17 -0800 (PST)
From: Scott Conway <misassistant@yahoo.com>
Subject: 2.4 kernel halting...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm having problems getting anything from
2.4.0-test12 onward to get past the IDE detectin phase
of bootup, and not even 2.4.0-prerelease will work,
either.  At the bottom of this is the output of dmesg,
on my current kernel (2.4.0-test11), with the spot
where test12+ freezes indicated.  btw...does anyone
out there know how to capture output on a bad kernel;
since the one I'm having trouble with never gets far
enough for me to check for an oops with an externel
program?  You can locate the point where I get the
freeze by the whole line of '*' to show where it locks
up.  Also, please forward any replies to my e-mail
since I don't subscribe to linux-kernel due to
excessive traffic on my end.  Thanks, and below is
dmesg output...

------------------------Cut
Here-----------------------
Linux version 2.4.0-test11-ac4 (root@ummagumma) (gcc
version 2.95.3 19991030 (prerelease)) #1 Wed Dec 27
03:15:22 EST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000
(usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00
(reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000
(reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000
(usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000
(reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000
(reserved)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000
(reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: BOOT_IMAGE=Linux ro root=302
adlib=0x388 ftape=1,fc10 ftape=9,irq ftape=0,dma
ide0=autotune ide1=autotune idebus=66 lp=auto
parport=0x378,7,3 pci=biosirq sb=0x220,5,1,7
video=matrox:disabled
[000] ftape-setup.c (ftape_setup) - fc10=1.
[001] ftape-setup.c (ftape_setup) - irq=9.
[002] ftape-setup.c (ftape_setup) - dma=0.
ide_setup: ide0=autotune
ide_setup: ide1=autotune
ide_setup: idebus=66
Initializing CPU#0
Detected 199.966 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 398.95 BogoMIPS
Memory: 126276k/131072k available (1634k kernel code,
4408k reserved, 116k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5,
131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768
bytes)
Page-cache hash table entries: 32768 (order: 5, 131072
bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536
bytes)
CPU: Before vendor init, caps: 008001bf 00000000
00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000
00000000 00000000
CPU: After generic, caps: 008001bf 00000000 00000000
00000000
CPU: Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last
bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using BIOS Interrupt Routing Table
PCI: Using BIOS for IRQ routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society
NET3.039
DMI 2.0 present.
0 structures occupying 0 bytes.
DMI table at 0x000F0000.
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 1
0x378: readIntrThreshold is 1
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
ftape v3.04d 25/11/97 for Linux 2.4.0-test11-ac4
[003] ftape-init.c (ftape_init) - installing QIC-117
floppy tape hardware drive ... .
[004] ftape-init.c (ftape_init) - ftape_init @
0xc02c3910.
[005]   ftape-buffer.c (add_one_buffer) - buffer nr #1
@ c12e04e0, dma area @ c0328000.
[006]   ftape-buffer.c (add_one_buffer) - buffer nr #2
@ c12e0560, dma area @ c0090000.
[007]   ftape-buffer.c (add_one_buffer) - buffer nr #3
@ c12e05e0, dma area @ c0008000.
[008]   ftape-calibr.c (time_inb) - inb() duration:
394 nsec.
[009]  ftape-calibr.c (ftape_calibrate) - TC for
`ftape_udelay()' = 570 nsec (at 10239 counts).
[010]  ftape-calibr.c (ftape_calibrate) - TC for
`fdc_wait()' = 1926 nsec (at 5119 counts).
zftape for ftape v3.04d 25/11/97 for Linux
2.4.0-test11-ac4
[011]  zftape-init.c (zft_init) - zft_init @
0xc02c3cd0.
[012]  zftape-init.c (zft_init) - installing zftape
VFS interface for ftape driver ....
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: Assigned IRQ 14 for device 00:0b.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings:
hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings:
hdc:pio, hdd:pio
hda: Maxtor 32049H2, ATA DISK drive
hdb: WDC AC21600H, ATA DISK drive
hdc: Maxtor 71626 A, ATA DISK drive
hdd: BCD-40XH CD-ROM, ATAPI CDROM drive

*******************************************************
This is the last line of bootup I see before the
kernel freezes.
*******************************************************

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40021632 sectors (20491 MB) w/2048KiB Cache,
CHS=2491/255/63, (U)DMA
hdb: 3173184 sectors (1625 MB) w/128KiB Cache,
CHS=787/64/63, DMA
hdc: 3184170 sectors (1630 MB) w/64KiB Cache,
CHS=3158/16/63, DMA
hdd: ATAPI 24X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.11
Partition check:
 hda: hda1 hda2
 hdb: hdb1
 hdc: [PTBL] [789/64/63] hdc1 hdc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with
MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
input0: Analog 3-axis 4-button joystick at gameport0.0
[TSC timer, 200 MHz clock, 1674 ns res]
gameport0: NS558 ISA at 0x200 size 8 speed 602 kHz
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
YM3812 and OPL-3 driver Copyright (C) by Hannu
Savolainen, Rob Hooft 1993-1996
Soundblaster audio driver Copyright (C) by Hannu
Savolainen 1993-1996
<Sound Blaster 16 (4.12)> at 0x220 irq 5 dma 1,7
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xc8806000, IRQ 11
usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [ALi]
M5237 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
usb.c: registered new driver usblp
event0: Event device for input0
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind
8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
hub.c: USB new device connect on bus1/2, assigned
device number 2
usb.c: USB device 2 (vend/prod 0x3f0/0x405) is not
claimed by any active driver.
Adding Swap: 54424k swap-space (priority -1)


__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
