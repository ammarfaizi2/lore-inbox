Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUENQyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUENQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUENQyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:54:08 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:33414 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261723AbUENQxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:53:19 -0400
Date: Fri, 14 May 2004 09:53:11 -0700
From: Andy Isaacson <adi@bitmover.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Steven Cole <scole@lanl.gov>, support@bitmover.com,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040514165311.GC6908@bitmover.com>
References: <200405122234.06902.elenstev@mesatop.com> <15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040513183316.GE17965@bitmover.com> <200405131723.15752.elenstev@mesatop.com> <6616858C-A5AF-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040514144617.GE20197@work.bitmover.com> <200405122234.06902.elenstev@mesatop.com> <15594C37-A509-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040513183316.GE17965@bitmover.com> <200405131723.15752.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405132232.01484.elenstev@mesatop.com> <20040514144617.GE20197@work.bitmover.com> <200405131723.15752.elenstev@mesatop.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the enormous quote, but I wanted to get the lspci and
dmesg in here, in case someone else has some insight.

On Thu, May 13, 2004 at 05:23:15PM -0600, Steven Cole wrote:
> [steven@spc steven]$ lspcidrake
> intel-agp       : Intel Corporation|440BX/ZX - 82443BX/ZX Host bridge [BRIDGE_HOST]
> unknown         : Intel Corporation|440BX/ZX - 82443BX/ZX AGP bridge [BRIDGE_PCI]
> unknown         : Intel Corporation|82371AB PIIX4 ISA [BRIDGE_ISA]
> unknown         : Intel Corporation|82371AB PIIX4 IDE [STORAGE_IDE]
> usb-uhci        : Intel Corporation|82371AB PIIX4 USB [SERIAL_USB]
> sonypi          : Intel Corporation|82371AB PIIX4 ACPI - Bus Master IDE Controller [BRIDGE_OTHER]
> es1371          : Creative Labs|Sound Blaster AudioPCI64V/AudioPCI128 [MULTIMEDIA_AUDIO]
> 3c59x           : 3Com Corporation|3c905B 100BaseTX [Cyclone] [NETWORK_ETHERNET]
> unknown         : Promise Technology, Inc.|20262 (Ultra66) [STORAGE_OTHER]
> Card:RIVA TNT   : nVidia Corporation|Riva TNT 128 [DISPLAY_VGA]
[snip]
> Linux version 2.6.6 (steven@spc.mesatop.com) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #105 Sun May 9 22:00:07 MDT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
>  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000040fd800 (usable)
>  BIOS-e820: 00000000040fd800 - 00000000040ff800 (ACPI data)
>  BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
>  BIOS-e820: 00000000040ffc00 - 0000000018000000 (usable)
>  BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
> 384MB LOWMEM available.
> On node 0 totalpages: 98304
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 94208 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.1 present.
> ACPI disabled because your bios is from 1999 and too old
> You can enable it with acpi=force
> Built 1 zonelists
> Kernel command line: auto BOOT_IMAGE=2.6-bk ro root=306 devfs=nomount acpi=ht resume=/dev/hda10 splash=silent
> Initializing CPU#0
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Detected 448.795 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Memory: 386260k/393216k available (1999k kernel code, 6184k reserved, 548k data, 316k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 886.78 BogoMIPS
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
> CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
> CPU: Intel Pentium III (Katmai) stepping 02
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd983, last bus=1
> PCI: Using configuration type 1
> Linux Plug and Play Support v0.97 (c) Adam Belay
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> NTFS driver 2.1.8 [Flags: R/O].
> Limiting direct PCI/PCI transfers.
> isapnp: Scanning for PnP cards...
> isapnp: Card 'U.S. Robotics 56K FAX INT'
> isapnp: 1 Plug & Play card detected total
> lp: driver loaded but no devices found
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> pnp: Device 00:01.00 activated.
> ttyS1 at I/O 0x2f8 (irq = 10) is a 16550A
> parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
> parport0: irq 7 detected
> lp0: using parport0 (polling).
> Using anticipatory io scheduler
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> loop: loaded (max 8 devices)
> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20262: IDE controller at PCI slot 0000:00:0f.0
> PCI: Found IRQ 5 for device 0000:00:0f.0
> PDC20262: chipset revision 1
> PDC20262: 100% native mode on irq 5
> PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
>     ide0: BM-DMA at 0x10c0-0x10c7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0x10c8-0x10cf, BIOS settings: hdc:DMA, hdd:pio
> hda: Maxtor 5T040H4, ATA DISK drive
> hdb: ST317221A, ATA DISK drive
> ide0 at 0x1440-0x1447,0x1436 on irq 5
> hda: max request size: 128KiB
> hda: Host Protected Area detected.
>         current capacity is 78125000 sectors (40000 MB)
>         native  capacity is 80043264 sectors (40982 MB)
> hda: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=65535/16/63
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
> hdb: max request size: 128KiB
> hdb: 33683328 sectors (17245 MB) w/512KiB Cache, CHS=33416/16/63
>  /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 p6 p7 p8 p9 >
> ide-floppy driver 0.99.newide
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
> PCI: Found IRQ 11 for device 0000:00:0c.0
> PCI: Sharing IRQ 11 with 0000:00:0e.0
> PCI: Sharing IRQ 11 with 0000:01:00.0
> ALSA device list:
>   #0: Ensoniq AudioPCI ENS1371 at 0x1080, irq 11
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 316k freed
> EXT3 FS on hda6, internal journal
> Adding 818960k swap on /dev/hda10.  Priority:-1 extents:1
> Adding 248968k swap on /dev/hdb5.  Priority:-2 extents:1
> found reiserfs format "3.6" with standard journal
> reiserfs: using ordered data mode
> Reiserfs journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> reiserfs: checking transaction log (hda9) for (hda9)
> Using r5 hash to sort names
> NTFS volume version 3.1.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda7, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda8, internal journal
[snip]
> [steven@spc testing-2.6]$ bk changes -r+ -nd:KEY:
> geert@linux-m68k.org[torvalds]|ChangeSet|20040511145430|25087

Here's "grep = .config":

> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_CLEAN_COMPILE=y
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSCTL=y
> CONFIG_LOG_BUF_SHIFT=14
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_X86_PC=y
> CONFIG_MPENTIUMIII=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_PREEMPT=y
> CONFIG_X86_TSC=y
> CONFIG_NOHIGHMEM=y
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_REGPARM=y
> CONFIG_ACPI_BOOT=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PARPORT_PC_CML1=y
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PNP=y
> CONFIG_ISAPNP=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_LBD=y
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDEFLOPPY=y
> CONFIG_IDE_GENERIC=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_OFFBOARD=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_PDC202XX_OLD=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_NET=y
> CONFIG_PACKET=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_SYN_COOKIES=y
> CONFIG_NETDEVICES=y
> CONFIG_PPP=y
> CONFIG_PPP_ASYNC=y
> CONFIG_PPP_DEFLATE=y
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_CORE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_PRINTER=y
> CONFIG_DRM=y
> CONFIG_RAW_DRIVER=y
> CONFIG_MAX_RAW_DEVS=256
> CONFIG_FB=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_SOUND=y
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_RAWMIDI=y
> CONFIG_SND_SEQUENCER=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_AC97_CODEC=y
> CONFIG_SND_ENS1371=y
> CONFIG_USB=y
> CONFIG_USB_DEVICEFS=y
> CONFIG_EXT2_FS=y
> CONFIG_EXT3_FS=y
> CONFIG_JBD=y
> CONFIG_REISERFS_FS=y
> CONFIG_QUOTA=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_ISO9660_FS=y
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_NTFS_FS=y
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> CONFIG_DEVFS_FS=y
> CONFIG_RAMFS=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_EARLY_PRINTK=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_X86_STD_RESOURCES=y
> CONFIG_PC=y


So, in the oddball config department, you've got a ISAPnP modem over
which you're running PPP; CONFIG_PREEMPT is on.

That corruption size really does make me think of network packets, so
I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
link?  "ifconfig ppp0" or something like that.

Can you try doing something like

#!/bin/sh
x=0
while true; do
	bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
	(cd foo; bk pull -q)
	rm -rf foo
	x=`expr $x + 1`
	echo -n "$x "
done

(I just pulled that key at random out of the kernel repository; there's
nothing special about it except that it's far enough back for the revert
and pull to be very involved operations.)

That ought to do a nice test of the CPU, memory, disk, and kernel sans
PPP.  If that loop runs for, say, 10 iterations without errors, keep it
running and try doing some non-BK network IO for a half hour (or two
iterations of the clone/pull loop, whichever is longer) and see if it
fails.  You might want to increase the runtimes, say, overnight and two
hours of network activity, if you don't see any failures.

This test is designed to check the theory that in your config, PPP
somehow corrupts random buffer cache pages.

On Fri, May 14, 2004 at 07:46:17AM -0700, Larry McVoy wrote:
> My instinct is that this is a file system or VM problem.  Here's why: BK
> wraps its data in multiple integrity checks.  When you are doing a pull,
> the data that is sent across the wire is wrapped both at the individual
> diff level (each delta has a check) as well as a CRC around the whole
> set of diffs and metadata sent.  Since Steven is pulling (I believe,
> please confirm) from bkbits.net, we know that the data being generated
> is fine - if it wasn't the whole world would be on our case.
> 
> On the receiving side BK splats the entire set of diffs and metadata 
> down on disk, checking the CRC, and it doesn't proceed to the apply patch
> part until the entire thing is on disk and checked.  Then when the patches
> are applied, each per patch checksum is verified (except, as we recently
> found out, in the case of the changeset file, we added some fast path
> optimization for that and dropped the check on the floor.  Oops).
> 
> I don't think pppd can be part of the problem because of the way BK is
> designed - you shouldn't have gotten to the place you did if the data 
> was corrupted in transit.

I agree, I don't see how it could be an in-flight corruption.

> If any of pppd/kernel stuff is corrupting in memory pages, that's a
> different matter entirely, that could cause these problems.

This is my current top suspect.  Well, that, or rotted hardware with the
most bizarre symptoms I've ever seen.  A 16550, or ISA DMA controller,
that just happens to stomp on buffer cache pages?

> The fact that Steven is the only guy seeing this really makes me 
> suspicious that it is something with his kernel.  I don't think this
> is a memory error problem, those never look like this, they look like
> a few bits being flipped.  Blocks of nulls are always file/vm system.

Yeah, I'm sure it's some function of his hardware and config.  But
really, how many people do you suppose are running 2.6 with PPP and
PREEMPT?  And how many of them would notice a few pages per day of
partial buffer cache trashing?  I had a machine with one byte of memory
that gave you "x" 50% of the time, and "x & 0xdf" the other 50% of the
time; it took several months and a fairly serious filesystem blowup
before I noticed enough problems to go run memtest86.

-andy
