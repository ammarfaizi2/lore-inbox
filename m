Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSKFInx>; Wed, 6 Nov 2002 03:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266004AbSKFInx>; Wed, 6 Nov 2002 03:43:53 -0500
Received: from redrock.inria.fr ([138.96.248.51]:60381 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S265242AbSKFInt>;
	Wed, 6 Nov 2002 03:43:49 -0500
SCF: #mh/Mailbox/outboxDate: Wed, 6 Nov 2002 09:38:35 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org, weissg@vienna.at,
       zaitcev@redhat.com
Subject: Re: Problem with USB-OHCI (2.4.20-pre10-ac2) and Sony Picturebook PCG-C1MHP
Message-Id: <20021106093835.1052afb0.Manuel.Serrano@sophia.inria.fr>
References: <3DC8068A.7020000@pacbell.net>
	<Pine.LNX.4.33L2.0211051018060.21048-100000@dragon.pdx.osdl.net>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 06 Nov 2002 09:44:29 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

> On Tue, 5 Nov 2002, David Brownell wrote:
> 
> | Manuel Serrano wrote:
> |
> |  > usb-ohci.c: USB OHCI at membase 0xcf85a000, IRQ 9
> |  > usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [ALi] USB 1.1 Controller
> |
> | I think Pete Zaitcev had a patch for this.  Seems like recent
> | incarnations of that silicon need modified init sequences.
> 
> See the archived message at
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103532223326544&w=2
> 
> This was designed for ALi in IBM i1200/i1300 notebooks.
I have applied the patch against the linux-2.4.20-pre10-ac2 kernel and I'm 
currently testing it. So far, everything seems fine. I'm currently using 
the USB mouse and the FireWire IEEE-1394 SPB-2 without incompatibilities. 
During the boot, I have had the following trace:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
Nov  6 09:33:02 owens syslogd 1.4.1#11: restart.
Nov  6 09:33:02 owens kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Nov  6 09:33:02 owens kernel: Cannot find map file.
Nov  6 09:33:02 owens kernel: Loaded 297 symbols from 13 modules.
Nov  6 09:33:02 owens kernel: Linux version 2.4.20-pre10-ac2 (root@owens) (gcc v
ersion 2.95.4 20011002 (Debian prerelease)) #19 Wed Nov 6 09:10:30 CET 2002
Nov  6 09:33:02 owens kernel: BIOS-provided physical RAM map:
Nov  6 09:33:02 owens kernel:  BIOS-e820: 0000000000000000 - 000000000009a800 (u
sable)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 000000000009a800 - 00000000000a0000 (r
eserved)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 00000000000c0000 - 00000000000d0000 (r
eserved)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 00000000000dc000 - 00000000000e0000 (r
eserved)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (r
eserved)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 0000000000100000 - 000000000eef0000 (u
sable)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 000000000eef0000 - 000000000eefc000 (A
CPI data)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 000000000eefc000 - 000000000ef00000 (A
CPI NVS)
Nov  6 09:33:02 owens kernel:  BIOS-e820: 000000000ef00000 - 000000000f000000 (u
sable)
Nov  6 09:33:03 owens kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (r
eserved)
Nov  6 09:33:03 owens kernel: 240MB LOWMEM available.
Nov  6 09:33:03 owens kernel: On node 0 totalpages: 61440
Nov  6 09:33:03 owens kernel: zone(0): 4096 pages.
Nov  6 09:33:03 owens kernel: zone(1): 57344 pages.
Nov  6 09:33:03 owens kernel: zone(2): 0 pages.
Nov  6 09:33:03 owens kernel: Sony Vaio laptop detected.
Nov  6 09:33:03 owens kernel: Kernel command line: ro root=/dev/hda2
Nov  6 09:33:03 owens kernel: Initializing CPU#0
Nov  6 09:33:03 owens kernel: Detected 860.157 MHz processor.
Nov  6 09:33:03 owens kernel: Console: colour VGA+ 80x25
Nov  6 09:33:03 owens kernel: Calibrating delay loop... 1717.04 BogoMIPS
Nov  6 09:33:03 owens kernel: Memory: 238536k/245760k available (985k kernel cod
e, 4832k reserved, 440k data, 56k init, 0k highmem)
Nov  6 09:33:03 owens kernel: Dentry cache hash table entries: 32768 (order: 6, 
262144 bytes)
Nov  6 09:33:03 owens kernel: Inode cache hash table entries: 16384 (order: 5, 1
31072 bytes)
Nov  6 09:33:03 owens kernel: Mount cache hash table entries: 512 (order: 0, 409
6 bytes)
Nov  6 09:33:03 owens kernel: ramfs: mounted with options: <defaults>
Nov  6 09:33:03 owens kernel: ramfs: max_pages=30057 max_file_pages=0 max_inodes
=0 max_dentries=30057
Nov  6 09:33:03 owens kernel: Buffer cache hash table entries: 16384 (order: 4, 
65536 bytes)
Nov  6 09:33:03 owens kernel: Page-cache hash table entries: 65536 (order: 6, 26
2144 bytes)
Nov  6 09:33:03 owens kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K 
(32 bytes/line)
Nov  6 09:33:03 owens kernel: CPU: L2 Cache: 512K (128 bytes/line)
Nov  6 09:33:03 owens kernel: CPU: Processor revision 1.4.1.0, 867 MHz
Nov  6 09:33:03 owens kernel: CPU: Code Morphing Software revision 4.3.0-9-197
Nov  6 09:33:03 owens kernel: CPU: 20020207 23:55 official release 4.3.0#7
Nov  6 09:33:03 owens kernel: CPU serial number disabled.
Nov  6 09:33:03 owens kernel: CPU:     After generic, caps: 0080893f 0081813f 00
00004e 00000000
Nov  6 09:33:03 owens kernel: CPU:             Common caps: 0080893f 0081813f 00
00004e 00000000
Nov  6 09:33:03 owens kernel: CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 ste
pping 03
Nov  6 09:33:03 owens kernel: Checking 'hlt' instruction... OK.
Nov  6 09:33:03 owens kernel: POSIX conformance testing by UNIFIX
Nov  6 09:33:03 owens kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.
csiro.au)
Nov  6 09:33:03 owens kernel: mtrr: detected mtrr type: none
Nov  6 09:33:03 owens kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd85e, last
 bus=0
