Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVLSP0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVLSP0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVLSP0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:26:30 -0500
Received: from mail.gmx.de ([213.165.64.21]:6555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964775AbVLSP03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:26:29 -0500
X-Authenticated: #4399952
Date: Mon, 19 Dec 2005 16:26:24 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt2 build error
Message-ID: <20051219162624.6a7f63b5@mango.fruits.de>
In-Reply-To: <20051219154410.4942e826@mango.fruits.de>
References: <20051218210614.75f424eb@mango.fruits.de>
	<43A5DBF0.6030801@cybsft.com>
	<20051219154410.4942e826@mango.fruits.de>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005 15:44:10 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> Thanks, i found this:
> 
> http://lkml.org/lkml/mbox/2005/12/14/246
> 
> I'm not on X86_64 though. Plus i do have PREEMPT_RT enabled.
> 
> trying this though:
> 
> http://lkml.org/lkml/2005/12/13/184
> 
> Seems to build fine now.

But it doesn't run so well. Dmesg contains a BUG and an OOPS:

dmesg:

Linux version 2.6.15-rc5-rt2 (tapas@mango.fruits.de) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #2 PREEMPT Mon Dec 19 16:04:21 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000030000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
768MB LOWMEM available.
On node 0 totalpages: 196608
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 192512 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
Allocating PCI resources starting at 40000000 (gap: 30000000:cec00000)
Detected 1194.970 MHz processor.
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: BOOT_IMAGE=new2 ro root=341
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 65536 bytes)
Event source pit installed with caps set: 05
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 776212k/786432k available (1852k kernel code, 9832k reserved, 501k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2390.19 BogoMIPS (lpj=1195095)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS18 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
Boot video device is 0000:01:00.0
PCI: Using IRQ router SIS [1039/0018] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 4 for device 0000:00:02.1
PCI: Sharing IRQ 4 with 0000:00:0b.0
PCI: Sharing IRQ 4 with 0000:00:11.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: cdc00000-cfcfffff
  PREFETCH window: bd900000-cdafffff
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Time: tsc clocksource has been installed.
hda: ST340823A, ATA DISK drive
hdb: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TDK CDRW121032, ATAPI CD/DVD-ROM drive
hdd: ST340015A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 78165360 sectors (40020 MB)
	native  capacity is 78165361 sectors (40020 MB)
hda: Host Protected Area disabled.
hda: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3
hdd: max request size: 128KiB
hdd: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
hdd: cache flushes supported
 hdd: hdd1
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 9, 2359296 bytes)
input: AT Translated Set 2 keyboard as /class/input/input1
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
kjournald starting.  Commit interval 5 seconds
logips2pp: Detected unknown logitech mouse model 95
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input2
EXT3 FS on hdb1, internal journal
PCI: Found IRQ 4 for device 0000:00:11.0
PCI: Sharing IRQ 4 with 0000:00:02.1
PCI: Sharing IRQ 4 with 0000:00:0b.0
gameport: CS46xx Gameport is pci0000:00:11.0/gameport0, speed 1924kHz
sis900.c: v1.08.08 Jan. 22 2005
PCI: Found IRQ 3 for device 0000:00:03.0
0000:00:03.0: Realtek RTL8201 PHY transceiver found at address 1.
0000:00:03.0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 3, 00:d0:09:e9:c1:0f.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PCI: Found IRQ 4 for device 0000:00:0b.0
PCI: Sharing IRQ 4 with 0000:00:02.1
PCI: Sharing IRQ 4 with 0000:00:11.0
ip_conntrack version 2.4 (6144 buckets, 49152 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 131064k swap on /swapfile.  Priority:-1 extents:39 across:1786416k
eth0: Media Link On 100mbps full-duplex 
Linux agpgart interface v0.101 (c) Dave Jones
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c02067ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: iptable_nat ipt_addrtype ipt_state iptable_filter agpgart snd_intel8x0 ipt_MASQUERADE ip_nat ip_tables ip_conntrack snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart bsd_comp ppp_deflate zlib_deflate ppp_async ppp_generic slhc crc_ccitt sis900 mii crc32 snd_cs46xx gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c02067ab>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15-rc5-rt2) 
EIP is at __rb_erase_color+0x8b/0x1b0
eax: 00000000   ebx: ecd07f58   ecx: 00000000   edx: 00000000
esi: c030d65c   edi: 00000292   ebp: 00000000   esp: ed575eb4
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process rt_watchdog (pid: 839, threadinfo=ed574000 task=edb984e0 stack_left=7808 worst_left=-1)
Stack: 00000005 ed575f58 ecd07f58 ed575f58 c02069a6 00000000 ecd07f58 c030d65c 
       00000001 ed575f58 00000001 00000292 ed575f50 c012dae5 ed575f58 c030d65c 
       ed575f58 ed575f58 ed575f58 c012db30 ed575f58 00000000 c02cca52 ed575f58 
Call Trace:
 [<c02069a6>] rb_erase+0xd6/0x140 (20)
 [<c012dae5>] hrtimer_try_to_cancel+0x45/0x80 (36)
 [<c012db30>] hrtimer_cancel+0x10/0x20 (24)
 [<c02cca52>] schedule_hrtimer+0x52/0xc0 (12)
 [<c012ddae>] hrtimer_nanosleep+0x6e/0x170 (44)
 [<c012299f>] do_sigaction+0x10f/0x240 (16)
 [<c012df19>] sys_nanosleep+0x69/0x70 (80)
 [<c0102d21>] syscall_call+0x7/0xb (32)
