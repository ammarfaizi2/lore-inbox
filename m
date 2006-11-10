Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946498AbWKJLRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946498AbWKJLRq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946504AbWKJLRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:17:46 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:6532 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1946498AbWKJLRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:17:44 -0500
Message-ID: <45545FB4.20208@gmail.com>
Date: Fri, 10 Nov 2006 12:17:08 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg.Chandler@wellsfargo.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fw: kernel oops with extended serial stuff turned on...
References: <20061109205706.9d3983e6.akpm@osdl.org>
In-Reply-To: <20061109205706.9d3983e6.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Here's one to keep you entertained.  I was able to reproduce this (config
> attached) but I can't think of a quick way of working out which driver has
> gone and registered ttys for not-present devices.
> 
> 
> Begin forwarded message:
> 
> Date: Wed, 18 Oct 2006 12:51:58 -0500
> From: <Greg.Chandler@wellsfargo.com>
> To: <linux-kernel@vger.kernel.org>
> Subject: kernel oops with extended serial stuff turned on...
> 
> 
> 
> Or maybe it's not exactly an oops.....
> 
> Unfortunately I do not have the .config for this....
> I do know that I had EVERY serial option turned on since I was trying to
> find a specific device....
> See below:
> 
> 
> Linux version 2.6.18.1 (root@blackhole) (gcc version 3.3.6) #3 Tue Oct
> 17 22:02:19 PDT 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
>  BIOS-e820: 000000000009b800 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
>  BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
>  BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
>  BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
>  BIOS-e820: 00000000ffff8000 - 0000000100000000 (reserved)
> 240MB LOWMEM available.
> On node 0 totalpages: 61440
>   DMA zone: 4096 pages, LIFO batch:0
>   Normal zone: 57344 pages, LIFO batch:15
> DMI 2.3 present.
> ACPI: RSDP (v000 HTCLTD                                ) @ 0x000f80f0
> ACPI: RSDT (v001 HTCLTD HTC20F1  0x06040005  LTP 0x00000000) @
> 0x0eefc451
> ACPI: FADT (v001 HTCLTD HTC20F1  0x06040005 PTL  0x00000001) @
> 0x0eefef64
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040005  LTP 0x00000001) @
> 0x0eefefd8
> ACPI: DSDT (v001 HTCLTD HTC20F1  0x06040005 MSFT 0x0100000d) @
> 0x00000000
> ACPI: PM-Timer IO Port: 0x8008
> Allocating PCI resources starting at 10000000 (gap: 0f000000:f0ff8000)
> Detected 398.205 MHz processor.
> Built 1 zonelists.  Total pages: 61440
> Kernel command line: auto BOOT_IMAGE=cris-2.6.18.1-1 ro root=301
> log_buf_len=4M
> log_buf_len: 4194304
> No local APIC present or hardware disabled
> mapped APIC to ffffd000 (015e1000)
> Initializing CPU#0
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 233332k/245760k available (3179k kernel code, 11856k reserved,
> 1649k data, 248k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode...
> Ok.
> Calibrating delay using timer specific routine.. 803.09 BogoMIPS
> (lpj=4015461)
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 0084893f 0081813f 00000000 00000000
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 0084893f 0081813f 0000000e 00000000
> 00000000 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
> CPU: L2 Cache: 256K (128 bytes/line)
> CPU: Processor revision 1.3.1.3, 400 MHz
> CPU: Code Morphing Software revision 4.2.7-8-278
> CPU: 20011004 02:04 official release 4.2.7#7
> CPU serial number disabled.
> CPU: After all inits, caps: 0080893f 0081813f 0000000e 00000000 00000000
> 00000000 00000000
> Compat vDSO mapped to ffffe000.
> CPU: Transmeta(tm) Crusoe(tm) Processor TM5400 stepping 03
> Checking 'hlt' instruction... OK.
> ACPI: Core revision 20060707
> ACPI: setting ELCR to 0200 (from 08a0)
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: PCI BIOS revision 2.10 entry at 0xfd8b9, last bus=0
> PCI: Using configuration type 1
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> Boot video device is 0000:00:06.0
> PCI quirk: region 8000-803f claimed by ali7101 ACPI
> PCI quirk: region 8040-805f claimed by ali7101 SMB
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 5 6 7 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK2] (IRQs 5 6 *7 11)
> ACPI: PCI Interrupt Link [LNK3] (IRQs *5 6 7 11)
> ACPI: PCI Interrupt Link [LNK4] (IRQs 5 6 7 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK5] (IRQs 5 6 7 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK6] (IRQs 5 6 7 *11)
> ACPI: PCI Interrupt Link [LNK7] (IRQs 5 6 7 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK8] (IRQs 5 6 7 *11)
> ACPI: PCI Interrupt Link [LNKU] (IRQs 5 6 7 *11)
> ACPI: Power Resource [PUSB] (off)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 10 devices
> Generic PHY: Registered new driver
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
> report
> pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:07: ioport range 0x40b-0x40b has been reserved
> pnp: 00:07: ioport range 0x480-0x48f has been reserved
> pnp: 00:07: ioport range 0x4d6-0x4d6 has been reserved
> pnp: 00:07: ioport range 0x8000-0x803f could not be reserved
> PCI: Ignore bogus resource 6 [0:0] of 0000:00:06.0
> PCI: Bus 1, cardbus bridge: 0000:00:05.0
>   IO window: 00001800-000018ff
>   IO window: 00001c00-00001cff
>   PREFETCH window: 10000000-11ffffff
>   MEM window: 12000000-13ffffff
> PCI: Bus 5, cardbus bridge: 0000:00:05.1
>   IO window: 00002000-000020ff
>   IO window: 00002400-000024ff
>   PREFETCH window: 14000000-15ffffff
>   MEM window: 16000000-17ffffff
> PCI: Bus 9, cardbus bridge: 0000:00:0b.0
>   IO window: 00002800-000028ff
>   IO window: 00002c00-00002cff
>   PREFETCH window: 18000000-19ffffff
>   MEM window: 1a000000-1bffffff
> PCI: Enabling device 0000:00:05.0 (0000 -> 0003)
> ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 5
> PCI: setting IRQ 5 as level-triggered
> ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNK3] -> GSI 5 (level, low)
> -> IRQ 5
> PCI: Setting latency timer of device 0000:00:05.0 to 64
> ACPI: PCI Interrupt 0000:00:05.1[A] -> Link [LNK3] -> GSI 5 (level, low)
> -> IRQ 5
> PCI: Setting latency timer of device 0000:00:05.1 to 64
> PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered
> ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNK6] -> GSI 11 (level,
> low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:0b.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 8192 bind 4096)
> TCP reno registered
> Simple Boot Flag at 0x36 set to 0x1
> Total HugeTLB memory allocated, 0
> NTFS driver 2.1.27 [Flags: R/W].
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler cfq registered (default)
> Activating ISA DMA hang workarounds.
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
> cpcihp_generic: not configured, disabling.
> vesafb: framebuffer at 0xfd000000, mapped to 0xcf880000, using 937k,
> total 2048k
> vesafb: mode is 800x600x8, linelength=800, pages=3
> vesafb: protected mode interface info at c9cf:000e
> vesafb: pmi: set display start = c00c9d33, set palette = c00c9d87
> vesafb: pmi: ports = 
> vesafb: scrolling: redraw
> vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
> Console: switching to colour frame buffer device 100x37
> fb0: VESA VGA frame buffer device
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> Using specific hotkey driver
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> ACPI: Processor [CPU0] (supports 8 throttling states)
> RocketPort device driver module, version 2.09, 12-June-2003
> No rocketport ports found; unloading driver.
> Cyclades driver 2.3.2.20 2004/02/25 18:14:16
>         built Oct 15 2006 02:35:46
> Stallion Multiport Serial Driver: version 5.6.0
> Stallion Intelligent Multiport Serial Driver: version 5.6.0
> STALLION: failed to register serial memory device
> kobject_add failed for staliomem with -EEXIST, don't try to register
> things with the same name in the same directory.
>  [<c01f4fe2>] kobject_add+0xd2/0xe0
>  [<c01f533f>] subsystem_register+0xf/0x20
>  [<c02a47b3>] class_register+0x63/0x90
>  [<c02a4870>] class_create+0x40/0x60
>  [<c05d0a29>] stli_init+0x99/0x180<linux-kernel@vger.kernel.org>
>  [<c05d08c5>] istallion_module_init+0x5/0x10
>  [<c05ba723>] do_initcalls+0x53/0xf0
>  [<c01331a2>] register_irq_proc+0x52/0x70
>  [<c0170000>] bm_status_read+0x50/0xd0
>  [<c0100290>] init+0x0/0x120
>  [<c01002c2>] init+0x32/0x120
>  [<c010132d>] kernel_thread_helper+0x5/0x18
> STALLION: failed to register serial driver