Nov  6 09:33:03 owens kernel: PCI: Using configuration type 1
Nov  6 09:33:03 owens kernel: PCI: Probing PCI hardware
Nov  6 09:33:03 owens kernel: Scanning bus 00
Nov  6 09:33:03 owens kernel: Found 00:00 [1279/0395] 000600 00
Nov  6 09:33:03 owens kernel: Found 00:01 [1279/0396] 000500 00
Nov  6 09:33:03 owens kernel: Found 00:02 [1279/0397] 000500 00
Nov  6 09:33:03 owens kernel: Found 00:30 [10b9/5451] 000401 00
Nov  6 09:33:03 owens kernel: Found 00:38 [10b9/1533] 000601 00
Nov  6 09:33:03 owens kernel: Found 00:40 [10b9/5457] 000703 00
Nov  6 09:33:03 owens kernel: Found 00:48 [104c/8023] 000c00 00
Nov  6 09:33:03 owens kernel: Found 00:50 [10cf/2011] 000480 00
Nov  6 09:33:03 owens kernel: Found 00:58 [10ec/8139] 000200 00
Nov  6 09:33:03 owens kernel: Found 00:60 [1002/4c59] 000300 00
Nov  6 09:33:03 owens kernel: Found 00:78 [10b9/5237] 000c03 00
Nov  6 09:33:03 owens kernel: Found 00:80 [10b9/5229] 000101 00
Nov  6 09:33:03 owens kernel: Found 00:88 [10b9/7101] 000000 00
Nov  6 09:33:03 owens kernel: Found 00:90 [1180/0475] 000607 02
Nov  6 09:33:03 owens kernel: Found 00:a0 [10b9/5237] 000c03 00
Nov  6 09:33:03 owens kernel: Fixups for bus 00
Nov  6 09:33:03 owens kernel: Scanning behind PCI bridge 00:12.0, config 010100,
 pass 0
