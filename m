Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTISNmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbTISNmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:42:40 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59805 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261570AbTISNlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:41:36 -0400
Message-ID: <3F6B0671.1070603@jtholmes.com>
Date: Fri, 19 Sep 2003 09:36:49 -0400
From: jtholmes <jtholmes@jtholmes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jtholmesjr@comcast.net
Subject: irq 11: nobody cared! is back
Content-Type: multipart/mixed;
 boundary="------------030703020605000103070603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030703020605000103070603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I don't take the  Distribution, and don't need email copy of
answer,  just  answer in LKML  and I will see it.

If I knew how to turn on more debugging I would gladly do so
as I need to figure out the Kernel debugging scheme.

Problem  Description

	After loading  Module uhci-hcd

	USB Optical Mouse light shuts off and  irq 11:  is disabled.

Steps to reproduce problem

	Boot Linux
	modprobe -v usbcore
	modprobe -v uhci-hcd

	Mouse goes away, irq 11:  disabled

	At this point Everything else appears to work ok

ver_linux output

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jtlin60 2.6.0-test5 #9 Fri Sep 19 00:16:44 EDT 2003 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.2.5
quota-tools            3.01.
PPP                    2.4.1
isdn4k-utils           3.1pre1
nfs-utils              0.3.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         uhci_hcd usbcore binfmt_misc ds yenta_socket pcmcia_core parport_pc parport


lsmod  immed after boot up


	Module                  Size  Used by
	binfmt_misc             7976  0 
	ds                     10400  4 
	yenta_socket           13184  1 
	pcmcia_core            55168  2 ds,yenta_socket
	parport_pc             22600  0 
	parport                35232  1 parport_pc

lsmod  after  load of  usbcore  and uhci-hcd

	Module                  Size  Used by
	uhci_hcd               27464  0 
	usbcore                96660  3 uhci_hcd
	binfmt_misc             7976  0 
	ds                     10400  4 
	yenta_socket           13184  1 
	pcmcia_core            55168  2 ds,yenta_socket
	parport_pc             22600  0 
	parport                35232  1 parport_pc

/usr/src/linux/.config

	Very large, see attachments

/var/log/messages

