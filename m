Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbUA1MNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 07:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265942AbUA1MNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 07:13:25 -0500
Received: from chico.rediris.es ([130.206.1.3]:34293 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S265935AbUA1MNP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 07:13:15 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm1 (Breakage?)
Date: Wed, 28 Jan 2004 13:13:03 +0100
User-Agent: KMail/1.5.4
References: <20040127233402.6f5d3497.akpm@osdl.org>
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401281313.03790.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Miércoles, 28 de Enero de 2004 08:34, Andrew Morton escribió:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6
>.2-rc2-mm1/
>
>
> - From now on, -mm kernels will contain the latest contents of:
>
> 	Linus's tree:		linus.patch
> 	The ACPI tree:		acpi.patch
> 	Vojtech's tree:		input.patch
> 	Jeff's tree:		netdev.patch
> 	The ALSA tree:		alsa.patch
>
>   If anyone has any more external trees which need similar treatment,
>   please let me know.
>
> - Various fixes.  Nothing stands out.

	Hello, Andrew, I've switched from 2.6.2-rc1-mm1 to 2.6.2-rc1-mm1, and I've 
encountered this:

- -------------
[...]
SiI3112 Serial ATA: 100%% native mode on irq 18
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: ST3120026AS, ATA DISK drive
ide2 at 0xe0807080-0xe0807087,0xe080708a on irq 18
hdg: ST3120026AS, ATA DISK drive
ide3 at 0xe08070c0-0xe08070c7,0xe08070ca on irq 18
hda: max request size: 128KiB
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

hda: 40011300 sectors (20485 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(66)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
hde: max request size: 64KiB
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63
 hde: hde1
hdg: max request size: 64KiB
hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63
 hdg: hdg1
hdb: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: irq 23, pci mem e0824000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

uhci_hcd 0000:00:1d.0: irq 16, io base 0000b800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: irq 19, io base 0000b000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

uhci_hcd 0000:00:1d.2: irq 18, io base 0000b400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 1.0.2 (Tue Jan 27 10:28:52 
2004 UTC).
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

intel8x0_measure_ac97_clock: measured 49407 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xea001000, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
GRE over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
BIOS EDD facility v0.12 2004-Jan-26, 3 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md:  adding hde1 ...
md: created md0
md: bind<hde1>
md: bind<hdg1>
md: running: <hdg1><hde1>
md0: setting max_sectors to 32, segment boundary to 8191
raid0: looking at hdg1
raid0:   comparing hdg1(117218176) with hdg1(117218176)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hde1
raid0:   comparing hde1(117218176) with hdg1(117218176)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 234436352 blocks.
raid0 : conf->hash_spacing is 234436352 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: ... autorun DONE.
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 336k freed
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

blk: queue dfdaaa00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue dfd8ea00, I/O limit 4095Mb (mask 0xffffffff)
Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [interruptible_sleep_on+209/214] interruptible_sleep_on+0xd1/0xd6
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pagebuf_daemon+533/560] pagebuf_daemon+0x215/0x230
 [pagebuf_daemon_wakeup+0/42] pagebuf_daemon_wakeup+0x0/0x2a
 [pagebuf_daemon+0/560] pagebuf_daemon+0x0/0x230
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

blk: queue dfd8e200, I/O limit 4095Mb (mask 0xffffffff)
Adding 499928k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
[...]
- -------------

	And then zillions of:

apache2 0 waking apache2: 507 547
Badness in try_to_wake_up at kernel/sched.c:722
Call Trace:
 [<c0118e09>] try_to_wake_up+0x91/0x1af
 [<c036ead8>] common_interrupt+0x18/0x20
 [<c0119cc7>] __wake_up_common+0x31/0x50
 [<c0119d0a>] __wake_up+0x24/0x2d
 [<c012d046>] wake_futex+0x30/0x5b
 [<c012d119>] futex_wake+0xa8/0xae
 [<c0118c5e>] recalc_task_prio+0x90/0x1aa
 [<c012d7c8>] do_futex+0x7e/0x80
 [<c012d8d6>] sys_futex+0x10c/0x124
 [<c036e116>] sysenter_past_esp+0x43/0x65


	Usual machine... :-) P4, XFS over sw RAID0, and Apache2
in threaded model.

	I've reverted to 2.6.2-rc1-mm1.

	Anything to do?

	Regards,


		Ender.
- -- 
And need I remind you that I am naked in the snow...? I
 can't feel any of my extremities, and I mean *any* of them...
		-- Skinner (The League of Extraordinary Gentlemen)
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAF6dPWs/EhA1iABsRAhElAKC1Wk9p4RFer+066YkEm5NoxDfT/gCgq28D
kF0Zu2Wh1zl+5tmrsIaM00k=
=LkCy
-----END PGP SIGNATURE-----