Nov  6 09:33:03 owens kernel: Scanning behind PCI bridge 00:12.0, config 010100,
 pass 1
Nov  6 09:33:03 owens kernel: Bus scan for 00 returning with max=01
Nov  6 09:33:03 owens kernel: PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:06.0
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:08.0
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:0a.0
Nov  6 09:33:03 owens kernel: PCI: Sharing IRQ 9 with 00:0b.0
Nov  6 09:33:03 owens kernel: PCI: Sharing IRQ 9 with 00:12.0
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:0f.0
Nov  6 09:33:03 owens kernel: Linux NET4.0 for Linux 2.4
Nov  6 09:33:03 owens kernel: Based upon Swansea University Computer Society NET
3.039
Nov  6 09:33:03 owens kernel: Initializing RT netlink socket
Nov  6 09:33:03 owens kernel: Starting kswapd
Nov  6 09:33:03 owens kernel: Journalled Block Device driver loaded
Nov  6 09:33:03 owens kernel: ACPI: Core Subsystem version [20011018]
Nov  6 09:33:03 owens kernel: ACPI: Subsystem enabled
Nov  6 09:33:03 owens kernel: pty: 256 Unix98 ptys configured
Nov  6 09:33:03 owens kernel: Serial driver version 5.05c (2001-07-08) with MANY
_PORTS SHARE_IRQ SERIAL_PCI enabled
Nov  6 09:33:03 owens kernel: PCI: Enabling device 00:08.0 (0000 -> 0003)
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:08.0
Nov  6 09:33:03 owens kernel: Redundant entry in serial pci_table.  Please send 
the output of
Nov  6 09:33:03 owens kernel: lspci -vv, this message (10b9,5457,104d,80ec)
Nov  6 09:33:03 owens kernel: and the manufacturer and name of serial board or m
odem board
Nov  6 09:33:03 owens kernel: to serial-pci-info@lists.sourceforge.net.
Nov  6 09:33:03 owens kernel: register_serial(): autoconfig failed
Nov  6 09:33:03 owens kernel: Real Time Clock Driver v1.10e
Nov  6 09:33:03 owens kernel: floppy0: no floppy controllers found
Nov  6 09:33:03 owens kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00
alpha2
Nov  6 09:33:03 owens kernel: ide: Assuming 33MHz system bus speed for PIO modes
; override with idebus=xx
Nov  6 09:33:03 owens kernel: ALI15X3: IDE controller at PCI slot 00:10.0
Nov  6 09:33:03 owens kernel: PCI: No IRQ known for interrupt pin A of device 00
:10.0. Please try using pci=biosirq.
Nov  6 09:33:03 owens kernel: ALI15X3: chipset revision 196
Nov  6 09:33:03 owens kernel: ALI15X3: not 100%% native mode: will probe irqs la
ter
Nov  6 09:33:03 owens kernel: ALI15X3: simplex device with no drives: DMA disabl
ed
Nov  6 09:33:03 owens kernel: ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
Nov  6 09:33:03 owens kernel: ALI15X3: simplex device with no drives: DMA disabl
ed
Nov  6 09:33:03 owens kernel: ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
Nov  6 09:33:03 owens kernel: hda: IC25N030ATCS04-0, ATA DISK drive
Nov  6 09:33:03 owens kernel: ide: Assuming 33MHz system bus speed for PIO modes
; override with idebus=xx
Nov  6 09:33:03 owens kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  6 09:33:03 owens kernel: hda: host protected area => 1
Nov  6 09:33:03 owens kernel: hda: 58605120 sectors (30006 MB) w/1768KiB Cache, 
CHS=3648/255/63
Nov  6 09:33:03 owens kernel: Partition check:
Nov  6 09:33:03 owens kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Nov  6 09:33:03 owens kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov  6 09:33:03 owens kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Nov  6 09:33:03 owens kernel: IP: routing cache hash table of 2048 buckets, 16Kb
ytes
Nov  6 09:33:03 owens kernel: TCP: Hash tables configured (established 16384 bin
d 16384)
Nov  6 09:33:03 owens kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
.
Nov  6 09:33:03 owens kernel: kjournald starting.  Commit interval 5 seconds
Nov  6 09:33:03 owens kernel: EXT3-fs: mounted filesystem with ordered data mode
.
Nov  6 09:33:03 owens kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov  6 09:33:03 owens kernel: Freeing unused kernel memory: 56k freed
Nov  6 09:33:03 owens kernel: Adding Swap: 265064k swap-space (priority -1)
Nov  6 09:33:03 owens kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), i
nternal journal
Nov  6 09:33:03 owens kernel: SCSI subsystem driver Revision: 1.00
Nov  6 09:33:03 owens kernel: usb.c: registered new driver usbdevfs
Nov  6 09:33:03 owens kernel: usb.c: registered new driver hub
Nov  6 09:33:03 owens kernel: PCI: Enabling device 00:0f.0 (0010 -> 0012)
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:0f.0
Nov  6 09:33:03 owens kernel: PCI: Enabling bus mastering for device 00:0f.0
Nov  6 09:33:03 owens kernel: usb-ohci.c: USB OHCI at membase 0xcf85a000, IRQ 9
Nov  6 09:33:03 owens kernel: usb-ohci.c: usb-00:0f.0, Acer Laboratories Inc. [A
Li] USB 1.1 Controller
Nov  6 09:33:03 owens kernel: usb.c: new USB bus registered, assigned bus number
 1
