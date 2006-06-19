Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWFSTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWFSTsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWFSTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:48:19 -0400
Received: from main.gmane.org ([80.91.229.2]:702 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964867AbWFSTsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:48:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marcus Furlong <furlongm@hotmail.com>
Subject: Re: PATA driver patch for 2.6.17
Date: Mon, 19 Jun 2006 20:46:40 +0100
Message-ID: <e76uv1$g1s$1@sea.gmane.org>
References: <1150740947.2871.42.camel@localhost.localdomain>
Reply-To: furlongm@hotmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83-70-234-22.b-ras1.prp.dublin.eircom.net
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> http://zeniv.linux.org.uk/~alan/IDE
> 
> This is basically a resync versus 2.6.17, the head of the PATA tree is
> now built against Jeffs tree with revised error handling and the like.
> 
> Alan

I get the following bug while booting:

Linux version 2.6.17 (root@collins) (gcc version 3.4.6 (Gentoo 3.4.6-r1,
ssp-3.4.5-1.0, pie-8.7.9)) #4 PREEMPT Mon Jun 19 20:29:48 IST 2006
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
BIOS-e820: 0000000000100000 - 000000003ffda000 (usable)
BIOS-e820: 000000003ffda000 - 0000000040000000 (reserved)
BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fed20000 - 00000000fee10000 (reserved)
BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=/dev/ram0
netconsole=@192.168.1.150/eth0,514@192.168.1.100/00:12:3f:94:14:0e
vga=0x317 real_root=/dev/sda3 init=/linuxrc video=vesafb:mtrr:3,ywrap
libata.atapi_enabled=1
netconsole: local port 6665
netconsole: local IP 192.168.1.150
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 192.168.1.100
netconsole: remote ethernet address 00:12:3f:94:14:0e
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0576000 soft=c0575000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1862.367 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033100k/1048424k available (2930k kernel code, 14572k reserved,
1408k data, 200k init, 130920k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3727.80 BogoMIPS
(lpj=1863900)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 758k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1080-10bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04)
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
pnp: 00:03: ioport range 0x1060-0x107f has been reserved
pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
pnp: 00:08: ioport range 0x900-0x90f has been reserved
pnp: 00:08: ioport range 0x910-0x91f has been reserved
pnp: 00:08: ioport range 0x920-0x92f has been reserved
pnp: 00:08: ioport range 0x930-0x93f has been reserved
pnp: 00:08: ioport range 0x940-0x97f has been reserved
PCI: Bridge: 0000:00:01.0
IO window: d000-dfff
MEM window: dfd00000-dfefffff
PREFETCH window: d0000000-d7ffffff
PCI: Bus 4, cardbus bridge: 0000:03:01.0
IO window: 00002000-000020ff
IO window: 00002400-000024ff
PREFETCH window: 50000000-51ffffff
MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
IO window: 2000-2fff
MEM window: dfc00000-dfcfffff
PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Enabling device 0000:03:01.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 17
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x79 set to 0x1
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
NTFS driver 2.1.27 [Flags: R/W].
fuse init (API version 7.6)
Installing v9fs 9P2000 file system support
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 3072k, total
131008k
vesafb: mode is 1024x768x16, linelength=2048, pages=84
vesafb: protected mode interface info at c000:5b0b
vesafb: pmi: set display start = c00c5b79, set palette = c00c5bb3
vesafb: pmi: ports = de10 de16 de54 de38 de3c de5c de00 de04 deb0 deb2 deb4 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (57 C)
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
b44.c:v1.00 (Apr 7, 2006)
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 18
eth0: Broadcom 4400 10/100BaseT Ethernet 00:12:3f:ea:a4:a6
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: device eth0 not up yet, forcing it
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
netconsole: network logging started
ACPI: PCI Interrupt 0000:00:1f.2[B] -> 
GSI 17 (level, low) -> IRQ 19
ACPI: PCI interrupt for device 0000:00:1f.2 disabled
ahci: probe of 0000:00:1f.2 failed with error -12
ata_piix 0000:00:1f.2: MAP [
P0
P2
IDE IDE
]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> 
GSI 17 (level, low) -> IRQ 19
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
BUG: unable to handle kernel NULL pointer dereference
at virtual address 00000000
printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 

Modules linked in:

CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17 #4) 
EIP is at rest_init+0x3feffde0/0x40
eax: c19b635c   ebx: c03ee6c0   ecx: c19afe00   edx: c19b63d4
esi: c19b6454   edi: c10335e0   ebp: c193fef0   esp: c193fec8
ds: 007b   es: 007b   ss: 0068
Process ata/0 (pid: 310, threadinfo=c193f000 task=c193c070)

Stack: 
c02d8e6d 
00000200 
00000000 
c19afe00 
00000000 
c19b635c 
c19b64b8 
00000058 


c19b635c 
c19b6454 
c193ff14 
c02d91a6 
c04c7440 
c04c7440 
c193ff08 
c03dbd73 


c19b635c 
00000000 
c1986840 
c193ff28 
c02d9392 
c193ff28 
c19b6508 
c19b650c 

Call Trace:
<c0103f71> 
show_stack_log_lvl+0x91/0xc0

<c0104191> 
show_registers+0x191/0x210

<c01043b4> 
die+0x104/0x220

<c0116f2a> 
do_page_fault+0x38a/0x5f0

<c0103bb7> 
error_code+0x4f/0x54

<c02d91a6> 
ata_pio_block+0xc6/0x170

<c02d9392> 
ata_pio_task+0x72/0x80

<c012ced8> 
run_workqueue+0x78/0xf0

<c012d075> 
worker_thread+0x125/0x140

<c01304c5> 
kthread+0x95/0xe0

<c0101425> 
kernel_thread_helper+0x5/0x10


Code: 
Bad EIP value.

EIP: [<00000000>] 
rest_init+0x3feffde0/0x40
SS:ESP 0068:c193fec8


