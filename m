Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263345AbUJ2R7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUJ2R7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ2R7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:59:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:16856 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S263345AbUJ2RzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:55:18 -0400
Message-ID: <41828195.50707@osdl.org>
Date: Fri, 29 Oct 2004 10:44:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2
References: <20041029014930.21ed5b9a.akpm@osdl.org> <1099065862.711.34.camel@boxen>
In-Reply-To: <1099065862.711.34.camel@boxen>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
>>- More fiddling with the memory reclaim code.  We're making gradual progress
>>  here, so people who have had issues in the past with VM behaviour should
>>  keep an eye out for improvements or regressions.
> 
> Hi,
> 
> crashes with CONFIG_DEBUG_PAGEALLOC
> 
> Linux version 2.6.10-rc1-mm2 (alex@boxen) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #4 Fri Oct 29 15:31:26 UTC 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000000f00000 (usable)
>  BIOS-e820: 0000000000f00000 - 0000000001000000 (reserved)
>  BIOS-e820: 0000000001000000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> DMI 2.3 present.
> Built 1 zonelists
> No local APIC present or hardware disabled
> Initializing CPU#0
> Kernel command line: BOOT_IMAGE=x86_kernel root=/dev/hda9 netconsole=4444@192.168.1.10/eth0,7000@192.168.1.1/ nmi_watchdog=1 profile=1 elevator=cfq
> netconsole: local port 4444
> netconsole: local IP 192.168.1.10
> netconsole: interface eth0
> netconsole: remote port 7000
> netconsole: remote IP 192.168.1.1
> netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
> kernel profiling enabled (shift: 1)
> CPU 0 irqstacks, hard=c0349000 soft=c0348000
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 1400.232 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 477700k/524224k available (1479k kernel code, 44964k reserved, 457k data, 372k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) processor stepping 04
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> SCSI subsystem initialized
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
> PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
> Machine check exception polling timer started.
> Applying VIA southbridge workaround.
> PCI: Disabling Via external APIC routing
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> io scheduler noop registered
> io scheduler cfq registered
> loop: loaded (max 8 devices)
> PCI: Found IRQ 10 for device 0000:00:0b.0
> PCI: Sharing IRQ 10 with 0000:00:07.2
> PCI: Sharing IRQ 10 with 0000:00:07.3
> PCI: Sharing IRQ 10 with 0000:00:0f.1
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:0b.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.19
> e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
> e100: Copyright(c) 1999-2004 Intel Corporation
> netconsole: device eth0 not up yet, forcing it
> PCI: Found IRQ 10 for device 0000:00:0b.0
> PCI: Sharing IRQ 10 with 0000:00:07.2
> PCI: Sharing IRQ 10 with 0000:00:07.3
> PCI: Sharing IRQ 10 with 0000:00:0f.1
> netconsole: timeout waiting for carrier
> netconsole: network logging started
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
> hda: IC35L040AVER07-0, ATA DISK drive
> hdb: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: max request size: 128KiB
> hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
>  hda: hda1 hda2 hda4 < hda5 hda6 hda7 hda8 hda9 >
> PCI: Found IRQ 11 for device 0000:00:09.0
> PCI: Sharing IRQ 11 with 0000:00:0f.2
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec 2940 Pro Ultra SCSI adapter>
>         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
> 
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 372k freed
> ------------[ cut here ]------------
> kernel BUG at arch/i386/mm/pageattr.c:136!
> invalid operand: 0000 [#1]
> PREEMPT DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[<c011263d>]    Not tainted VLI
> EFLAGS: 00010056   (2.6.10-rc1-mm2)
> EIP is at __change_page_attr+0xcd/0x130
> eax: 00000000   ebx: 1fdc9163   ecx: c30a8f40   edx: 003fa000
> esi: c03fa724   edi: 00000163   ebp: dfc15c44   esp: dfc15c30
> ds: 007b   es: 007b   ss: 0068
> Process rcS (pid: 16, threadinfo=dfc15000 task=dfc14aa0)
> Stack: c30a1000 dfdc9000 c349c920 00000000 00000000 dfc15c64 c01126f9 00000292
>        00000163 00000001 00000001 c349c920 00000000 dfc15c70 c01127d6 c02a9fc4
>        dfc15cb4 c013391a 00000001 00000000 00000000 00000000 00000001 00000000
> Call Trace:
>  [<c0104c7a>] show_stack+0x7a/0x90
>  [<c0104df8>] show_registers+0x148/0x1b0
>  [<c0104ff0>] die+0xf0/0x180
>  [<c0105484>] do_invalid_op+0xe4/0xf0
>  [<c01048b1>] error_code+0x2d/0x38
>  [<c01126f9>] change_page_attr+0x59/0x70
>  [<c01127d6>] kernel_map_pages+0x16/0x80
>  [<c013391a>] __alloc_pages+0x22a/0x390
>  [<c012f5a8>] find_or_create_page+0x98/0xb0
>  [<c014d516>] grow_dev_page+0x26/0x120
>  [<c014d69a>] __getblk_slow+0x8a/0x120
>  [<c014da58>] __getblk+0x38/0x40
>  [<c018089b>] ext3_getblk+0x7b/0x230
>  [<c018431a>] ext3_find_entry+0x11a/0x3b0
>  [<c01847b6>] ext3_lookup+0x36/0xa0
>  [<c0157501>] real_lookup+0xb1/0xe0
>  [<c01577d3>] do_lookup+0x73/0x80
>  [<c0157ea7>] link_path_walk+0x6c7/0xd90
>  [<c015880e>] path_lookup+0x7e/0x140
>  [<c0158a1e>] __user_walk+0x2e/0x50
>  [<c0153d20>] vfs_stat+0x20/0x50
>  [<c0154356>] sys_stat64+0x16/0x30
>  [<c0103ea7>] syscall_call+0x7/0xb
> Code: f0 8b 45 f0 81 c1 00 00 00 40 c1 e8 16 81 e1 00 00 c0 ff 8d 04 82 8b 15 48 84 2a c0 80 ca 80 09 d1 8b 55 f0 e8 c5 fe ff ff eb a8 <0f> 0b 88 00 bc e5 27 c0 eb 8e 8b 45 f0 89 fa e8 cf fd ff ff 89
>  <6>note: rcS[16] exited with preempt_count 1

I'm seeing this also, coming thru scsi instead of ext3fs:

kernel BUG at arch/i386/mm/pageattr.c:136!
invalid operand: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0119df1>]    Not tainted VLI
EFLAGS: 00010046   (2.6.10-rc1-mm2)
EIP is at __change_page_attr+0x15f/0x16c
eax: ffffffff   ebx: 37fff163   ecx: c100c860   edx: c1000000
esi: c0643ffc   edi: 00000163   ebp: c19a1e10   esp: c19a1df4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c19a0000 task=c1976ae0)
Stack: f7fff000 00000001 00000286 f7fff000 c16fffe0 00000000 00000000 
c19a1e30
        c0119e46 c16fffe0 00000163 00000286 c0482480 c16fffe0 00000000 