Nov  6 09:33:03 owens kernel: hub.c: USB hub found
Nov  6 09:33:03 owens kernel: hub.c: 2 ports detected
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:14.0
Nov  6 09:33:03 owens kernel: usb-ohci.c: USB OHCI at membase 0xc00e0000, IRQ 9
Nov  6 09:33:03 owens kernel: usb-ohci.c: usb-00:14.0, Acer Laboratories Inc. [A
Li] USB 1.1 Controller (#2)
Nov  6 09:33:03 owens kernel: usb.c: new USB bus registered, assigned bus number
 2
Nov  6 09:33:03 owens kernel: hub.c: USB hub found
Nov  6 09:33:03 owens kernel: hub.c: 2 ports detected
Nov  6 09:33:03 owens kernel: usb.c: registered new driver hiddev
Nov  6 09:33:03 owens kernel: usb.c: registered new driver hid
Nov  6 09:33:03 owens kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vo
jtech@suse.cz>
Nov  6 09:33:03 owens kernel: hid-core.c: USB HID support drivers
Nov  6 09:33:03 owens kernel: mice: PS/2 mouse device common for all mice
Nov  6 09:33:03 owens kernel: Power Resource: found
Nov  6 09:33:03 owens kernel: ACPI: AC Adapter found
Nov  6 09:33:03 owens kernel: ACPI: Battery socket found, battery present
Nov  6 09:33:03 owens kernel: ACPI: Thermal Zone found
Nov  6 09:33:03 owens kernel: Processor[0]: C0 C1 C2 C3
Nov  6 09:33:03 owens kernel: ACPI: System firmware supports S0 S3 S4 S5
Nov  6 09:33:03 owens kernel: hub.c: new USB device 00:0f.0-1, assigned address 
2
Nov  6 09:33:03 owens kernel: usb.c: USB device 2 (vend/prod 0x54c/0x69) is not 
claimed by any active driver.
Nov  6 09:33:03 owens kernel: hub.c: new USB device 00:14.0-1, assigned address 
2
Nov  6 09:33:03 owens kernel: input0: USB HID v1.00 Mouse [0461:4d03] on usb2:2.
0
Nov  6 09:33:03 owens kernel: kjournald starting.  Commit interval 5 seconds
Nov  6 09:33:03 owens kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), i
nternal journal
Nov  6 09:33:03 owens kernel: EXT3-fs: mounted filesystem with ordered data mode
.
Nov  6 09:33:03 owens kernel: kjournald starting.  Commit interval 5 seconds
Nov  6 09:33:03 owens kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), i
nternal journal
Nov  6 09:33:03 owens kernel: EXT3-fs: mounted filesystem with ordered data mode
.
Nov  6 09:33:03 owens kernel: kjournald starting.  Commit interval 5 seconds
Nov  6 09:33:03 owens kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), i
nternal journal
Nov  6 09:33:03 owens kernel: EXT3-fs: mounted filesystem with ordered data mode
.
Nov  6 09:33:03 owens kernel: 8139too Fast Ethernet driver 0.9.26
Nov  6 09:33:03 owens kernel: PCI: Found IRQ 9 for device 00:0b.0
Nov  6 09:33:03 owens kernel: PCI: Sharing IRQ 9 with 00:0a.0
Nov  6 09:33:03 owens kernel: PCI: Sharing IRQ 9 with 00:12.0
Nov  6 09:33:03 owens kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xcf87d800,
 08:00:46:47:62:d4, IRQ 9