Sep 19 08:46:44 jtlin60 syslogd 1.4.1: restart.
Sep 19 08:46:44 jtlin60 syslog: syslogd startup succeeded
Sep 19 08:46:45 jtlin60 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep 19 08:46:45 jtlin60 kernel: Linux version 2.6.0-test5 (root@jtlin60) (gcc version 2.95.3 20010315 (release)) #9 Fri Sep 19 00:16:44 EDT 2003
Sep 19 08:46:45 jtlin60 kernel: Video mode to be used for restore is f00
Sep 19 08:46:45 jtlin60 kernel: BIOS-provided physical RAM map:
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 00000000000e8000 - 00000000000ec000 (reserved)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 0000000000100000 - 000000000bfe0000 (usable)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 000000000bfe0000 - 000000000bff0000 (ACPI data)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 000000000bff0000 - 000000000c000000 (reserved)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
Sep 19 08:46:45 jtlin60 syslog: klogd startup succeeded
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
Sep 19 08:46:45 jtlin60 kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Sep 19 08:46:45 jtlin60 kernel: 0MB HIGHMEM available.
Sep 19 08:46:45 jtlin60 kernel: 191MB LOWMEM available.
Sep 19 08:46:45 jtlin60 kernel: On node 0 totalpages: 49120
Sep 19 08:46:45 jtlin60 kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep 19 08:46:45 jtlin60 kernel:   Normal zone: 45024 pages, LIFO batch:10
Sep 19 08:46:45 jtlin60 portmap: portmap startup succeeded
Sep 19 08:46:45 jtlin60 kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep 19 08:46:45 jtlin60 kernel: DMI 2.3 present.
Sep 19 08:46:45 jtlin60 kernel: Building zonelist for node : 0
Sep 19 08:46:45 jtlin60 kernel: Kernel command line: auto BOOT_IMAGE=l6_test5 ro root=301 BOOT_FILE=/boot/vmlinuz-2.6.0-test5
Sep 19 08:46:45 jtlin60 kernel: Initializing CPU#0
Sep 19 08:46:45 jtlin60 kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Sep 19 08:46:45 jtlin60 kernel: Detected 361.392 MHz processor.
Sep 19 08:46:45 jtlin60 nfslock: rpc.statd startup succeeded
Sep 19 08:46:45 jtlin60 rpc.statd[477]: Version 0.3.3 Starting
Sep 19 08:46:45 jtlin60 kernel: Console: colour VGA+ 80x25
Sep 19 08:46:45 jtlin60 kernel: Memory: 191524k/196480k available (1296k kernel code, 4304k reserved, 691k data, 112k init, 0k highmem)
Sep 19 08:46:45 jtlin60 kernel: Calibrating delay loop... 692.22 BogoMIPS
Sep 19 08:46:45 jtlin60 kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Sep 19 08:46:45 jtlin60 kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Sep 19 08:46:45 jtlin60 keytable: Loading keymap:  succeeded
Sep 19 08:46:46 jtlin60 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep 19 08:46:46 jtlin60 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep 19 08:46:46 jtlin60 kernel: CPU: L2 cache: 256K
Sep 19 08:46:46 jtlin60 kernel: Intel machine check architecture supported.
Sep 19 08:46:46 jtlin60 kernel: Intel machine check reporting enabled on CPU#0.
Sep 19 08:46:46 jtlin60 kernel: CPU: Intel Pentium III (Coppermine) stepping 06
Sep 19 08:46:46 jtlin60 kernel: Enabling fast FPU save and restore... done.
Sep 19 08:46:46 jtlin60 keytable: Loading system font:  succeeded
Sep 19 08:46:46 jtlin60 kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 19 08:46:46 jtlin60 kernel: Checking 'hlt' instruction... OK.
Sep 19 08:46:46 jtlin60 kernel: Checking for popad bug... OK.
Sep 19 08:46:46 jtlin60 kernel: POSIX conformance testing by UNIFIX
Sep 19 08:46:46 jtlin60 kernel: NET: Registered protocol family 16
Sep 19 08:46:46 jtlin60 kernel: EISA bus registered
Sep 19 08:46:46 jtlin60 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfee03, last bus=21
Sep 19 08:46:46 jtlin60 kernel: PCI: Using configuration type 1
Sep 19 08:46:46 jtlin60 kernel: mtrr: v2.0 (20020519)
Sep 19 08:46:46 jtlin60 random: Initializing random number generator:  succeeded
Sep 19 08:46:46 jtlin60 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep 19 08:46:46 jtlin60 kernel: PCI: Probing PCI hardware
Sep 19 08:46:46 jtlin60 kernel: PCI: Probing PCI hardware (bus 00)
Sep 19 08:46:46 jtlin60 kernel: PCI: Using IRQ router PIIX [8086/7110] at 0000:00:05.0
Sep 19 08:46:46 jtlin60 kernel: PCI: IRQ 0 for device 0000:00:0b.0 doesn't match PIRQ mask - try pci=usepirqmask
Sep 19 08:46:46 jtlin60 kernel: PCI: Found IRQ 11 for device 0000:00:0b.0
Sep 19 08:46:46 jtlin60 kernel: PCI: IRQ 0 for device 0000:00:0b.1 doesn't match PIRQ mask - try pci=usepirqmask
Sep 19 08:46:46 jtlin60 kernel: PCI: Found IRQ 11 for device 0000:00:0b.1
Sep 19 08:46:46 jtlin60 kernel: apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16ac)
Sep 19 08:46:46 jtlin60 kernel: VFS: Disk quotas dquot_6.5.1
Sep 19 08:46:46 jtlin60 kernel: Initializing Cryptographic API
Sep 19 08:46:46 jtlin60 kernel: Limiting direct PCI/PCI transfers.
Sep 19 08:46:43 jtlin60 sysctl: kernel.core_uses_pid = 1 
Sep 19 08:46:46 jtlin60 kernel: isapnp: Scanning for PnP cards...
Sep 19 08:46:43 jtlin60 network: Setting network parameters:  succeeded 
Sep 19 08:46:46 jtlin60 kernel: isapnp: No Plug & Play device found
Sep 19 08:46:46 jtlin60 kernel: Using anticipatory scheduling io scheduler
Sep 19 08:46:46 jtlin60 kernel: Floppy drive(s): fd0 is 1.44M
Sep 19 08:46:46 jtlin60 kernel: FDC 0 is a post-1991 82077
Sep 19 08:46:46 jtlin60 kernel: loop: loaded (max 8 devices)
Sep 19 08:46:46 jtlin60 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 19 08:46:46 jtlin60 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 19 08:46:46 jtlin60 kernel: PIIX4: IDE controller at PCI slot 0000:00:05.1
Sep 19 08:46:46 jtlin60 kernel: PIIX4: chipset revision 1
Sep 19 08:46:46 jtlin60 kernel: PIIX4: not 100%% native mode: will probe irqs later
Sep 19 08:46:46 jtlin60 kernel:     ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
Sep 19 08:46:46 jtlin60 kernel:     ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
Sep 19 08:46:46 jtlin60 kernel: hda: TOSHIBA MK2018GAP, ATA DISK drive
Sep 19 08:46:46 jtlin60 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 19 08:46:46 jtlin60 kernel: hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
Sep 19 08:46:46 jtlin60 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 19 08:46:46 jtlin60 kernel: hda: max request size: 128KiB
Sep 19 08:46:46 jtlin60 kernel: hda: 39070080 sectors (20003 MB), CHS=38760/16/63, UDMA(33)
Sep 19 08:46:46 jtlin60 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Sep 19 08:46:46 jtlin60 kernel: ide-floppy driver 0.99.newide
Sep 19 08:46:46 jtlin60 kernel: mice: PS/2 mouse device common for all mice
Sep 19 08:46:46 jtlin60 last message repeated 2 times
Sep 19 08:46:46 jtlin60 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 19 08:46:46 jtlin60 kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep 19 08:46:46 jtlin60 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 19 08:46:46 jtlin60 kernel: NET: Registered protocol family 2
Sep 19 08:46:46 jtlin60 kernel: IP: routing cache hash table of 1024 buckets, 8Kbytes
Sep 19 08:46:46 jtlin60 kernel: TCP: Hash tables configured (established 16384 bind 16384)
Sep 19 08:46:46 jtlin60 kernel: Initializing IPsec netlink socket
Sep 19 08:46:46 jtlin60 kernel: NET: Registered protocol family 1
Sep 19 08:46:46 jtlin60 kernel: NET: Registered protocol family 17
Sep 19 08:46:46 jtlin60 kernel: NET: Registered protocol family 15
Sep 19 08:46:46 jtlin60 kernel: kjournald starting.  Commit interval 5 seconds
Sep 19 08:46:46 jtlin60 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 19 08:46:46 jtlin60 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 19 08:46:46 jtlin60 kernel: Freeing unused kernel memory: 112k freed
Sep 19 08:46:46 jtlin60 kernel: Adding 1028152k swap on /dev/hda2.  Priority:-1 extents:1
Sep 19 08:46:46 jtlin60 pcmcia: Starting PCMCIA services: 
Sep 19 08:46:46 jtlin60 kernel: EXT3 FS on hda1, internal journal
Sep 19 08:46:46 jtlin60 kernel: kjournald starting.  Commit interval 5 seconds
Sep 19 08:46:46 jtlin60 kernel: EXT3 FS on hda3, internal journal
Sep 19 08:46:46 jtlin60 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 19 08:46:46 jtlin60 kernel: kjournald starting.  Commit interval 5 seconds
Sep 19 08:46:46 jtlin60 kernel: EXT3 FS on hda5, internal journal
Sep 19 08:46:46 jtlin60 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 19 08:46:46 jtlin60 kernel: kjournald starting.  Commit interval 5 seconds
Sep 19 08:46:46 jtlin60 kernel: EXT3 FS on hda6, internal journal
Sep 19 08:46:46 jtlin60 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 19 08:46:46 jtlin60 kernel: updfstab: numerical sysctl 1 23 is obsolete.
Sep 19 08:46:47 jtlin60 kernel: kudzu: numerical sysctl 1 23 is obsolete.
Sep 19 08:46:47 jtlin60 kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Sep 19 08:46:47 jtlin60 kernel: parport0: irq 7 detected
Sep 19 08:46:47 jtlin60 kernel: Linux Kernel Card Services 3.1.22
Sep 19 08:46:47 jtlin60 kernel:   options:  [pci] [cardbus] [pm]
Sep 19 08:46:47 jtlin60 kernel: PCI: Found IRQ 11 for device 0000:00:0b.0
Sep 19 08:46:47 jtlin60 kernel: Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
Sep 19 08:46:47 jtlin60 kernel: Yenta: ISA IRQ list 06b0, PCI irq11
Sep 19 08:46:47 jtlin60 kernel: Socket status: 30000020
Sep 19 08:46:47 jtlin60 kernel: PCI: Found IRQ 11 for device 0000:00:0b.1
Sep 19 08:46:47 jtlin60 kernel: Yenta: CardBus bridge found at 0000:00:0b.1 [1179:0001]
Sep 19 08:46:47 jtlin60 kernel: Yenta: ISA IRQ list 06b0, PCI irq11
Sep 19 08:46:47 jtlin60 kernel: Socket status: 30000007
Sep 19 08:46:48 jtlin60 pcmcia: cardmgr[564]: watching 2 sockets
Sep 19 08:46:48 jtlin60 cardmgr[564]: watching 2 sockets
Sep 19 08:46:48 jtlin60 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Sep 19 08:46:48 jtlin60 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
Sep 19 08:46:48 jtlin60 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Sep 19 08:46:48 jtlin60 cardmgr[565]: starting, version is 3.2.5
Sep 19 08:46:48 jtlin60 pcmcia: done.
Sep 19 08:46:48 jtlin60 rc: Starting pcmcia:  succeeded
Sep 19 08:46:49 jtlin60 mount: mount: fs type devpts not supported by kernel
Sep 19 08:46:49 jtlin60 mount: mount: you must specify the filesystem type
Sep 19 08:46:49 jtlin60 netfs: Mounting other filesystems:  failed
Sep 19 08:46:49 jtlin60 apmd[626]: Version 3.0.2 (APM BIOS 1.2, Linux driver 1.16ac)
Sep 19 08:46:49 jtlin60 apmd: apmd startup succeeded
Sep 19 08:46:49 jtlin60 autofs: automount startup succeeded
Sep 19 08:46:50 jtlin60 apmd[626]: Battery: * * * (100% 2:28)
Sep 19 08:46:51 jtlin60 xinetd[694]: xinetd Version 2002.03.28 started with libwrap options compiled in.
Sep 19 08:46:51 jtlin60 xinetd[694]: Started working: 2 available services
Sep 19 08:46:53 jtlin60 xinetd: xinetd startup succeeded
Sep 19 08:46:55 jtlin60 gpm: gpm startup succeeded
Sep 19 08:46:55 jtlin60 crond: crond startup succeeded
Sep 19 08:46:57 jtlin60 xfs: listening on port 7100 
Sep 19 08:46:57 jtlin60 xfs: xfs startup succeeded
Sep 19 08:46:57 jtlin60 anacron: anacron startup succeeded
Sep 19 08:46:57 jtlin60 atd: atd startup succeeded
Sep 19 08:46:57 jtlin60 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Sep 19 08:46:57 jtlin60 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
Sep 19 08:46:57 jtlin60 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
Sep 19 08:46:57 jtlin60 xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable) 
Sep 19 08:46:58 jtlin60 wine: Registering binary handler for Windows applications
Sep 19 08:46:58 jtlin60 wine: /etc/rc3.d/S98wine: /proc/sys/fs/binfmt_misc/register: No such file or directory
Sep 19 08:46:58 jtlin60 wine: /etc/rc3.d/S98wine: /proc/sys/fs/binfmt_misc/register: No such file or directory
Sep 19 08:46:58 jtlin60 rc: Starting wine:  succeeded
Sep 19 08:46:58 jtlin60 kernel: warning: process `update' used the obsolete bdflush system call
Sep 19 08:46:58 jtlin60 kernel: Fix your initscripts?
Sep 19 08:47:02 jtlin60 apmd[626]: Now using AC Power
Sep 19 08:47:02 jtlin60 login(pam_unix)[869]: session opened for user root by LOGIN(uid=0)
Sep 19 08:47:02 jtlin60  -- root[869]: ROOT LOGIN ON tty1
Sep 19 08:47:03 jtlin60 kernel: warning: process `update' used the obsolete bdflush system call
Sep 19 08:47:03 jtlin60 kernel: Fix your initscripts?
Sep 19 08:47:34 jtlin60 kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep 19 08:47:34 jtlin60 kernel: drivers/usb/core/usb.c: registered new driver hub
Sep 19 08:47:50 jtlin60 kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Sep 19 08:47:50 jtlin60 kernel: PCI: Found IRQ 11 for device 0000:00:05.2
Sep 19 08:47:50 jtlin60 kernel: PCI: Sharing IRQ 11 with 0000:00:0c.0
Sep 19 08:47:50 jtlin60 kernel: uhci-hcd 0000:00:05.2: UHCI Host Controller
Sep 19 08:47:50 jtlin60 kernel: Call Trace:
Sep 19 08:47:50 jtlin60 kernel:  [<c010a56b>] __report_bad_irq+0x2f/0x90
Sep 19 08:47:50 jtlin60 kernel:  [<c010a573>] __report_bad_irq+0x37/0x90
Sep 19 08:47:50 jtlin60 kernel:  [<c010a640>] note_interrupt+0x50/0x78
Sep 19 08:47:50 jtlin60 kernel:  [<c010a7b2>] do_IRQ+0x92/0xf0
Sep 19 08:47:50 jtlin60 kernel:  [<c01092f0>] common_interrupt+0x18/0x20
Sep 19 08:47:50 jtlin60 kernel:  [<c011aec7>] do_softirq+0x47/0xac
Sep 19 08:47:50 jtlin60 kernel:  [<c010a7fd>] do_IRQ+0xdd/0xf0
Sep 19 08:47:50 jtlin60 kernel:  [<c01092f0>] common_interrupt+0x18/0x20
Sep 19 08:47:50 jtlin60 kernel:  [<c019ba69>] pci_bus_write_config_word+0x2d/0x40
Sep 19 08:47:50 jtlin60 kernel:  [<cc91096e>] uhci_reset+0x2e/0x40 [uhci_hcd]
Sep 19 08:47:50 jtlin60 kernel:  [<cc8b4d67>] usb_hcd_pci_probe+0x2eb/0x440 [usbcore]
Sep 19 08:47:50 jtlin60 kernel:  [<c019e929>] pci_device_probe_static+0x2d/0x44
Sep 19 08:47:50 jtlin60 kernel:  [<c019e960>] __pci_device_probe+0x20/0x38
Sep 19 08:47:50 jtlin60 kernel:  [<c019e996>] pci_device_probe+0x1e/0x38
Sep 19 08:47:50 jtlin60 kernel:  [<c01b9562>] bus_match+0x32/0x58
Sep 19 08:47:50 jtlin60 kernel:  [<c01b9658>] driver_attach+0x44/0x84
Sep 19 08:47:50 jtlin60 kernel:  [<c01b9863>] bus_add_driver+0x63/0x7c
Sep 19 08:47:50 jtlin60 kernel:  [<c01b9af2>] driver_register+0x36/0x38
Sep 19 08:47:50 jtlin60 kernel:  [<c019eb19>] pci_register_driver+0x59/0x7c
Sep 19 08:47:50 jtlin60 kernel:  [<cc8a00ae>] uhci_hcd_init+0xae/0x130 [uhci_hcd]
Sep 19 08:47:50 jtlin60 kernel:  [<c0129d81>] sys_init_module+0xe1/0x1ac
Sep 19 08:47:50 jtlin60 kernel:  [<c0109183>] syscall_call+0x7/0xb
Sep 19 08:47:50 jtlin60 kernel: 
Sep 19 08:47:50 jtlin60 kernel: handlers:
Sep 19 08:47:50 jtlin60 kernel: [<cc89b740>] (yenta_interrupt+0x0/0x2c [yenta_socket])
Sep 19 08:47:50 jtlin60 kernel: [<cc89b740>] (yenta_interrupt+0x0/0x2c [yenta_socket])
Sep 19 08:47:50 jtlin60 kernel: Disabling IRQ #11
Sep 19 08:47:50 jtlin60 kernel: uhci-hcd 0000:00:05.2: irq 11, io base 0000ff80
Sep 19 08:47:50 jtlin60 kernel: uhci-hcd 0000:00:05.2: new USB bus registered, assigned bus number 1
Sep 19 08:47:50 jtlin60 kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
Sep 19 08:47:50 jtlin60 kernel: usb usb1: Product: UHCI Host Controller
Sep 19 08:47:50 jtlin60 kernel: usb usb1: Manufacturer: Linux 2.6.0-test5 uhci-hcd
Sep 19 08:47:50 jtlin60 kernel: usb usb1: SerialNumber: 0000:00:05.2
Sep 19 08:47:50 jtlin60 kernel: hub 1-0:0: USB hub found
Sep 19 08:47:50 jtlin60 kernel: hub 1-0:0: 2 ports detected
Sep 19 08:47:51 jtlin60 kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
Sep 19 08:47:51 jtlin60 kernel: hub 1-0:0: new USB device on port 2, assigned address 2
Sep 19 08:47:56 jtlin60 kernel: usb 1-2: control timeout on ep0out
Sep 19 08:47:56 jtlin60 kernel: uhci-hcd 0000:00:05.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
Sep 19 08:50:22 jtlin60 login(pam_unix)[870]: session opened for user root by LOGIN(uid=0)
Sep 19 08:50:22 jtlin60  -- root[870]: ROOT LOGIN ON tty2