Alan wrote:
> E is assigned to stallion so both seem to share it

It's back again here, any solution, Alan?

[stallion now tty_register_device dynamically (and istallion will), this should
never happen in -mm unless you have both cards]

> DIGI epca driver version 1.3.0.1-LK2.6 loaded.
> sx: Specialix IO8+ driver v1.11, (c) R.E.Wolff 1997/1998.
> sx: derived from work (c) D.Gorodchanin 1994-1996.
> sx: DTR/RTS pin is RTS when CRTSCTS is on.
> sx0: specialix IO8+ Board at 0x100 not found.
> sx1: specialix IO8+ Board at 0x180 not found.
> sx2: specialix IO8+ Board at 0x250 not found.
> sx3: specialix IO8+ Board at 0x260 not found.
> sx: No specialix IO8+ boards detected.
> MOXA Intellio family driver version 5.1k
> Tty devices major number = 172
> MOXA Smartio/Industio family driver version 1.8
> Computone IntelliPort Plus multiport driver version 1.2.14
> rc: SDL RISCom/8 card driver v1.1, (c) D.Gorodchanin 1994-1996.
> rc0: RISCom/8 Board at 0x220 not found.
> rc1: RISCom/8 Board at 0x240 not found.
> rc2: RISCom/8 Board at 0x250 not found.
> rc3: RISCom/8 Board at 0x260 not found.
> rc: No RISCom/8 boards detected.
> kobject_add failed for ttyM0 with -EEXIST, don't try to register things
> with the same name in the same directory.
>  [<c01f4fe2>] kobject_add+0xd2/0xe0
>  [<c02a4e8f>] class_device_add+0x9f/0x2a0
>  [<c02a5117>] class_device_create+0x77/0x90
>  [<c02423ff>] tty_register_device+0x5f/0x70
>  [<c02a5c9c>] kobj_map+0xec/0x100
>  [<c015493d>] cdev_add+0x1d/0x30
>  [<c02426ea>] tty_register_driver+0x19a/0x1b0
>  [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
>  [<c02738ae>] isicom_setup+0x13e/0x1d0
>  [<c05d1b62>] riscom8_init+0x222/0x230
>  [<c05ba723>] do_initcalls+0x53/0xf0
>  [<c01331a2>] register_irq_proc+0x52/0x70
>  [<c0170000>] bm_status_read+0x50/0xd0
>  [<c0100290>] init+0x0/0x120
>  [<c01002c2>] init+0x32/0x120
>  [<c010132d>] kernel_thread_helper+0x5/0x18

[snip (here was ttyM1 through ttyM31)]

> kobject_add failed for ttyM32 with -EEXIST, don't try to register things
> with the same name in the same directory.
>  [<c01f4fe2>] kobject_add+0xd2/0xe0
>  [<c02a4e8f>] class_device_add+0x9f/0x2a0
>  [<c02a5117>] class_device_create+0x77/0x90
>  [<c02423ff>] tty_register_device+0x5f/0x70
>  [<c02a5c9c>] kobj_map+0xec/0x100
>  [<c015493d>] cdev_add+0x1d/0x30
>  [<c02426ea>] tty_register_driver+0x19a/0x1b0
>  [<c0272e4c>] isicom_register_tty_driver+0xac/0xd0
>  [<c02738ae>] isicom_setup+0x13e/0x1d0
>  [<c05d1b62>] riscom8_init+0x222/0x230
>  [<c05ba723>] do_initcalls+0x53/0xf0
>  [<c01331a2>] register_irq_proc+0x52/0x70
>  [<c0170000>] bm_status_read+0x50/0xd0
>  [<c0100290>] init+0x0/0x120
>  [<c01002c2>] init+0x32/0x120
>  [<c010132d>] kernel_thread_helper+0x5/0x18

This is fixed in -mm (mxser now have ttyMX).

[snip -- flat rest of the dmesg]

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
