Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272454AbTGZK42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272456AbTGZK42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:56:28 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:25865 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272454AbTGZK4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:56:23 -0400
Subject: 2.6.0-test1-wl1A: bad: scheduling while atomic!
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-YMQu6RKT7jPRE/pBlPPp"
Message-Id: <1059217886.611.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 13:11:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YMQu6RKT7jPRE/pBlPPp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

bad: scheduling while atomic!
Call Trace:
 [<c01166b2>] schedule+0x3d2/0x3e0
 [<c0116a18>] wait_for_completion+0x78/0xd0
 [<c0116710>] default_wake_function+0x0/0x30
 [<c0116710>] default_wake_function+0x0/0x30
 [<c015eda8>] link_path_walk+0x828/0x8d0
 [<c0129c71>] synchronize_kernel+0x31/0x40
 [<c01d0fdb>] poke_blanked_console+0x6b/0x80
 [<c0129c30>] wakeme_after_rcu+0x0/0x10
 [<c016c55d>] detach_mnt+0x3d/0x70
 [<c016d623>] do_move_mount+0x213/0x250
 [<c011a34e>] __call_console_drivers+0x5e/0x60
 [<c011a435>] call_console_drivers+0x65/0x120
 [<c016d99b>] do_mount+0xeb/0x180
 [<c0197220>] __copy_from_user_ll+0x70/0x80
 [<c016d8a0>] copy_mount_options+0xe0/0xf0
 [<c016df0f>] sys_mount+0xbf/0x140
 [<c0374de9>] prepare_namespace+0x49/0xc0
 [<c01050a4>] init+0x34/0x1c0
 [<c0105070>] init+0x0/0x1c0
 [<c0107289>] kernel_thread_helper+0x5/0xc


--=-YMQu6RKT7jPRE/pBlPPp
Content-Disposition: attachment; filename=dmesg
Content-Type: application/octet-stream; name=dmesg
Content-Transfer-Encoding: 8bit

Linux version 2.6.0-test1-wl1 (root@glass.felipe-alfaro.com) (gcc version 3.3 20030715 (Red Hat Linux 3.3-14)) #1 Sat Jul 26 12:18:20 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:16
  Normal zone: 61424 pages, LIFO batch:236
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 NEC                        ) @ 0x000fb550
ACPI: RSDT (v001    NEC ND000020 00000.00001) @ 0x0fff0000
ACPI: FADT (v001    NEC ND000020 00000.00001) @ 0x0fff0030
ACPI: BOOT (v001    NEC ND000020 00000.00001) @ 0x0fff00b0
ACPI: DSDT (v001    NEC ND000020 00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=0303
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.071 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 250688k/262080k available (1798k kernel code, 5700k reserved, 699k data, 108k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: Power Resource [PUSB] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9, disabled)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 0
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (CM) [PRB1]
ACPI: Lid Switch [LID0]
ACPI: Fan [FANC] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (64 C)
Real Time Clock Driver v1.11
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8185, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
yenta 0000:00:0c.0: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000020
yenta 0000:00:0c.1: Preassigned resource 2 busy, reconfiguring...
yenta 0000:00:0c.1: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq5
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:00.0: 3Com PCI 3CCFE575CT Tornado CardBus at 0x1000. Vers LK1.1.19
PCI: Setting latency timer of device 0000:02:00.0 to 64
uhci-hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
uhci-hcd 0000:00:07.2: irq 9, io base 0000ef80
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
ALSA device list:
  #0: Yamaha DS-XG PCI (YMF754) at 0xfebf0000, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
VFS: Mounted root (ext2 filesystem) readonly.
bad: scheduling while atomic!
Call Trace:
 [<c01166b2>] schedule+0x3d2/0x3e0
 [<c0116a18>] wait_for_completion+0x78/0xd0
 [<c0116710>] default_wake_function+0x0/0x30
 [<c0116710>] default_wake_function+0x0/0x30
 [<c015eda8>] link_path_walk+0x828/0x8d0
 [<c0129c71>] synchronize_kernel+0x31/0x40
 [<c01d0fdb>] poke_blanked_console+0x6b/0x80
 [<c0129c30>] wakeme_after_rcu+0x0/0x10
 [<c016c55d>] detach_mnt+0x3d/0x70
 [<c016d623>] do_move_mount+0x213/0x250
 [<c011a34e>] __call_console_drivers+0x5e/0x60
 [<c011a435>] call_console_drivers+0x65/0x120
 [<c016d99b>] do_mount+0xeb/0x180
 [<c0197220>] __copy_from_user_ll+0x70/0x80
 [<c016d8a0>] copy_mount_options+0xe0/0xf0
 [<c016df0f>] sys_mount+0xbf/0x140
 [<c0374de9>] prepare_namespace+0x49/0xc0
 [<c01050a4>] init+0x34/0x1c0
 [<c0105070>] init+0x0/0x1c0
 [<c0107289>] kernel_thread_helper+0x5/0xc

Freeing unused kernel memory: 108k freed
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:07.2-1
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-2:0: USB hub found
hub 1-2:0: 2 ports detected
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1
blk: queue c03afa1c, I/O limit 4095Mb (mask 0xffffffff)
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 160 bytes per conntrack
spurious 8259A interrupt: IRQ7.

--=-YMQu6RKT7jPRE/pBlPPp
Content-Disposition: attachment; filename=fstab
Content-Type: text/plain; name=fstab; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/dev/hda3           /                    ext2        defaults,noatime       1 1
/dev/hda1           /boot                ext2        defaults,noatime       1 3
/dev/hda4           /mnt                 ext2        defaults,noatime       1 2
none                /dev/pts             devpts      gid=5,mode=620         0 0
none                /proc                proc        defaults               0 0
none                /dev/shm             tmpfs       defaults               0 0
none                /sys                 sysfs       defaults               0 0
/dev/hda2           swap                 swap        defaults               0 0
/dev/cdrom          /cdrom               iso9660,udf noauto,users,ro        0 0
glass:/data         /net/glass_data      nfs         noauto,users,hard,intr 0 0

--=-YMQu6RKT7jPRE/pBlPPp--