cat /proc/version

Linux version 2.6.0-test5 (root@jtlin60) (gcc version 2.95.3 20010315 (release)) #9 Fri Sep 19 00:16:44 EDT 2003

cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 361.392
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 692.22

cat /proc/ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : 0000:00:07.0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #02
  1000-107f : 0000:02:00.0
1400-14ff : PCI CardBus #02
1800-18ff : PCI CardBus #06
1c00-1cff : 0000:00:07.0
2000-20ff : PCI CardBus #06
fe00-fe3f : 0000:00:05.3
fe60-fe7f : 0000:00:05.3
fefc-feff : 0000:00:0c.0
ff00-ff3f : 0000:00:0c.0
ff60-ff7f : 0000:00:09.0
ff80-ff9f : 0000:00:05.2
  ff80-ff9f : uhci-hcd
fff0-ffff : 0000:00:05.1
  fff0-fff7 : ide0
  fff8-ffff : ide1

cat /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e8000-000ebfff : reserved
000f0000-000fffff : System ROM
00100000-0bfdffff : System RAM
  00100000-002440af : Kernel code
  002440b0-002f0f1f : Kernel data
0bfe0000-0bfeffff : ACPI Tables
0bff0000-0bffffff : reserved
10000000-10000fff : 0000:00:0b.0
  10000000-10000fff : yenta_socket
