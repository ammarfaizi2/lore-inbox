Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbTGCWQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTGCWQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:16:14 -0400
Received: from gutemberg-1-81-57-26-150.fbx.proxad.net ([81.57.26.150]:18635
	"EHLO charlus.dyndns.org") by vger.kernel.org with ESMTP
	id S265426AbTGCWPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:15:46 -0400
Message-ID: <3F04AE6A.8000504@ruault.com>
Date: Fri, 04 Jul 2003 00:30:02 +0200
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 , large disk write => system crawls
References: <3F04A172.5020204@ruault.com> <20030704000236.A23027@electric-eye.fr.zoreil.com>
In-Reply-To: <20030704000236.A23027@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:

>Charles-Edouard Ruault <ce@ruault.com> :
>[...]
>  
>
>>when i do a large disk write operation ( copy a big file for example ), 
>>the whole system becomes very busy ( system goes into 99% cpu 
>>utilization in kernel mode ), other tasks are stopped ( for example 
>>    
>>
>
>Please add:
>- 'vmstat 1' output before/after/during slowdown;
>- dmesg output after boot.
>
Hi Francois,
thanks a lot for the quick reply.

Here it is the info you requested  ( just did tar xvjf 
linux-2.4.21.tar.bz2 )

  procs                      memory      swap          io     
system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id
 1  0  0  21612  33752  33048 337852    0    0     4    14   60    14 
19  3 78
 0  0  0  21612  33748  33048 337852    0    0     0     0  360   695  
1  8 91
 3  0  0  21612  28580  33088 339168    0    0   456     0 1013  1379 40 
14 47
 4  0  0  21612  26616  33176 340924    0    0   280  1384 3953  1095 55 
45  0
 3  0  0  21612  23172  33324 344056    0    0   460     0 1024  2354 78 
22  0
 2  1  0  21612  18368  33408 348596    0    0   668     0 1953  2757 57 
40  3
 3  0  0  21612  13300  33628 353216    0    0   720     0 1532  2537 67 
25  8
 3  0  0  21612   8024  33772 357920    0    0   736     0 2065  2373 54 
41  5
 4  0  1  21612   6536  33844 359192    0    0   284 17736 36558   922  
6 94  0
 5  0  0  21612   4440  34072 361008    0    0   628     0 1816  2546 58 
28 14
 6  0  1  21612   4472  34092 360924    0    0     4  4364 8930   132  5 
95  0
 1  0  0  21612   4388  34232 360692    0    0   740   444 2700  2324 61 
35  4
 4  0  0  21612   4368  34460 359976    0    0   520     0 1380  3071 63 
29  8
 3  0  0  21612   4460  34656 359392    0    0   728     0 1794  3408 63 
33  4
 6  0  2  21612   4440  34820 358948    0    0   732  7452 17013  2577 
22 75  3
 4  0  2  21612   4352  34844 358984    0    0   128 13084 27045   268  
4 96  0
 5  0  0  21612   4404  35004 358748    0    0   312  1240 3412  1984 50 
45  6
 3  0  0  21612   4392  35140 358504    0    0   812     0 1964  2468 64 
32  4
 2  0  0  21612   4404  35256 358320    0    0   780     0 1900  2527 65 
34  1
 4  0  0  21612   4452  35400 358036    0    0   808     0 1968  2704 68 
29  3
 4  0  0  21612   4412  35516 357844    0    0   672     0 1679  2762 61 
32  7
 6  0  2  21612   4424  35568 357724    0    0   132 10772 22319   999  
9 90  0
11  0  1  21612   4420  35568 357732    0    0     0  6060 12382    88  
2 98  0
 4  1  1  21612   4372  35636 357696    0    0   128  3840 8226   302 10 
90  0
 3  0  0  21612   4412  35764 357536    0    0   524  1184 3678  1928 55 
43  2
 4  0  0  21612   4448  34696 358516    0    0   792     0 1924  2564 66 
32  2
 4  0  1  21612   4376  33520 359608    0    0   676     0 1692  2619 64 
33  3
 4  0  0  21612   4364  32484 360480    0    0   676     0 1689  2669 66 
31  3
 3  0  0  21612   4436  31088 361764    0    0   784     0 1929  3057 67 
32  1
 8  0  1  21612   4492  30816 361932    0    0     0 20520 41947   930  
5 95  0
 5  0  0  21612   4420  29424 363468    0    0   516  1964 5267  1408 40 
60  0
 4  0  0  21612   4348  28592 364408    0    0   912     0 2170  2475 65 
33  2
 2  0  0  21612   4444  28708 364084    0    0   656     0 1650  2757 72 
27  1
 3  0  0  21612   4464  28852 363796    0    0   664     0 1663  2740 75 
23  2
 5  0  1  21612   4264  29012 363684    0    0   792     0 1938  2634 66 
29  5
 8  0  2  21612   4344  29060 363508    0    0   284  9744 20533   841  
9 91  0
 9  0  1  21612   4344  29060 363508    0    0     0  5296 10796    52  
1 99  0
 3  0  1  21612   4436  29084 363292    0    0     0  4788 9838   217  5 
95  0
 2  0  0  21612   4372  29268 363184    0    0   820     0 1911  2509 69 
29  2
 6  0  2  21612   4348  29312 363100    0    0   132  6088 12873   752 
11 89  0
 3  0  0  21612   4360  29480 362832    0    0   676     4 1697  3061 76 
19  5
 5  0  0  21612   4428  26392 365748    0    0   684     0 1706  2591 72 
26  2
 2  0  0  21612   4372  24628 367468    0    0   792     0 1921  2578 61 
36  3
 4  0  0  21612   4468  23900 367956    0    0   664     0 1668  2724 73 
26  1
 4  0  1  21612   4352  23936 367988    0    0   128 18688 38440   704  
4 96  0


everytime i experience a slowdown, there's a 'big' number in the io (bo) 
column.

i don't have a dmseg available but here's the exerpt of 
/var/log/messages at boot :

Jun 27 22:52:31 charlus syslogd 1.4.1: restart.
Jun 27 22:52:31 charlus syslog: syslogd startup succeeded
Jun 27 22:52:31 charlus kernel: klogd 1.4.1, log source = /proc/kmsg 
started.
Jun 27 22:52:31 charlus kernel: Linux version 2.4.21 
(root@charlus.dyndns.org) (gcc version 3.2.2 20030222 (Red Hat Linux 
3.2.2-5)) #2 Mon Jun 16 16:10:04 CEST 2003
Jun 27 22:52:31 charlus kernel: BIOS-provided physical RAM map:
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 0000000000100000 - 
000000001fffc000 (usable)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 000000001fffc000 - 
000000001ffff000 (ACPI data)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 000000001ffff000 - 
0000000020000000 (ACPI NVS)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
Jun 27 22:52:31 charlus kernel:  BIOS-e820: 00000000ffff0000 - 
0000000100000000 (reserved)
Jun 27 22:52:31 charlus syslog: klogd startup succeeded
Jun 27 22:52:31 charlus kernel: 511MB LOWMEM available.
Jun 27 22:52:31 charlus kernel: On node 0 totalpages: 131068
Jun 27 22:52:31 charlus kernel: zone(0): 4096 pages.
Jun 27 22:52:31 charlus kernel: zone(1): 126972 pages.
Jun 27 22:52:31 charlus irqbalance: irqbalance startup succeeded
Jun 27 22:52:31 charlus kernel: zone(2): 0 pages.
Jun 27 22:52:31 charlus kernel: Kernel command line: ro root=/dev/hda8 
hdc=ide-scsi vga=0x318 sda=usb-storage pci=biosirq
Jun 27 22:52:31 charlus kernel: ide_setup: hdc=ide-scsi
Jun 27 22:52:31 charlus keytable: Loading keymap:
Jun 27 22:52:31 charlus kernel: Found and enabled local APIC!
Jun 27 22:52:31 charlus kernel: Initializing CPU#0
Jun 27 22:52:31 charlus kernel: Detected 2000.121 MHz processor.
Jun 27 22:52:31 charlus kernel: Console: colour dummy device 80x25
Jun 27 22:52:31 charlus kernel: Calibrating delay loop... 3984.58 BogoMIPS
Jun 27 22:52:31 charlus kernel: Memory: 516028k/524272k available (1363k 
kernel code, 7856k reserved, 468k data, 112k init, 0k highmem)
Jun 27 22:52:31 charlus kernel: Dentry cache hash table entries: 65536 
(order: 7, 524288 bytes)
Jun 27 22:52:31 charlus kernel: Inode cache hash table entries: 32768 
(order: 6, 262144 bytes)
Jun 27 22:52:31 charlus kernel: Mount cache hash table entries: 512 
(order: 0, 4096 bytes)
Jun 27 22:52:31 charlus kernel: Buffer-cache hash table entries: 32768 
(order: 5, 131072 bytes)
Jun 27 22:52:31 charlus kernel: Page-cache hash table entries: 131072 
(order: 7, 524288 bytes)
Jun 27 22:52:31 charlus kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Jun 27 22:52:31 charlus kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 27 22:52:31 charlus kernel: Intel machine check architecture supported.
Jun 27 22:52:31 charlus kernel: Intel machine check reporting enabled on 
CPU#0.
Jun 27 22:52:31 charlus kernel: CPU: AMD Athlon(TM) XP 2400+ stepping 01
Jun 27 22:52:31 charlus kernel: Enabling fast FPU save and restore... done.
Jun 27 22:52:31 charlus kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jun 27 22:52:31 charlus keytable:
Jun 27 22:52:31 charlus kernel: Checking 'hlt' instruction... OK.
Jun 27 22:52:31 charlus keytable: Loading system font:
Jun 27 22:52:31 charlus kernel: POSIX conformance testing by UNIFIX
Jun 27 22:52:31 charlus kernel: enabled ExtINT on CPU#0
Jun 27 22:52:31 charlus kernel: ESR value before enabling vector: 00000000
Jun 27 22:52:31 charlus kernel: ESR value after enabling vector: 00000000
Jun 27 22:52:31 charlus kernel: Using local APIC timer interrupts.
Jun 27 22:52:31 charlus kernel: calibrating APIC timer ...
Jun 27 22:52:31 charlus kernel: ..... CPU clock speed is 2000.1599 MHz.
Jun 27 22:52:31 charlus kernel: ..... host bus clock speed is 266.6880 MHz.
Jun 27 22:52:31 charlus kernel: cpu: 0, clocks: 2666880, slice: 1333440
Jun 27 22:52:31 charlus kernel: 
CPU0<T0:2666880,T1:1333440,D:0,S:1333440,C:2666880>
Jun 27 22:52:31 charlus kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Jun 27 22:52:31 charlus kernel: mtrr: detected mtrr type: Intel
Jun 27 22:52:31 charlus kernel: PCI: PCI BIOS revision 2.10 entry at 
0xf1720, last bus=1
Jun 27 22:52:31 charlus kernel: PCI: Using configuration type 1
Jun 27 22:52:31 charlus kernel: PCI: Probing PCI hardware
Jun 27 22:52:31 charlus kernel: PCI: Using IRQ router VIA [1106/3177] at 
00:11.0
Jun 27 22:52:31 charlus kernel: PCI: Found IRQ 10 for device 00:07.0
Jun 27 22:52:31 charlus kernel: PCI: Sharing IRQ 10 with 00:08.0
Jun 27 22:52:31 charlus kernel: isapnp: Scanning for PnP cards...
Jun 27 22:52:31 charlus kernel: isapnp: No Plug & Play device found
Jun 27 22:52:31 charlus kernel: Linux NET4.0 for Linux 2.4
Jun 27 22:52:31 charlus kernel: Based upon Swansea University Computer 
Society NET3.039
Jun 27 22:52:31 charlus kernel: Initializing RT netlink socket
Jun 27 22:52:31 charlus kernel: Starting kswapd
Jun 27 22:52:31 charlus kernel: Journalled Block Device driver loaded
Jun 27 22:52:31 charlus kernel: ACPI: Core Subsystem version [20011018]
Jun 27 22:52:31 charlus kernel: ACPI: Subsystem enabled
Jun 27 22:52:31 charlus kernel: ACPI: System firmware supports S0 S1 S4 S5
Jun 27 22:52:31 charlus keytable:
Jun 27 22:52:31 charlus kernel: Processor[0]: C0 C1
Jun 27 22:52:31 charlus rc: Starting keytable:  succeeded
Jun 27 22:52:31 charlus kernel: ACPI: Power Button (FF) found
Jun 27 22:52:31 charlus kernel: ACPI: Multiple power buttons detected, 
ignoring fixed-feature
Jun 27 22:52:31 charlus kernel: ACPI: Power Button (CM) found
Jun 27 22:52:31 charlus kernel: vesafb: framebuffer at 0xe8000000, 
mapped to 0xe0809000, size 18432k
Jun 27 22:52:31 charlus kernel: vesafb: mode is 1024x768x24, 
linelength=3072, pages=55
Jun 27 22:52:31 charlus kernel: vesafb: protected mode interface info at 
c000:58a8
Jun 27 22:52:31 charlus kernel: vesafb: scrolling: redraw
Jun 27 22:52:31 charlus kernel: vesafb: directcolor: size=0:8:8:8, 
shift=0:16:8:0
Jun 27 22:52:31 charlus kernel: Console: switching to colour frame 
buffer device 128x48
Jun 27 22:52:31 charlus kernel: fb0: VESA VGA frame buffer device
Jun 27 22:52:31 charlus kernel: pty: 256 Unix98 ptys configured
Jun 27 22:52:31 charlus kernel: Serial driver version 5.05c (2001-07-08) 
with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jun 27 22:52:31 charlus kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jun 27 22:52:31 charlus kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jun 27 22:52:31 charlus kernel: Floppy drive(s): fd0 is 1.44M
Jun 27 22:52:31 charlus kernel: spurious 8259A interrupt: IRQ7.
Jun 27 22:52:31 charlus kernel: FDC 0 is a post-1991 82Jun 27 22:52:31 
charlus kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Jun 27 22:52:31 charlus kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Jun 27 22:52:31 charlus kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Jun 27 22:52:31 charlus kernel: VP_IDE: chipset revision 6
Jun 27 22:52:31 charlus kernel: VP_IDE: not 100%% native mode: will 
probe irqs later
Jun 27 22:52:31 charlus kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 
controller on pci00:11.1
Jun 27 22:52:31 charlus kernel:     ide0: BM-DMA at 0x9000-0x9007, BIOS 
settings: hda:DMA, hdb:pio
Jun 27 22:52:31 charlus kernel:     ide1: BM-DMA at 0x9008-0x900f, BIOS 
settings: hdc:DMA, hdd:DMA
Jun 27 22:52:31 charlus kernel: hda: Maxtor 6Y080L0, ATA DISK drive
Jun 27 22:52:31 charlus kernel: blk: queue c0314e40, I/O limit 4095Mb 
(mask 0xffffffff)
Jun 27 22:52:31 charlus kernel: hdc: PLEXTOR CD-R PX-W1610A, ATAPI 
CD/DVD-ROM drive
Jun 27 22:52:31 charlus kernel: hdd: CREATIVEDVD5240E-1, ATAPI 
CD/DVD-ROM drive
Jun 27 22:52:31 charlus kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 27 22:52:31 charlus kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 27 22:52:31 charlus kernel: hda: attached ide-disk driver.
Jun 27 22:52:31 charlus kernel: hda: host protected area => 1
Jun 27 22:52:31 charlus kernel: hda: 160086528 sectors (81964 MB) 
w/2048KiB Cache, CHS=9964/255/63, UDMA(133)
Jun 27 22:52:31 charlus random: Initializing random number generator:  
succeeded
Jun 27 22:52:31 charlus kernel: hdd: attached ide-cdrom driver.
Jun 27 22:52:31 charlus kernel: hdd: ATAPI 32X DVD-ROM drive, 512kB 
Cache, DMA
Jun 27 22:52:31 charlus kernel: Uniform CD-ROM driver Revision: 3.12
Jun 27 22:52:31 charlus kernel: Partition check:
Jun 27 22:52:31 charlus kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 
hda7 hda8 hda9 hda10 >
Jun 27 22:52:31 charlus kernel: Linux Kernel Card Services 3.1.22
Jun 27 22:52:32 charlus kernel:   options:  [pci] [cardbus] [pm]
Jun 27 22:52:32 charlus kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun 27 22:52:32 charlus kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jun 27 22:52:32 charlus kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Jun 27 22:52:32 charlus kernel: TCP: Hash tables configured (established 
32768 bind 65536)
Jun 27 22:52:32 charlus kernel: NET4: Unix domain sockets 1.0/SMP for 
Linux NET4.0.
Jun 27 22:52:32 charlus kernel: ds: no socket drivers loaded!
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: VFS: Mounted root (ext3 filesystem) 
readonly.
Jun 27 22:52:32 charlus kernel: Freeing unused kernel memory: 112k freed
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver usbdevfs
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver hub
Jun 27 22:52:32 charlus kernel: PCI: Found IRQ 3 for device 00:10.3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.0, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.1, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.2, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.3, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: ehci-hcd 00:10.3: VIA Technologies, Inc. 
USB 2.0
Jun 27 22:52:32 charlus kernel: ehci-hcd 00:10.3: irq 9, pci mem e1a24000
Jun 27 22:52:32 charlus kernel: usb.c: new USB bus registered, assigned 
bus number 1
Jun 27 22:52:32 charlus kernel: PCI: 00:10.3 PCI cache line size set 
incorrectly (32 bytes) by BIOS/FW.
Jun 27 22:52:32 charlus kernel: PCI: 00:10.3 PCI cache line size 
corrected to 64.
Jun 27 22:52:32 charlus kernel: ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 
1.00, driver 2003-Jan-22
Jun 27 22:52:32 charlus kernel: hub.c: USB hub found
Jun 27 22:52:32 charlus kernel: hub.c: 6 ports detected
Jun 27 22:52:32 charlus kernel: uhci.c: USB Universal Host Controller 
Interface driver v1.1
Jun 27 22:52:32 charlus kernel: PCI: Found IRQ 3 for device 00:10.0
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.0, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.1, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.2, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.3, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: uhci.c: USB UHCI at I/O 0xa000, IRQ 9
Jun 27 22:52:32 charlus kernel: usb.c: new USB bus registered, assigned 
bus number 2
Jun 27 22:52:32 charlus kernel: hub.c: USB hub found
Jun 27 22:52:32 charlus kernel: hub.c: 2 ports detected
Jun 27 22:52:32 charlus kernel: PCI: Found IRQ 3 for device 00:10.1
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.0, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.1, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.2, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.3, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: uhci.c: USB UHCI at I/O 0x9800, IRQ 9
Jun 27 22:52:32 charlus kernel: usb.c: new USB bus registered, assigned 
bus number 3
Jun 27 22:52:32 charlus kernel: hub.c: USB hub found
Jun 27 22:52:32 charlus kernel: hub.c: 2 ports detected
Jun 27 22:52:32 charlus kernel: PCI: Found IRQ 3 for device 00:10.2
Jun 27 22:52:32 charlus netfs: Mounting other filesystems:  succeeded
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.0, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.1, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.2, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: IRQ routing conflict for 00:10.3, have 
irq 9, want irq 3
Jun 27 22:52:32 charlus kernel: uhci.c: USB UHCI at I/O 0x9400, IRQ 9
Jun 27 22:52:32 charlus kernel: usb.c: new USB bus registered, assigned 
bus number 4
Jun 27 22:52:32 charlus kernel: hub.c: USB hub found
Jun 27 22:52:32 charlus kernel: hub.c: 2 ports detected
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver hiddev
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver hid
Jun 27 22:52:32 charlus kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech 
Pavlik <vojtech@suse.cz>
Jun 27 22:52:32 charlus kernel: hid-core.c: USB HID support drivers
Jun 27 22:52:32 charlus kernel: mice: PS/2 mouse device common for all mice
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,8), internal journal
Jun 27 22:52:32 charlus kernel: Adding Swap: 1574328k swap-space 
(priority -1)
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,1), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,10), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,3), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,2), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,9), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,5), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: kjournald starting.  Commit interval 5 
seconds
Jun 27 22:52:32 charlus kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,7), internal journal
Jun 27 22:52:32 charlus kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Jun 27 22:52:32 charlus kernel: ohci1394: $Rev: 896 $ Ben Collins 
<bcollins@debian.org>
Jun 27 22:52:32 charlus kernel: PCI: Enabling device 00:07.0 (0094 -> 0097)
Jun 27 22:52:32 charlus kernel: PCI: Found IRQ 10 for device 00:07.0
Jun 27 22:52:32 charlus kernel: PCI: Sharing IRQ 10 with 00:08.0
Jun 27 22:52:32 charlus kernel: ohci1394_0: OHCI-1394 1.0 (PCI): 
IRQ=[10]  MMIO=[d6000000-d60007ff]  Max Packet=[2048]
Jun 27 22:52:32 charlus kernel: hub.c: new USB device 00:10.2-1, 
assigned address 2
Jun 27 22:52:32 charlus kernel: usb.c: USB device 2 (vend/prod 
0x46d/0x870) is not claimed by any active driver.
Jun 27 22:52:32 charlus kernel: hub.c: new USB device 00:10.1-1, 
assigned address 2
Jun 27 22:52:32 charlus kernel: usb.c: USB device 2 (vend/prod 
0x46d/0x870) is not claimed by any active driver.
Jun 27 22:52:32 charlus kernel: hub.c: new USB device 00:10.1-1, 
assigned address 2
Jun 27 22:52:32 charlus kernel: input0: USB HID v1.10 Mouse [Logitech 
USB Receiver] on usb3:2.0
Jun 27 22:52:32 charlus kernel: hub.c: new USB device 00:10.1-2, 
assigned address 3
Jun 27 22:52:32 charlus kernel: usb.c: USB device 3 (vend/prod 
0xeaf/0x1) is not claimed by any active driver.
Jun 27 22:52:32 charlus kernel: SCSI subsystem driver Revision: 1.00
Jun 27 22:52:32 charlus kernel: hdc: attached ide-scsi driver.
Jun 27 22:52:32 charlus kernel: scsi0 : SCSI host adapter emulation for 
IDE ATAPI devices
Jun 27 22:52:32 charlus kernel:   Vendor: PLEXTOR   Model: CD-R   
PX-W1610A  Rev: 1.05
Jun 27 22:52:32 charlus kernel:   Type:   
CD-ROM                             ANSI SCSI revision: 02
Jun 27 22:52:32 charlus kernel: hub.c: new USB device 00:10.0-1, 
assigned address 2
Jun 27 22:52:32 charlus kernel: usb.c: USB device 2 (vend/prod 
0x4b8/0x5) is not claimed by any active driver.
Jun 27 22:52:32 charlus kernel: Linux video capture interface: v1.00
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver quickcam
Jun 27 22:52:32 charlus kernel: USB Quickcam Class ff SubClass ff 
idVendor 46d idProduct 870
Jun 27 22:52:32 charlus kernel: USB Quickcam camera found using: $Id: 
quickcam.c,v 1.111 2003/01/27 09:41:03 tuukkat Exp $
Jun 27 22:52:32 charlus kernel: quickcam: probe of HDCS1000 sensor = 08 
02 id: 08
Jun 27 22:52:32 charlus kernel: quickcam: HDCS1000 sensor detected
Jun 27 22:52:32 charlus kernel: Initializing USB Mass Storage driver...
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver usb-storage
Jun 27 22:52:32 charlus kernel: scsi1 : SCSI emulation for USB Mass 
Storage devices
Jun 27 22:52:32 charlus kernel:   Vendor: MCRW      Model: CRW600        
CF  Rev: 2.1D
Jun 27 22:52:32 charlus kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 02
Jun 27 22:52:32 charlus kernel:   Vendor: MCRW      Model: CRW600        
MS  Rev: 2.1D
Jun 27 22:52:32 charlus kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 02
Jun 27 22:52:32 charlus kernel:   Vendor: MCRW      Model: CRW600    
MMC/SD  Rev: 2.1D
Jun 27 22:52:32 charlus kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 02
Jun 27 22:52:32 charlus kernel:   Vendor: MCRW      Model: CRW600        
SM  Rev: 2.1D
Jun 27 22:52:32 charlus kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 02
Jun 27 22:52:32 charlus kernel: USB Mass Storage support registered.
Jun 27 22:52:32 charlus kernel: Attached scsi CD-ROM sr0 at scsi0, 
channel 0, id 0, lun 0
Jun 27 22:52:32 charlus kernel: sr0: scsi3-mmc drive: 40x/40x writer 
cd/rw xa/form2 cdda tray
Jun 27 22:52:32 charlus kernel: usb.c: registered new driver usblp
Jun 27 22:52:32 charlus kernel: printer.c: usblp0: USB Bidirectional 
printer dev 2 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
Jun 27 22:52:32 charlus kernel: printer.c: v0.11: USB Printer Device 
Class driver
Jun 27 22:52:32 charlus kernel: parport0: PC-style at 0x378 (0x778) 
[PCSPP,TRISTATE]
Jun 27 22:52:32 charlus kernel: parport0: irq 7 detected
Jun 27 22:52:32 charlus kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 27 22:52:32 charlus kernel: ip_conntrack version 2.1 (4095 buckets, 
32760 max) - 292 bytes per conntrack
Jun 27 22:52:32 charlus kernel: Broadcom 4401 Ethernet Driver bcm4400 
ver. 1.0.1 (08/26/02)
Jun 27 22:52:32 charlus kernel: PCI: Enabling device 00:09.0 (0004 -> 0006)
Jun 27 22:52:32 charlus kernel: PCI: Assigned IRQ 5 for device 00:09.0
Jun 27 22:52:32 charlus kernel: eth0: Broadcom BCM4401 100Base-T found 
at mem d4800000, IRQ 5, node addr 00e018a7bc28
Jun 27 22:52:32 charlus autofs: automount startup succeeded

let me know if you need anything else from me !
( please cc me since i'm not on the list ).
thanks again for your help.

-- 
Charles-Edouard Ruault
PGP Key ID E10C24DC


