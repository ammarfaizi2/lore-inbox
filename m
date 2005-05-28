Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVE1JWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVE1JWo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 05:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVE1JWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 05:22:44 -0400
Received: from smtpout15.mailhost.ntl.com ([212.250.162.15]:37183 "EHLO
	mta05-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262546AbVE1JTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 05:19:02 -0400
Date: Sat, 28 May 2005 10:18:46 +0100
From: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Swsusp: "sleeping function called from invalid context"
Message-ID: <20050528091846.GA2628@cray.fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi all,

Despite the dire warnings in Documentation/power/swsusp.txt, I decided to try
out swsusp on my 1.2GHz Duron desktop machine. I used 2.6.12-rc5, and the
following command line given in the documentation:

echo shutdown > /sys/power/disk; echo disk > /sys/power/state

On resume, the kernel log (attached) had a number of scheduling while atomic
warnings, and the bash process used to initiate the suspend segfaulted.

I did this test from a clean boot, from the console without loading X11.

Regards,
Charlie

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

May 27 23:13:04 cray kernel: Linux version 2.6.12-rc5 (cgb23@cray) (gcc version 3.3.6 (Debian 1:3.3.6-5)) #1 Fri May 27 22:20:05 BST 2005
May 27 23:13:04 cray kernel: BIOS-provided physical RAM map:
May 27 23:13:04 cray kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
May 27 23:13:04 cray kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
May 27 23:13:04 cray kernel:  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
May 27 23:13:04 cray kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
May 27 23:13:04 cray kernel: 256MB LOWMEM available.
May 27 23:13:04 cray kernel: On node 0 totalpages: 65536
May 27 23:13:04 cray kernel:   DMA zone: 4096 pages, LIFO batch:1
May 27 23:13:04 cray kernel:   Normal zone: 61440 pages, LIFO batch:31
May 27 23:13:04 cray kernel:   HighMem zone: 0 pages, LIFO batch:1
May 27 23:13:04 cray kernel: DMI 2.3 present.
May 27 23:13:04 cray kernel: Allocating PCI resources starting at 10000000 (gap: 10000000:efff0000)
May 27 23:13:04 cray kernel: Built 1 zonelists
May 27 23:13:04 cray kernel: Kernel command line: BOOT_IMAGE=Linux ro root=303 apm=power-off resume=/dev/hda2
May 27 23:13:04 cray kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
May 27 23:13:04 cray kernel: mapped APIC to ffffd000 (01201000)
May 27 23:13:04 cray kernel: Initializing CPU#0
May 27 23:13:04 cray kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
May 27 23:13:04 cray kernel: Detected 1203.036 MHz processor.
May 27 23:13:04 cray kernel: Using tsc for high-res timesource
May 27 23:13:04 cray kernel: Console: colour VGA+ 80x25
May 27 23:13:04 cray kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
May 27 23:13:04 cray kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
May 27 23:13:04 cray kernel: Memory: 256196k/262144k available (1783k kernel code, 5460k reserved, 837k data, 164k init, 0k highmem)
May 27 23:13:04 cray kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
May 27 23:13:04 cray kernel: Calibrating delay loop... 2375.68 BogoMIPS (lpj=1187840)
May 27 23:13:04 cray kernel: Mount-cache hash table entries: 512
May 27 23:13:04 cray kernel: CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
May 27 23:13:04 cray kernel: CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
May 27 23:13:04 cray kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
May 27 23:13:04 cray kernel: CPU: L2 Cache: 64K (64 bytes/line)
May 27 23:13:04 cray kernel: CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00000000 00000000
May 27 23:13:04 cray kernel: Intel machine check architecture supported.
May 27 23:13:04 cray kernel: Intel machine check reporting enabled on CPU#0.
May 27 23:13:04 cray kernel: CPU: AMD Duron(tm) processor stepping 01
May 27 23:13:04 cray kernel: Enabling fast FPU save and restore... done.
May 27 23:13:04 cray kernel: Enabling unmasked SIMD FPU exception support... done.
May 27 23:13:04 cray kernel: Checking 'hlt' instruction... OK.
May 27 23:13:04 cray kernel: NET: Registered protocol family 16
May 27 23:13:04 cray kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb510, last bus=1
May 27 23:13:04 cray kernel: PCI: Using configuration type 1
May 27 23:13:04 cray kernel: mtrr: v2.0 (20020519)
May 27 23:13:04 cray kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
May 27 23:13:04 cray kernel: PnPBIOS: Scanning system for PnP BIOS support...
May 27 23:13:04 cray kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fc040
May 27 23:13:04 cray kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc070, dseg 0xf0000
May 27 23:13:04 cray kernel: PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
May 27 23:13:04 cray kernel: SCSI subsystem initialized
May 27 23:13:04 cray kernel: usbcore: registered new driver usbfs
May 27 23:13:04 cray kernel: usbcore: registered new driver hub
May 27 23:13:04 cray kernel: PCI: Probing PCI hardware
May 27 23:13:04 cray kernel: PCI: Probing PCI hardware (bus 00)
May 27 23:13:04 cray kernel: PCI: Via IRQ fixup
May 27 23:13:04 cray kernel: Boot video device is 0000:01:00.0
May 27 23:13:04 cray kernel: PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
May 27 23:13:04 cray kernel: Machine check exception polling timer started.
May 27 23:13:04 cray kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
May 27 23:13:04 cray kernel: Initializing Cryptographic API
May 27 23:13:04 cray kernel: Applying VIA southbridge workaround.
May 27 23:13:04 cray kernel: PCI: Disabling Via external APIC routing
May 27 23:13:04 cray kernel: isapnp: Scanning for PnP cards...
May 27 23:13:04 cray kernel: isapnp: No Plug & Play device found
May 27 23:13:04 cray kernel: Linux agpgart interface v0.101 (c) Dave Jones
May 27 23:13:04 cray kernel: agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
May 27 23:13:04 cray kernel: agpgart: AGP aperture is 64M @ 0xe0000000
May 27 23:13:04 cray kernel: PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 10
May 27 23:13:04 cray kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May 27 23:13:04 cray kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
May 27 23:13:04 cray kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
May 27 23:13:04 cray kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
May 27 23:13:04 cray kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
May 27 23:13:04 cray kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
May 27 23:13:04 cray kernel: parport_pc: VIA 686A/8231 detected
May 27 23:13:04 cray kernel: parport_pc: probing current configuration
May 27 23:13:04 cray kernel: parport_pc: Current parallel port base: 0x378
May 27 23:13:04 cray kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
May 27 23:13:04 cray kernel: parport_pc: VIA parallel port: io=0x378, irq=7
May 27 23:13:04 cray kernel: io scheduler noop registered
May 27 23:13:04 cray kernel: io scheduler anticipatory registered
May 27 23:13:04 cray kernel: io scheduler deadline registered
May 27 23:13:04 cray kernel: io scheduler cfq registered
May 27 23:13:04 cray kernel: Floppy drive(s): fd0 is 1.44M
May 27 23:13:04 cray kernel: FDC 0 is a post-1991 82077
May 27 23:13:04 cray kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
May 27 23:13:04 cray kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
May 27 23:13:04 cray kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 27 23:13:04 cray kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
May 27 23:13:04 cray kernel: VP_IDE: chipset revision 6
May 27 23:13:04 cray kernel: VP_IDE: not 100%% native mode: will probe irqs later
May 27 23:13:04 cray kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
May 27 23:13:04 cray kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
May 27 23:13:04 cray kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:DMA
May 27 23:13:04 cray kernel: Probing IDE interface ide0...
May 27 23:13:04 cray kernel: hda: IC35L060AVER07-0, ATA DISK drive
May 27 23:13:04 cray kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 27 23:13:04 cray kernel: Probing IDE interface ide1...
May 27 23:13:04 cray kernel: hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
May 27 23:13:04 cray kernel: hdd: set_drive_speed_status: status=0x40 { DriveReady }
May 27 23:13:04 cray kernel: hdd: set_drive_speed_status: status=0x40 { DriveReady }
May 27 23:13:04 cray kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 27 23:13:04 cray kernel: Probing IDE interface ide2...
May 27 23:13:04 cray kernel: Probing IDE interface ide3...
May 27 23:13:04 cray kernel: Probing IDE interface ide4...
May 27 23:13:04 cray kernel: Probing IDE interface ide5...
May 27 23:13:04 cray kernel: hda: max request size: 128KiB
May 27 23:13:04 cray kernel: hda: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
May 27 23:13:04 cray kernel: hda: cache flushes not supported
May 27 23:13:04 cray kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
May 27 23:13:04 cray kernel: hdd: ATAPI 24X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
May 27 23:13:04 cray kernel: Uniform CD-ROM driver Revision: 3.20
May 27 23:13:04 cray kernel: usbmon: debugs is not available
May 27 23:13:04 cray kernel: usbcore: registered new driver usbhid
May 27 23:13:04 cray kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
May 27 23:13:04 cray kernel: mice: PS/2 mouse device common for all mice
May 27 23:13:04 cray kernel: NET: Registered protocol family 2
May 27 23:13:04 cray kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
May 27 23:13:04 cray kernel: TCP established hash table entries: 16384 (order: 5, 131072 bytes)
May 27 23:13:04 cray kernel: TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
May 27 23:13:04 cray kernel: TCP: Hash tables configured (established 16384 bind 16384)
May 27 23:13:04 cray kernel: NET: Registered protocol family 1
May 27 23:13:04 cray kernel: NET: Registered protocol family 17
May 27 23:13:04 cray kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
May 27 23:13:04 cray kernel: swsusp: Suspend partition has wrong signature?
May 27 23:13:04 cray kernel: EXT3-fs: hda3: orphan cleanup on readonly fs
May 27 23:13:04 cray kernel: kjournald starting.  Commit interval 5 seconds
May 27 23:13:04 cray kernel: ext3_orphan_cleanup: deleting unreferenced inode 162965
May 27 23:13:04 cray kernel: ext3_orphan_cleanup: deleting unreferenced inode 97436
May 27 23:13:04 cray kernel: ext3_orphan_cleanup: deleting unreferenced inode 195700
May 27 23:13:04 cray kernel: EXT3-fs: hda3: 3 orphan inodes deleted
May 27 23:13:04 cray kernel: EXT3-fs: recovery complete.
May 27 23:13:04 cray kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 27 23:13:04 cray kernel: VFS: Mounted root (ext3 filesystem) readonly.
May 27 23:13:04 cray kernel: Freeing unused kernel memory: 164k freed
May 27 23:13:04 cray kernel: Adding 1999864k swap on /dev/hda2.  Priority:-1 extents:1
May 27 23:13:04 cray kernel: EXT3 FS on hda3, internal journal
May 27 23:13:04 cray kernel: ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
May 27 23:13:04 cray kernel:   http://www.scyld.com/network/ne2k-pci.html
May 27 23:13:04 cray kernel: PCI: Found IRQ 11 for device 0000:00:0a.0
May 27 23:13:04 cray kernel: PCI: Sharing IRQ 11 with 0000:00:07.5
May 27 23:13:04 cray kernel: eth0: RealTek RTL-8029 found at 0xbc00, IRQ 11, 00:40:95:46:9D:D9.
May 27 23:13:04 cray kernel: Creative EMU10K1 PCI Audio Driver, version 0.20a, 22:12:55 May 27 2005
May 27 23:13:04 cray kernel: PCI: Found IRQ 12 for device 0000:00:0b.0
May 27 23:13:04 cray kernel: emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xc000-0xc01f, IRQ 12
May 27 23:13:04 cray kernel: ac97_codec: AC97  codec, id: TRA3 (TriTech TR28023)
May 27 23:13:04 cray kernel: kjournald starting.  Commit interval 5 seconds
May 27 23:13:04 cray kernel: EXT3 FS on hda1, internal journal
May 27 23:13:04 cray kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 27 23:13:04 cray kernel: kjournald starting.  Commit interval 5 seconds
May 27 23:13:04 cray kernel: EXT3 FS on hda5, internal journal
May 27 23:13:04 cray kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 27 23:13:04 cray kernel: kjournald starting.  Commit interval 5 seconds
May 27 23:13:04 cray kernel: EXT3 FS on hda6, internal journal
May 27 23:13:04 cray kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 27 23:13:04 cray kernel: kjournald starting.  Commit interval 5 seconds
May 27 23:13:04 cray kernel: EXT3 FS on hda7, internal journal
May 27 23:13:04 cray kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 27 23:13:04 cray kernel: USB Universal Host Controller Interface driver v2.2
May 27 23:13:04 cray kernel: PCI: Found IRQ 5 for device 0000:00:07.2
May 27 23:13:04 cray kernel: PCI: Sharing IRQ 5 with 0000:00:07.3
May 27 23:13:04 cray kernel: uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
May 27 23:13:04 cray kernel: uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
May 27 23:13:04 cray kernel: uhci_hcd 0000:00:07.2: irq 5, io base 0x0000a400
May 27 23:13:04 cray kernel: hub 1-0:1.0: USB hub found
May 27 23:13:04 cray kernel: hub 1-0:1.0: 2 ports detected
May 27 23:13:04 cray kernel: PCI: Found IRQ 5 for device 0000:00:07.3
May 27 23:13:04 cray kernel: PCI: Sharing IRQ 5 with 0000:00:07.2
May 27 23:13:04 cray kernel: uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
May 27 23:13:04 cray kernel: uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
May 27 23:13:04 cray kernel: uhci_hcd 0000:00:07.3: irq 5, io base 0x0000a800
May 27 23:13:04 cray kernel: hub 2-0:1.0: USB hub found
May 27 23:13:04 cray kernel: hub 2-0:1.0: 2 ports detected
May 27 23:13:04 cray kernel: usb 1-2: new low speed USB device using uhci_hcd and address 2
May 27 23:13:04 cray kernel: input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:07.2-2
May 27 23:13:04 cray kernel: input: PC Speaker
May 27 23:13:07 cray kernel: lp0: using parport0 (interrupt-driven).
May 27 23:13:10 cray kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
May 27 23:12:58 cray kernel: Bluetooth: Core ver 2.7
May 27 23:12:58 cray kernel: NET: Registered protocol family 31
May 27 23:12:58 cray kernel: Bluetooth: HCI device and connection manager initialized
May 27 23:12:58 cray kernel: Bluetooth: HCI socket layer initialized
May 27 23:12:58 cray kernel: Bluetooth: L2CAP ver 2.7
May 27 23:12:58 cray kernel: Bluetooth: L2CAP socket layer initialized
May 27 23:12:58 cray kernel: Bluetooth: RFCOMM ver 1.5
May 27 23:12:58 cray kernel: Bluetooth: RFCOMM socket layer initialized
May 27 23:12:58 cray kernel: Bluetooth: RFCOMM TTY layer initialized
May 27 23:15:54 cray kernel: Stopping tasks: ======================================================|
May 27 23:15:54 cray kernel: Freeing memory...  ^Hdone (0 pages freed)
May 27 23:15:54 cray kernel: swsusp: Need to copy 17161 pages
May 27 23:15:54 cray kernel: hub 2-0:1.0: resubmit --> -108
May 27 23:15:54 cray kernel: hub 1-0:1.0: resubmit --> -108
May 27 23:15:54 cray kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:102
May 27 23:15:54 cray kernel: in_atomic():1, irqs_disabled():0
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c01145dd>] __might_sleep+0xbd/0xf0
May 27 23:15:54 cray kernel:  [<c020e6a2>] device_resume+0x12/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c011fbef>] msleep+0x2f/0x40
May 27 23:15:54 cray kernel:  [<c01d3a1f>] pci_set_power_state+0xff/0x180
May 27 23:15:54 cray kernel:  [<c01d3b88>] pci_enable_device_bars+0x18/0x40
May 27 23:15:54 cray kernel:  [<c01d3bc0>] pci_enable_device+0x10/0x30
May 27 23:15:54 cray kernel:  [<c024f66f>] usb_hcd_pci_resume+0x3f/0x150
May 27 23:15:54 cray kernel:  [<c01d582f>] pci_device_resume+0x1f/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: PCI: Found IRQ 5 for device 0000:00:07.2
May 27 23:15:54 cray kernel: PCI: Sharing IRQ 5 with 0000:00:07.3
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c011fbef>] msleep+0x2f/0x40
May 27 23:15:54 cray kernel:  [<c01d3a1f>] pci_set_power_state+0xff/0x180
May 27 23:15:54 cray kernel:  [<c01d3b88>] pci_enable_device_bars+0x18/0x40
May 27 23:15:54 cray kernel:  [<c01d3bc0>] pci_enable_device+0x10/0x30
May 27 23:15:54 cray kernel:  [<c024f66f>] usb_hcd_pci_resume+0x3f/0x150
May 27 23:15:54 cray kernel:  [<c01d582f>] pci_device_resume+0x1f/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: PCI: Found IRQ 5 for device 0000:00:07.3
May 27 23:15:54 cray kernel: PCI: Sharing IRQ 5 with 0000:00:07.2
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c011fbef>] msleep+0x2f/0x40
May 27 23:15:54 cray kernel:  [<d095b9b5>] reset_hc+0x55/0x80 [uhci_hcd]
May 27 23:15:54 cray kernel:  [<d095c3ee>] uhci_resume+0x3e/0xf0 [uhci_hcd]
May 27 23:15:54 cray kernel:  [<c024f6d5>] usb_hcd_pci_resume+0xa5/0x150
May 27 23:15:54 cray kernel:  [<c01d582f>] pci_device_resume+0x1f/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c011fbef>] msleep+0x2f/0x40
May 27 23:15:54 cray kernel:  [<d095b9c5>] reset_hc+0x65/0x80 [uhci_hcd]
May 27 23:15:54 cray kernel:  [<d095c3ee>] uhci_resume+0x3e/0xf0 [uhci_hcd]
May 27 23:15:54 cray kernel:  [<c024f6d5>] usb_hcd_pci_resume+0xa5/0x150
May 27 23:15:54 cray kernel:  [<c01d582f>] pci_device_resume+0x1f/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: PCI: Found IRQ 12 for device 0000:00:0b.0
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01faab1>] ps2_command+0xd1/0x340
May 27 23:15:54 cray kernel:  [<c025bb05>] atkbd_probe+0x35/0x110
May 27 23:15:54 cray kernel:  [<c025c3d8>] atkbd_reconnect+0x88/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fab3d>] ps2_command+0x15d/0x340
May 27 23:15:54 cray kernel:  [<c025bb05>] atkbd_probe+0x35/0x110
May 27 23:15:54 cray kernel:  [<c025c3d8>] atkbd_reconnect+0x88/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fabdd>] ps2_command+0x1fd/0x340
May 27 23:15:54 cray kernel:  [<c025bb05>] atkbd_probe+0x35/0x110
May 27 23:15:54 cray kernel:  [<c025c3d8>] atkbd_reconnect+0x88/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01faab1>] ps2_command+0xd1/0x340
May 27 23:15:54 cray kernel:  [<c025bd1c>] atkbd_activate+0x1c/0x80
May 27 23:15:54 cray kernel:  [<c025c408>] atkbd_reconnect+0xb8/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01facf6>] ps2_command+0x316/0x340
May 27 23:15:54 cray kernel:  [<c025bd1c>] atkbd_activate+0x1c/0x80
May 27 23:15:54 cray kernel:  [<c025c408>] atkbd_reconnect+0xb8/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01faab1>] ps2_command+0xd1/0x340
May 27 23:15:54 cray kernel:  [<c025bd38>] atkbd_activate+0x38/0x80
May 27 23:15:54 cray kernel:  [<c025c408>] atkbd_reconnect+0xb8/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01facf6>] ps2_command+0x316/0x340
May 27 23:15:54 cray kernel:  [<c025bd38>] atkbd_activate+0x38/0x80
May 27 23:15:54 cray kernel:  [<c025c408>] atkbd_reconnect+0xb8/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01faab1>] ps2_command+0xd1/0x340
May 27 23:15:54 cray kernel:  [<c025bd4f>] atkbd_activate+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c025c408>] atkbd_reconnect+0xb8/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01faab1>] ps2_command+0xd1/0x340
May 27 23:15:54 cray kernel:  [<c025c417>] atkbd_reconnect+0xc7/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bcd1b>] schedule_timeout+0x5b/0xb0
May 27 23:15:54 cray kernel:  [<c01fa97d>] ps2_sendbyte+0xbd/0x120
May 27 23:15:54 cray kernel:  [<c01facf6>] ps2_command+0x316/0x340
May 27 23:15:54 cray kernel:  [<c025c417>] atkbd_reconnect+0xc7/0x120
May 27 23:15:54 cray kernel:  [<c01f9427>] serio_resume+0x27/0x30
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bc548>] wait_for_completion+0x88/0xe0
May 27 23:15:54 cray kernel:  [<c02285b0>] ide_do_drive_cmd+0xe0/0x130
May 27 23:15:54 cray kernel:  [<c0225dda>] generic_ide_resume+0x8a/0xa0
May 27 23:15:54 cray kernel:  [<c020e5af>] resume_device+0x6f/0x80
May 27 23:15:54 cray kernel:  [<c020e687>] dpm_resume+0xc7/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: Debug: sleeping function called from invalid context at include/asm/semaphore.h:102
May 27 23:15:54 cray kernel: in_atomic():1, irqs_disabled():0
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c01145dd>] __might_sleep+0xbd/0xf0
May 27 23:15:54 cray kernel:  [<c020e655>] dpm_resume+0x95/0xd0
May 27 23:15:54 cray kernel:  [<c020e6b3>] device_resume+0x23/0x40
May 27 23:15:54 cray kernel:  [<c01336e8>] finish+0x8/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel: hdd: set_drive_speed_status: status=0x40 { DriveReady }
May 27 23:15:54 cray kernel: ide: failed opcode was: unknown
May 27 23:15:54 cray kernel: Restarting tasks...<3>scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c0131bba>] thaw_processes+0xaa/0xf0
May 27 23:15:54 cray kernel:  [<c01336f6>] finish+0x16/0x40
May 27 23:15:54 cray kernel:  [<c0133837>] pm_suspend_disk+0x57/0x80
May 27 23:15:54 cray kernel:  [<c0131756>] enter_state+0x66/0x70
May 27 23:15:54 cray kernel:  [<c0131893>] state_store+0xa3/0xaa
May 27 23:15:54 cray kernel:  [<c0184ba5>] subsys_attr_store+0x35/0x40
May 27 23:15:54 cray kernel:  [<c0184dfe>] flush_write_buffer+0x2e/0x40
May 27 23:15:54 cray kernel:  [<c0184e5f>] sysfs_write_file+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01512a1>] vfs_write+0x91/0x100
May 27 23:15:54 cray kernel:  [<c01513c1>] sys_write+0x41/0x70
May 27 23:15:54 cray kernel:  [<c0102a79>] syscall_call+0x7/0xb
May 27 23:15:54 cray kernel:  done
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c0102ae6>] work_resched+0x5/0x16
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000001/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c0114059>] sys_sched_yield+0x59/0x80
May 27 23:15:54 cray kernel:  [<c015c622>] coredump_wait+0x32/0xa0
May 27 23:15:54 cray kernel:  [<c015c766>] do_coredump+0xd6/0x1d9
May 27 23:15:54 cray kernel:  [<c0122088>] get_signal_to_deliver+0x1f8/0x2e0
May 27 23:15:54 cray kernel:  [<c010287a>] do_signal+0x6a/0x100
May 27 23:15:54 cray kernel:  [<c010294b>] do_notify_resume+0x3b/0x40
May 27 23:15:54 cray kernel:  [<c0102b0a>] work_notifysig+0x13/0x15
May 27 23:15:54 cray kernel: note: bash[2399] exited with preempt_count 1
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000002/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bc548>] wait_for_completion+0x88/0xe0
May 27 23:15:54 cray kernel:  [<c0125970>] call_usermodehelper+0x90/0xa0
May 27 23:15:54 cray kernel:  [<c01cd6f0>] kobject_hotplug+0x210/0x2a0
May 27 23:15:54 cray kernel:  [<c020bf51>] class_device_del+0x91/0xd0
May 27 23:15:54 cray kernel:  [<c020bf9b>] class_device_unregister+0xb/0x20
May 27 23:15:54 cray kernel:  [<c01ed044>] vcs_remove_devfs+0x14/0x2a
May 27 23:15:54 cray kernel:  [<c01f356a>] con_close+0x7a/0x80
May 27 23:15:54 cray kernel:  [<c01e52fe>] release_dev+0x7ae/0x7c0
May 27 23:15:54 cray kernel:  [<c01e57a2>] tty_release+0x12/0x20
May 27 23:15:54 cray kernel:  [<c0151f6c>] __fput+0x11c/0x130
May 27 23:15:54 cray kernel:  [<c015086f>] filp_close+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01187b2>] put_files_struct+0x62/0xc0
May 27 23:15:54 cray kernel:  [<c0119430>] do_exit+0x100/0x3a0
May 27 23:15:54 cray kernel:  [<c0119742>] do_group_exit+0x32/0xa0
May 27 23:15:54 cray kernel:  [<c0122077>] get_signal_to_deliver+0x1e7/0x2e0
May 27 23:15:54 cray kernel:  [<c010287a>] do_signal+0x6a/0x100
May 27 23:15:54 cray kernel:  [<c010294b>] do_notify_resume+0x3b/0x40
May 27 23:15:54 cray kernel:  [<c0102b0a>] work_notifysig+0x13/0x15
May 27 23:15:54 cray kernel: scheduling while atomic: bash/0x00000002/2399
May 27 23:15:54 cray kernel:  [<c0103927>] dump_stack+0x17/0x20
May 27 23:15:54 cray kernel:  [<c02bc412>] schedule+0x5d2/0x5e0
May 27 23:15:54 cray kernel:  [<c02bc548>] wait_for_completion+0x88/0xe0
May 27 23:15:54 cray kernel:  [<c0125970>] call_usermodehelper+0x90/0xa0
May 27 23:15:54 cray kernel:  [<c01cd6f0>] kobject_hotplug+0x210/0x2a0
May 27 23:15:54 cray kernel:  [<c020bf51>] class_device_del+0x91/0xd0
May 27 23:15:54 cray kernel:  [<c020bf9b>] class_device_unregister+0xb/0x20
May 27 23:15:54 cray kernel:  [<c01f356a>] con_close+0x7a/0x80
May 27 23:15:54 cray kernel:  [<c01e52fe>] release_dev+0x7ae/0x7c0
May 27 23:15:54 cray kernel:  [<c01e57a2>] tty_release+0x12/0x20
May 27 23:15:54 cray kernel:  [<c0151f6c>] __fput+0x11c/0x130
May 27 23:15:54 cray kernel:  [<c015086f>] filp_close+0x4f/0x80
May 27 23:15:54 cray kernel:  [<c01187b2>] put_files_struct+0x62/0xc0
May 27 23:15:54 cray kernel:  [<c0119430>] do_exit+0x100/0x3a0
May 27 23:15:54 cray kernel:  [<c0119742>] do_group_exit+0x32/0xa0
May 27 23:15:54 cray kernel:  [<c0122077>] get_signal_to_deliver+0x1e7/0x2e0
May 27 23:15:54 cray kernel:  [<c010287a>] do_signal+0x6a/0x100
May 27 23:15:54 cray kernel:  [<c010294b>] do_notify_resume+0x3b/0x40
May 27 23:15:54 cray kernel:  [<c0102b0a>] work_notifysig+0x13/0x15
May 27 23:15:54 cray kernel: usb 1-2: USB disconnect, address 2
May 27 23:15:55 cray kernel: usb 1-2: new low speed USB device using uhci_hcd and address 3
May 27 23:15:55 cray kernel: input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:07.2-2
May 27 23:16:35 cray kernel: nfsd: last server has exited
May 27 23:16:35 cray kernel: nfsd: unexporting all filesystems
May 27 23:16:35 cray kernel: Kernel logging (proc) stopped.
May 27 23:16:35 cray kernel: Kernel log daemon terminating.
May 27 23:17:27 cray kernel: klogd 1.4.1#16, log source = /proc/kmsg started.
May 27 23:17:27 cray kernel: Cannot find map file.
May 27 23:17:27 cray kernel: No module symbols loaded - kernel modules not enabled. 

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-rc5
# Fri May 27 21:58:43 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_BKL is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
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
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
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
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set

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
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

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
# IEEE 1394 (FireWire) support
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
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
# CONFIG_IRTTY_SIR is not set

#
# Dongle support
#

#
# Old SIR device drivers
#
# CONFIG_IRPORT_SIR is not set

#
# Old Serial dongle support
#

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_SIGMATEL_FIR is not set
CONFIG_NSC_FIR=m
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
# CONFIG_VIA_FIR is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
# CONFIG_BT_HCIUSB_SCO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
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
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
# CONFIG_EEXPRESS_PRO is not set
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
CONFIG_NE2000=m
# CONFIG_ZNET is not set
# CONFIG_SEEQ8005 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
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
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

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
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

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
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
CONFIG_DRM_TDFX=m
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_AD1889 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_AD1980 is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_USBAT is not set
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
CONFIG_USB_XPAD=m
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y
CONFIG_USB_KC2190=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y
CONFIG_USB_MON=y

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
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_SECURITY is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Page alloc debug is incompatible with Software Suspend on i386
#
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--k1lZvvs/B4yU6o8G--