10001000-10001fff : 0000:00:0b.1
  10001000-10001fff : yenta_socket
100a0000-100b6dff : reserved
100b6e00-100b6fff : ACPI Non-volatile Storage
100b7000-100fffff : reserved
10400000-107fffff : PCI CardBus #02
  10400000-1041ffff : 0000:02:00.0
10800000-10bfffff : PCI CardBus #02
  10800000-1080007f : 0000:02:00.0
  10800080-108000ff : 0000:02:00.0
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
e0000000-e7ffffff : 0000:00:00.0
efff8000-efffffff : 0000:00:0c.0
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : 0000:01:00.0
ffefff00-ffefffff : 0000:00:07.0
fff80000-ffffffff : reserved

cat /proc/scsi/scsi

cat: /proc/scsi/scsi: No such file or directory


lspci -vvv

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Subsystem: Toshiba America Info Systems Toshiba Tecra 8100 Laptop System Chipset
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f0000000-f7ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at fff0 [size=16]

00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
	Subsystem: Toshiba America Info Systems Internal V.90 Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at ffefff00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 02f8 [size=8]
	Region 2: I/O ports at 1c00 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=160mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
	Subsystem: Toshiba America Info Systems FIR Port Type-DO
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ff60 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1+,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 20)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00002000-000020ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at efff8000 (32-bit, non-prefetchable) [size=32K]
	Region 1: I/O ports at ff00 [size=64]
	Region 2: I/O ports at fefc [size=4]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-MV (rev 11) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 1.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus (rev 10)
	Subsystem: 3Com Corporation FE575C-3Com 10/100 LAN CardBus-Fast Ethernet
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [disabled] [size=128]
	Region 1: Memory at 10800000 (32-bit, non-prefetchable) [disabled] [size=128]
	Region 2: Memory at 10800080 (32-bit, non-prefetchable) [disabled] [size=128]
	Expansion ROM at 10400000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-




--------------030703020605000103070603
Content-Type: text/plain;
 name="Linux.dot.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Linux.dot.config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
CONFIG_M386=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI_HT is not set
# CONFIG_ACPI is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
# CONFIG_EISA_PCI_EISA is not set
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_CY82C693=y
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_HPT34X=y
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Ltmodem
#
# CONFIG_LT_MODEM is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_UNIX98_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_ALI=m
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=m
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X_STANDALONE is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--------------030703020605000103070603--

