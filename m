Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTBXIhz>; Mon, 24 Feb 2003 03:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbTBXIhy>; Mon, 24 Feb 2003 03:37:54 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:36535 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261934AbTBXIhv>; Mon, 24 Feb 2003 03:37:51 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Benoit Plessis <benoit.plessis@tuxfamily.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Weird thing happening with kernel 2.5
Date: Mon, 24 Feb 2003 09:47:44 +0100
User-Agent: KMail/1.5
References: <E18mxqQ-0000ci-00@osiris> <87lm077z0c.fsf@maverick.eu.org>
In-Reply-To: <87lm077z0c.fsf@maverick.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302240947.46077.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See the thread "2.5.62 fails to boot, Uncompressing... and then nothing"
You have not enabled the console in your .config.

Duncan.


On Sunday 23 February 2003 17:17, Benoit Plessis wrote:
> Hello,
> I wanted to check on the kernel 2.5 last day and something weird
> happens with every version i have checked (2.5.60 61 and 62).
>
> I use grub to start the kernel, he wrote the correct size etc for the
> boot image and then said Loading Kernel...
> after that i only show disk activity on my systems led and no messages
> from the kernel.
> But if i reboot under a stable kernel (2.4.20-ac2) and that i look on
> the /var/log/messages i can read the previous boot process of the 2.5
> kernel, the only erroneous message i show is the 'Warning: unable to
> open an initial console.' followed by modules loading messages and
> EXT3-FS mounting lines.
> The vga=ask option work as he should but after switching mode nothing
> more appears.
> I have tried with and without the RADEON_FB.
>
> best regards,
> Benoit Plessis
>
> Ps:
> .config:
> CONFIG_FB=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB_RADEON=y
>
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> CONFIG_FONTS=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
>
> Let see a sample boot sequence: (sorry for the size, i striped it a
> max.)
> kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
> kernel: Inspecting /boot/System.map-2.5.62
> kernel: Loaded 24152 symbols from /boot/System.map-2.5.62.
> kernel: Symbols match kernel version 2.5.62.
> kernel: No module symbols loaded - kernel modules not enabled.
> kernel: Linux version 2.5.62 (root@osiris) (version gcc 3.2.3 20030210
> (Debian prerelease)) #1 Sun Feb 23 14:31:09 CET 2003 kernel: Video mode to
> be used for restore is f00
> kernel: BIOS-provided physical RAM map:
>
> .. BIOS lines
>
> kernel: 511MB LOWMEM available.
> ... Memory things ..
> ... ACPI things ..
> kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
> ...
>
> kernel: Kernel command line: rw panicblink=2 3
> kernel: Initializing CPU#0
> kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
> kernel: Detected 1733.229 MHz processor.
> kernel: Calibrating delay loop... 3416.06 BogoMIPS
> kernel: Memory: 515944k/524272k available (1552k kernel code, 7592k
> reserved, 515k data, 120k init, 0k highmem) kernel: Dentry cache hash table
> entries: 65536 (order: 7, 524288 bytes) kernel: Inode-cache hash table
> entries: 32768 (order: 6, 262144 bytes) kernel: Mount-cache hash table
> entries: 512 (order: 0, 4096 bytes) kernel: -/dev
> kernel: -/dev/console
> kernel: -/root
> kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> kernel: CPU: L2 Cache: 256K (64 bytes/line)
> kernel: Intel machine check architecture supported.
> kernel: Intel machine check reporting enabled on CPU#0.
> kernel: CPU: AMD Athlon(TM) XP 2100+ stepping 02
> kernel: Enabling fast FPU save and restore... done.
> kernel: Enabling unmasked SIMD FPU exception support... done.
> kernel: Checking 'hlt' instruction... OK.
> kernel: POSIX conformance testing by UNIFIX
> kernel: enabled ExtINT on CPU#0
> kernel: ESR value before enabling vector: 00000000
> kernel: ESR value after enabling vector: 00000000
>
> .. IO-APIC initialisation (it doesn't know my APIC btw (it's a VIA
> KT400 based mainboard: Asus A7V8x) ..
>
> kernel: ..... CPU clock speed is 1733.0172 MHz.
> kernel: ..... host bus clock speed is 266.0641 MHz.
> kernel: Linux NET4.0 for Linux 2.4
> kernel: Based upon Swansea University Computer Society NET3.039
> kernel: Initializing RT netlink socket
> kernel: mtrr: v2.0 (20020519)
> kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1720, last bus=1
> kernel: PCI: Using configuration type 1
> kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
>
> ... biovec tables ...
>
> kernel: ACPI: Subsystem revision 20030122
> kernel:     ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
> kernel: ACPI: Interpreter enabled
> kernel: ACPI: Using IOAPIC for interrupt routing
>
> ... ACPI Irq Lings ..
>
> kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
> kernel: PCI: Probing PCI hardware (bus 00)
> kernel: block request queues:
> kernel:  128 requests per read queue
> kernel:  128 requests per write queue
> kernel:  8 requests per batch
> kernel:  enter congestion at 15
> kernel:  exit congestion at 17
> kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 0
> kernel: ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using
> IRQ 255 kernel: PCI: Using ACPI for IRQ routing
> kernel: PCI: if you experience problems, try using option 'pci=noacpi' or
> even 'acpi=off' kernel: SBF: Simple Boot Flag extension found and enabled.
> kernel: SBF: Setting boot flags 0x1
> kernel: Enabling SEP on CPU 0
> kernel: aio_setup: sizeof(struct page) = 40
> kernel: VFS: Disk quotas dquot_6.5.1
> kernel: Journalled Block Device driver loaded
> kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
> kernel: devfs: boot_options: 0x1
> kernel: ACPI: Power Button (FF) [PWRF]
> kernel: pty: 256 Unix98 ptys configured
> kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx kernel: VP_IDE: IDE controller at PCI slot 00:11.1
> kernel: ACPI: No IRQ known for interrupt pin A of device 00:11.1 - using
> IRQ 255 kernel: VP_IDE: chipset revision 6
> kernel: VP_IDE: not 100%% native mode: will probe irqs later
> kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on
> pci00:11.1 kernel:     ide0: BM-DMA at 0x8400-0x8407, BIOS settings:
> hda:DMA, hdb:DMA kernel:     ide1: BM-DMA at 0x8408-0x840f, BIOS settings:
> hdc:DMA, hdd:pio kernel: hda: WDC WD800BB-75CAA0, ATA DISK drive
> kernel: hdb: IC35L040AVER07-0, ATA DISK drive
> kernel: hda: DMA disabled
> kernel: hdb: DMA disabled
> kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> kernel: hdc: CREATIVE DVD-ROM DVD6240E, ATAPI CD/DVD-ROM drive
> kernel: hdc: DMA disabled
> kernel: ide1 at 0x170-0x177,0x376 on irq 15
> kernel: hda: host protected area =1
> kernel: hda: setmax LBA 156301488, native  156250000
> kernel: hda: 156250000 sectors (80000 MB) w/2048KiB Cache,
> CHS=155009/16/63, UDMA(100) kernel:  /dev/ide/host0/bus0/target0/lun0: p1
> p2 p3 < p5 p6 p7 p8 > kernel: hdb: host protected area =1
> kernel: hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63,
> UDMA(100) kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4
> kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> kernel: NET4: Linux TCP/IP 1.0 for NET4.0
> kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
> kernel: TCP: Hash tables configured (established 32768 bind 65536)
> kernel: Linux IP multicast router 0.06 plus PIM-SM
> kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kernel: kjournald starting.  Commit interval 5 seconds
> kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
> kernel: EXT3-fs: mounted filesystem with ordered data mode.
> kernel: VFS: Mounted root (ext3 filesystem).
> kernel: Mounted devfs on /dev
> kernel: Freeing unused kernel memory: 120k freed
>
> .. the big warning:
> kernel: Warning: unable to open an initial console.
> .; but it continue;
> kernel: Adding 1052216k swap on /dev/hdb1.  Priority:-1 extents:1
> kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
> kernel: Linux video capture interface: v1.00
> ... bttv module init ...
> kernel: kjournald starting.  Commit interval 5 seconds
> kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
> kernel: EXT3-fs: mounted filesystem with ordered data mode.
> kernel: kjournald starting.  Commit interval 5 seconds
> kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
> kernel: EXT3-fs: mounted filesystem with ordered data mode.
> kernel: drivers/usb/core/usb.c: registered new driver usbfs
> kernel: drivers/usb/core/usb.c: registered new driver hub
> kernel: Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
> deprecated.