Code: 74 26 8b 42 04 85 c0 75 aa c7 42 04 01 00 00 00 c7 43 04 00 00 00 00 89 74 24 04 89 1c 24 e8 2d fe ff ff 8b 53 0c eb 8b 8b 53 08 <8b> 42 04 85 c0 74 61 8b 42 0c 85 c0 74 0a 83 78 04 01 0f 85 c5 
 <6>note: rt_watchdog[839] exited with preempt_count 1
BUG: scheduling while atomic: rt_watchdog/0x00000001/839
caller is do_exit+0x280/0x4d0
 [<c02cbba2>] __schedule+0x512/0x6b0 (8)
 [<c01171f0>] do_exit+0x280/0x4d0 (8)
 [<c0116a29>] exit_notify+0x479/0x9c0 (12)
 [<c01171f0>] do_exit+0x280/0x4d0 (52)
 [<c0103766>] die+0x186/0x190 (40)
 [<c02ce384>] do_page_fault+0x224/0x5f4 (48)
 [<c02ce160>] do_page_fault+0x0/0x5f4 (64)
 [<c0102f53>] error_code+0x4f/0x54 (8)
 [<c02067ab>] __rb_erase_color+0x8b/0x1b0 (44)
 [<c02069a6>] rb_erase+0xd6/0x140 (28)
 [<c012dae5>] hrtimer_try_to_cancel+0x45/0x80 (36)
 [<c012db30>] hrtimer_cancel+0x10/0x20 (24)
 [<c02cca52>] schedule_hrtimer+0x52/0xc0 (12)
 [<c012ddae>] hrtimer_nanosleep+0x6e/0x170 (44)
 [<c012299f>] do_sigaction+0x10f/0x240 (16)
 [<c012df19>] sys_nanosleep+0x69/0x70 (80)
 [<c0102d21>] syscall_call+0x7/0xb (32)
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c02067ab
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
Modules linked in: iptable_nat ipt_addrtype ipt_state iptable_filter agpgart snd_intel8x0 ipt_MASQUERADE ip_nat ip_tables ip_conntrack snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart bsd_comp ppp_deflate zlib_deflate ppp_async ppp_generic slhc crc_ccitt sis900 mii crc32 snd_cs46xx gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
CPU:    0
EIP:    0060:[<c02067ab>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15-rc5-rt2) 
EIP is at __rb_erase_color+0x8b/0x1b0
eax: 00000000   ebx: edb75f58   ecx: 00000000   edx: 00000000
esi: c030d65c   edi: 00000292   ebp: 00000000   esp: ecd07eb4
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process rt_watchdog (pid: 840, threadinfo=ecd06000 task=ed4bb670 stack_left=7808 worst_left=-1)
Stack: 00000005 ecd07f58 edb75f58 ecd07f58 c02069a6 00000000 edb75f58 c030d65c 
       00000001 ecd07f58 00000001 00000292 ecd07f50 c012dae5 ecd07f58 c030d65c 
       ecd07f58 ecd07f58 ecd07f58 c012db30 ecd07f58 00000000 c02cca52 ecd07f58 
Call Trace:
 [<c02069a6>] rb_erase+0xd6/0x140 (20)
 [<c012dae5>] hrtimer_try_to_cancel+0x45/0x80 (36)
 [<c012db30>] hrtimer_cancel+0x10/0x20 (24)
 [<c02cca52>] schedule_hrtimer+0x52/0xc0 (12)
 [<c012ddae>] hrtimer_nanosleep+0x6e/0x170 (44)
 [<c012df19>] sys_nanosleep+0x69/0x70 (96)
 [<c0102d21>] syscall_call+0x7/0xb (32)
Code: 74 26 8b 42 04 85 c0 75 aa c7 42 04 01 00 00 00 c7 43 04 00 00 00 00 89 74 24 04 89 1c 24 e8 2d fe ff ff 8b 53 0c eb 8b 8b 53 08 <8b> 42 04 85 c0 74 61 8b 42 0c 85 c0 74 0a 83 78 04 01 0f 85 c5 
 <6>note: rt_watchdog[840] exited with preempt_count 1
BUG: scheduling while atomic: rt_watchdog/0x00000001/840
caller is do_exit+0x280/0x4d0
 [<c02cbba2>] __schedule+0x512/0x6b0 (8)
 [<c01171f0>] do_exit+0x280/0x4d0 (8)
 [<c0116c39>] exit_notify+0x689/0x9c0 (12)
 [<c0218514>] disassociate_ctty+0x124/0x1e0 (24)
 [<c01171f0>] do_exit+0x280/0x4d0 (28)
 [<c0103766>] die+0x186/0x190 (40)
 [<c02ce384>] do_page_fault+0x224/0x5f4 (48)
 [<c02ce160>] do_page_fault+0x0/0x5f4 (64)
 [<c0102f53>] error_code+0x4f/0x54 (8)
 [<c02067ab>] __rb_erase_color+0x8b/0x1b0 (44)
 [<c02069a6>] rb_erase+0xd6/0x140 (28)
 [<c012dae5>] hrtimer_try_to_cancel+0x45/0x80 (36)
 [<c012db30>] hrtimer_cancel+0x10/0x20 (24)
 [<c02cca52>] schedule_hrtimer+0x52/0xc0 (12)
 [<c012ddae>] hrtimer_nanosleep+0x6e/0x170 (44)
 [<c012df19>] sys_nanosleep+0x69/0x70 (96)
 [<c0102d21>] syscall_call+0x7/0xb (32)


-- 
Palimm Palimm!
http://tapas.affenbande.org
