Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUKAAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUKAAGS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 19:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUKAAGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 19:06:17 -0500
Received: from novell.stoldgods.nu ([193.45.238.241]:40879 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S261704AbUKAAFn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 19:05:43 -0500
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Date: Mon, 1 Nov 2004 01:05:16 +0100
User-Agent: KMail/1.7
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1099165925.1972.22.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
In-Reply-To: <20041031134016.GA24645@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411010105.17068.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Sunday 31 October 2004 14.40, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> i've just uploaded V0.6.2 that fixes a console-unblanking-timer
> thinko. This bug was present for quite some time, but this is the
> first time it triggered on my testbox - might be more common on
> others.

I'm trying to boot V0.6.2 on my laptop, which doesn't have a serial 
port, and I got a hardlock on boot. So I setup netconsole, which also 
hardlocks the machine, so I'm back to U9.3 for now..
It's a different hardlock when booting without netconsole. SysRq keys 
doesn't work.

Config:
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_REALTIME=y
CONFIG_PREEMPT_BKL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPT_TIMING=y
CONFIG_PREEMPT_TRACE=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y

No USB or PARPORT support in kernel.

Here's the boot log until it hardlock:

Linux version 2.6.9-mm1-RT-V0.6.2 (root@barbara) (gcc version 3.3.3 
(SuSE Linux)) #12 SMP Mon Nov 1 01:57:57 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f6e0000 (usable)
 BIOS-e820: 000000001f6e0000 - 000000001f6eb000 (ACPI data)
 BIOS-e820: 000000001f6eb000 - 000000001f700000 (ACPI NVS)
 BIOS-e820: 000000001f700000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
502MB LOWMEM available.
DMI present.
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: vga=0x314 resume=/dev/hda9 nmi_watchdog=1 
netconsole=1234@10.0.3.6/eth0,4567@10.0.2.1/00:50:BA:C2:11:34
netconsole: local port 1234
netconsole: local IP 10.0.3.6
netconsole: interface eth0
netconsole: remote port 4567
netconsole: remote IP 10.0.2.1
netconsole: remote ethernet address 00:50:ba:c2:11:34
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1500.066 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 502708k/514944k available (2931k kernel code, 11848k reserved, 
807k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
CPU0: Intel(R) Pentium(R) M processor 1500MHz stepping 05
per-CPU timeslice cutoff: 2924.02 usecs.
task migration cache decay timeout: 3 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
Brought up 1 CPUs
desched thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd6c4, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
ACPI: Embedded Controller [EC] (gpe 28)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1099274447.119:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: framebuffer at 0xe8000000, mapped to 0xe0080000, using 1875k, 
total 8000k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing 
enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
b44.c:v0.95 (Aug 3, 2004)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0a:e4:27:0f:c2
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears flaky, waiting 10 seconds
b44: eth0: Link is down.
b44: eth0: Link is up at 10 Mbps, half duplex.
b44: eth0: Flow control is off for TX and off for RX.
IRQ#10 thread RT prio: 49.


/ Magnus M‰‰tt‰
