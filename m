Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264055AbTH1PfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTH1PfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:35:05 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:1408 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S264055AbTH1Pet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:34:49 -0400
Date: Thu, 28 Aug 2003 07:34:48 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
Message-ID: <20030828153448.GA1001@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I don't know if this sort of thing qualifies as a bug of interest, but I 
was able to get this four times in the space of a half an hour while 
trying to 'apt-get dist-upgrade' my system.  

Thanks for taking a look!

Here's the kernel log:

kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
kernel:  printing eip:
kernel: c016511a
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[find_inode_fast+26/96]    Not tainted
kernel: EFLAGS: 00010282
kernel: EIP is at find_inode_fast+0x1a/0x60
kernel: eax: c0600610   ebx: 0005a648   ecx: 0000000f   edx: 00000000
kernel: esi: de944e00   edi: c153f9fc   ebp: c2cb9e28   esp: c2cb9e18
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process dpkg (pid: 5114, threadinfo=c2cb8000 task=de247280)
kernel: Stack: d8d06240 c2cb8000 c41aa140 0005a648 c2cb9e4c c01657a0 de944e00 c153f9fc
kernel:        0005a648 c153f9fc 0005a648 c41aa140 de944e00 c2cb9e6c c0189242 de944e00
kernel:        0005a648 d8cfe338 fffffff4 d8d1ea38 d8d1e9d0 c2cb9e90 c0159980 d8d1e9d0
kernel: Call Trace:
kernel:  [iget_locked+80/208] iget_locked+0x50/0xd0
kernel:  [ext3_lookup+98/192] ext3_lookup+0x62/0xc0
kernel:  [real_lookup+192/240] real_lookup+0xc0/0xf0
kernel:  [do_lookup+134/160] do_lookup+0x86/0xa0
kernel:  [link_path_walk+1169/2336] link_path_walk+0x491/0x920
kernel:  [open_namei+135/1008] open_namei+0x87/0x3f0
kernel:  [filp_open+65/112] filp_open+0x41/0x70
kernel:  [sys_open+83/144] sys_open+0x53/0x90
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel:
kernel: Code: 0f 18 02 90 39 58 18 74 10 85 d2 89 d0 75 ef 31 c0 83 c4 04
kernel:  <6>note: dpkg[5114] exited with preempt_count 1
kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [schedule+954/960] schedule+0x3ba/0x3c0
kernel:  [unmap_page_range+65/112] unmap_page_range+0x41/0x70
kernel:  [unmap_vmas+433/544] unmap_vmas+0x1b1/0x220
kernel:  [exit_mmap+121/400] exit_mmap+0x79/0x190
kernel:  [mmput+102/192] mmput+0x66/0xc0
kernel:  [do_exit+297/832] do_exit+0x129/0x340
kernel:  [die+225/240] die+0xe1/0xf0
kernel:  [do_page_fault+348/1167] do_page_fault+0x15c/0x48f
kernel:  [ext3_getblk+149/624] ext3_getblk+0x95/0x270
kernel:  [wake_up_buffer+17/48] wake_up_buffer+0x11/0x30
kernel:  [unlock_buffer+53/80] unlock_buffer+0x35/0x50
kernel:  [ll_rw_block+66/144] ll_rw_block+0x42/0x90
kernel:  [__ext3_journal_stop+36/80] __ext3_journal_stop+0x24/0x50
kernel:  [ext3_find_entry+650/960] ext3_find_entry+0x28a/0x3c0
kernel:  [do_page_fault+0/1167] do_page_fault+0x0/0x48f
kernel:  [error_code+45/56] error_code+0x2d/0x38
kernel:  [find_inode_fast+26/96] find_inode_fast+0x1a/0x60
kernel:  [iget_locked+80/208] iget_locked+0x50/0xd0
kernel:  [ext3_lookup+98/192] ext3_lookup+0x62/0xc0
kernel:  [real_lookup+192/240] real_lookup+0xc0/0xf0
kernel:  [do_lookup+134/160] do_lookup+0x86/0xa0
kernel:  [link_path_walk+1169/2336] link_path_walk+0x491/0x920
kernel:  [open_namei+135/1008] open_namei+0x87/0x3f0
kernel:  [filp_open+65/112] filp_open+0x41/0x70
kernel:  [sys_open+83/144] sys_open+0x53/0x90
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

'uname -a':

Linux nika 2.6.0-test4 #1 Mon Aug 25 07:37:38 AKDT 2003 i686 GNU/Linux

'lspci':

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

'cat /proc/cpuinfo':

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1800+
stepping	: 2
cpu MHz		: 1540.193
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3039.23

'dmesg':

Linux version 2.6.0-test4 (root@nika) (gcc version 3.2.3 (Debian)) #1 Mon Aug 25 07:37:38 AKDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux-2.6.0-t4 ro root=301
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1540.193 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3039.23 BogoMIPS
Memory: 513896k/524224k available (2788k kernel code, 9580k reserved, 1000k data, 160k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1539.0649 MHz.
..... host bus clock speed is 267.0765 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfb220, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:08.0
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0b.1
PM: Adding info for pci:0000:00:11.0
PM: Adding info for pci:0000:00:11.1
PM: Adding info for pci:0000:00:11.2
PM: Adding info for pci:0000:00:11.3
PM: Adding info for pci:0000:00:11.4
PM: Adding info for pci:0000:01:00.0
PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
ikconfig 0.5 with /proc/ikconfig
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
Real Time Clock Driver v1.11a
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro KT266/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy0
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c905C Tornado at 0xd400. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 4D080H4, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: Maxtor 4G120J6, ATA DISK drive
PM: Adding info for No Bus:ide1
hdd: CR-48X9TE, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
PM: Adding info for ide:1.1
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 >
hdc: max request size: 1024KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 >
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
sym.0.8.0: setting PCI_COMMAND_INVALIDATE.
sym.0.8.0: 53c875 detected
sym0: <875> rev 0x26 on pci bus 0 device 8 function 0 irq 10
sym0: Tekram NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
PM: Adding info for No Bus:host0
  Vendor: EXABYTE   Model: EXB-85058HE-0000  Rev: 0108
  Type:   Sequential-Access                  ANSI SCSI revision: 02
PM: Adding info for scsi:0:0:5:0
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:11.2: UHCI Host Controller
uhci-hcd 0000:00:11.2: irq 11, io base 0000e400
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
uhci-hcd 0000:00:11.3: UHCI Host Controller
uhci-hcd 0000:00:11.3: irq 11, io base 0000e800
uhci-hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
uhci-hcd 0000:00:11.4: UHCI Host Controller
uhci-hcd 0000:00:11.4: irq 11, io base 0000ec00
uhci-hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
PM: Adding info for usb:usb3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PM: Adding info for usb:3-0:0
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS2++ Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for No Bus:i2c-0
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
ALSA device list:
  #0: Sound Blaster Live! (rev.8) at 0xd800, irq 11
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 1004020k swap on /dev/hda9.  Priority:-1 extents:1
Adding 997880k swap on /dev/hdc8.  Priority:-2 extents:1
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