Nov  6 09:33:03 owens kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
Nov  6 09:33:03 owens kernel: eth0: Setting 100mbps half-duplex based on auto-ne
gotiated partner ability 40a1.
Nov  6 09:33:03 owens modprobe: modprobe: Can't locate module char-major-10-134
Nov  6 09:33:03 owens lpd[221]: restarted
Nov  6 09:33:04 owens kernel: Linux Kernel Card Services 3.1.22
Nov  6 09:33:04 owens kernel:   options:  [pci] [cardbus] [pm]
Nov  6 09:33:04 owens kernel: PCI: Found IRQ 9 for device 00:12.0
Nov  6 09:33:04 owens kernel: PCI: Sharing IRQ 9 with 00:0a.0
Nov  6 09:33:04 owens kernel: PCI: Sharing IRQ 9 with 00:0b.0
Nov  6 09:33:04 owens kernel: Yenta IRQ list 0cb8, PCI irq9
Nov  6 09:33:04 owens kernel: Socket status: 30000006
Nov  6 09:33:04 owens cardmgr[244]: watching 1 sockets
Nov  6 09:33:04 owens cardmgr[245]: starting, version is 3.2.2
Nov  6 09:33:07 owens postfix/postfix-script: starting the Postfix mail system
Nov  6 09:33:07 owens postfix/master[332]: daemon started
Nov  6 09:33:09 owens xfs: ignoring font path element /usr/lib/X11/fonts/cyrilli
c/ (unreadable) 
Nov  6 09:33:09 owens anacron[356]: Anacron 2.3 started on 2002-11-06
Nov  6 09:33:09 owens xfs: ignoring font path element /usr/lib/X11/fonts/CID (un
readable) 
Nov  6 09:33:10 owens xfs-xtt: ignoring font path element /var/lib/defoma/x-ttci
dfont-conf.d/dirs/CID (unreadable) 
Nov  6 09:33:10 owens anacron[356]: Will run job `cron.daily' in 5 min.
Nov  6 09:33:10 owens anacron[356]: Will run job `cron.weekly' in 10 min.
Nov  6 09:33:10 owens anacron[356]: Jobs will be executed sequentially
Nov  6 09:33:10 owens /usr/sbin/cron[361]: (CRON) INFO (pidfile fd = 3)
...
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

If I happens to have any problem, I will let you know.

Many thanks for your help.

-- 
Manuel