c19a1e44
        c0119f66 c16fffe0 00000001 00000163 c19a1e98 c0145462 c16fffe0 
00000001
Call Trace:
  [<c0106de3>] show_stack+0xaf/0xb7
  [<c0106f68>] show_registers+0x15d/0x1d2
  [<c0107170>] die+0x106/0x18e
  [<c0107686>] do_invalid_op+0x108/0x10a
  [<c0106a39>] error_code+0x2d/0x38
  [<c0119e46>] change_page_attr+0x48/0x71
  [<c0119f66>] kernel_map_pages+0x31/0x5b
  [<c0145462>] __alloc_pages+0x174/0x45d
  [<c0145770>] __get_free_pages+0x25/0x3d
  [<c0148bfb>] kmem_getpages+0x20/0xce
  [<c014a293>] cache_grow+0xaf/0x160
  [<c014a989>] cache_alloc_refill+0x1c6/0x2be
  [<c014af6b>] kmem_cache_alloc+0x9c/0xa0
  [<c0143b52>] mempool_create+0xc7/0xe7
  [<c0587138>] scsi_init_queue+0x77/0xc5
  [<c0586fec>] init_scsi+0xc/0xe1
  [<c056a981>] do_initcalls+0x27/0xc0
  [<c010050c>] init+0x7d/0x19c
  [<c0104295>] kernel_thread_helper+0x5/0xb
Code: 00 00 c0 ff 09 d0 89 44 24 08 8b 45 f0 89 0c 24 89 44 24 04 e8 
5c fe ff f
  <0>Kernel panic - not syncing: Attempted to kill init!


-- 
~Randy
