Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWH0QHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWH0QHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWH0QHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:07:17 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:57237 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932156AbWH0QHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:07:11 -0400
Message-ID: <44F1C336.50304@free.fr>
Date: Sun, 27 Aug 2006 18:07:18 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.5) Gecko/20060405 SeaMonkey/1.0.3
MIME-Version: 1.0
To: John Stoffel <john@stoffel.org>
CC: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception
   code: 0xFFFFFFEA [20060707]
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>	<20060827001437.ec4f7a7a.akpm@osdl.org> <17649.47572.627874.371564@stoffel.org>
In-Reply-To: <17649.47572.627874.371564@stoffel.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------070306080606070608080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070306080606070608080600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 27.08.2006 17:27, John Stoffel a écrit :
>>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
> 
> Andrew> On Sat, 26 Aug 2006 23:56:09 -0700
> Andrew> "Miles Lane" <miles.lane@gmail.com> wrote:
> 
>>> PCI: Using ACPI for IRQ routing
>>> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
>>> ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
>>> [dump_trace+100/418] dump_trace+0x64/0x1a2
>>> [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
>>> [show_trace+13/16] show_trace+0xd/0x10
>>> [dump_stack+23/25] dump_stack+0x17/0x19
>>> [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
>>> [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
>>> [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
>>> [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
>>> [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
>>> [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
>>> [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
>>> [init+136/512] init+0x88/0x200
>>> [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
>>> DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
>>>
>>> Leftover inexact backtrace:
>>>
>>> [show_trace_log_lvl+18/37] show_trace_log_lvl+0x12/0x25
>>> [show_trace+13/16] show_trace+0xd/0x10
>>> [dump_stack+23/25] dump_stack+0x17/0x19
>>> [acpi_format_exception+162/175] acpi_format_exception+0xa2/0xaf
>>> [acpi_ut_status_exit+43/88] acpi_ut_status_exit+0x2b/0x58
>>> [acpi_walk_resources+269/281] acpi_walk_resources+0x10d/0x119
>>> [acpi_motherboard_add+34/52] acpi_motherboard_add+0x22/0x34
>>> [acpi_bus_driver_init+42/122] acpi_bus_driver_init+0x2a/0x7a
>>> [acpi_bus_register_driver+137/248] acpi_bus_register_driver+0x89/0xf8
>>> [acpi_motherboard_init+23/249] acpi_motherboard_init+0x17/0xf9
>>> [init+136/512] init+0x88/0x200
>>> [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
>>> =======================
> 
> Andrew> cc's added.
> 
> Thanks Andrew.  I just tried doing this with 2.6.18-rc4-mm3 and it
> hung again.  I also tried booting with irqpoll and pci=routeirq but it
> made no difference at all.  I got the following with irqpoll:
> 
>    irq 17: nobody cared (try booting with the "irqpoll" option)
>     [<c013e834>] __report_bad_irq+0x24/0x90
>     [<c013eab8>] note_interrupt+0x218/0x250
>     [<c013dd43>] handle_IRQ_event+0x33/0x70
>     [<c013f3ea>] handle_fasteoi_irq+0xca/0xe0
>     [<c013f320>] handle_fasteoi_irq+0x0/0xe0
>     [<c01059dd>] do_IRQ+0x8d/0xf0
>     [<c0554250>] unknown_bootoption+0x0/0x270
>     [<c01039da>] common_interrupt+0x1a/0x20
>     [<c0101c40>] default_idle+0x0/0x60
>     [<c0554250>] unknown_bootoption+0x0/0x270
>     [<c0101c71>] default_idle+0x31/0x60
>     [<c0101d0c>] cpu_idle+0x6c/0x90
>     [<c05547b9>] start_kernel+0x2f9/0x400
>     [<c0554250>] unknown_bootoption+0x0/0x270
>     =======================
>    handlers:
>    [<c0303890>] (ata_interrupt+0x0/0x190)
>    [<c03115b0>] (usb_hcd_irq+0x0/0x60)
>    Disabling IRQ #17
> 
> 
> I'm going to try and upgrade the firmware on my RocketPort 133 from
> 1.21 to 1.22 to see if that makes a difference, but otherwise there's
> not alot I can do here.
> Any more information I can provide?

I have the same ACPI error here with a simple box build on an ASUS 
A7V133-C with an athlon XP 1600+: 

ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c0103949>] show_trace_log_lvl+0x12/0x25
 [<c0103a2a>] show_trace+0xd/0x10
 [<c010415f>] dump_stack+0x19/0x1b
 [<c01ffa1a>] acpi_format_exception+0xa2/0xaf
 [<c01fcacc>] acpi_ut_status_exit+0x2b/0x58
 [<c01f8ee5>] acpi_walk_resources+0x103/0x10f
 [<c020a8f6>] acpi_motherboard_add+0x22/0x32
 [<c020998a>] acpi_bus_driver_init+0x2f/0x7f
 [<c0209e33>] acpi_bus_register_driver+0x8b/0xfa
 [<c03d582c>] acpi_motherboard_init+0xd/0xf9
 [<c01003b4>] init+0x88/0x209
 [<c0103863>] kernel_thread_helper+0x7/0x10
 =======================
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c0103949>] show_trace_log_lvl+0x12/0x25
 [<c0103a2a>] show_trace+0xd/0x10
 [<c010415f>] dump_stack+0x19/0x1b
 [<c01ffa1a>] acpi_format_exception+0xa2/0xaf
 [<c01fcacc>] acpi_ut_status_exit+0x2b/0x58
 [<c01f8ee5>] acpi_walk_resources+0x103/0x10f
 [<c020a8f6>] acpi_motherboard_add+0x22/0x32
 [<c020998a>] acpi_bus_driver_init+0x2f/0x7f
 [<c0209e33>] acpi_bus_register_driver+0x8b/0xfa
 [<c03d5836>] acpi_motherboard_init+0x17/0xf9
 [<c01003b4>] init+0x88/0x209
 [<c0103863>] kernel_thread_helper+0x7/0x10
 =======================
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c0103949>] show_trace_log_lvl+0x12/0x25
 [<c0103a2a>] show_trace+0xd/0x10
 [<c010415f>] dump_stack+0x19/0x1b
 [<c01ffa1a>] acpi_format_exception+0xa2/0xaf
 [<c01fcacc>] acpi_ut_status_exit+0x2b/0x58
 [<c01f8ee5>] acpi_walk_resources+0x103/0x10f
 [<c020a8f6>] acpi_motherboard_add+0x22/0x32
 [<c020998a>] acpi_bus_driver_init+0x2f/0x7f
 [<c0209e33>] acpi_bus_register_driver+0x8b/0xfa
 [<c03d5836>] acpi_motherboard_init+0x17/0xf9
 [<c01003b4>] init+0x88/0x209
 [<c0103863>] kernel_thread_helper+0x7/0x10
 =======================

Attached:
- full dmesg
- acpidump output

~~
laurent




--------------070306080606070608080600
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.18-rc4-mm3 (laurent@calimero.antadix) (gcc version 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #117 Sun Aug 27 11:48:25 CEST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001feec000 end: 000000001ffec000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001ffec000 size: 0000000000003000 end: 000000001ffef000 type: 3
copy_e820_map() start: 000000001ffef000 size: 0000000000010000 end: 000000001ffff000 type: 2
copy_e820_map() start: 000000001ffff000 size: 0000000000001000 end: 0000000020000000 type: 4
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
Entering add_active_range(0, 0, 131052) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131052
early_node_map[1] active PFN ranges
    0:        0 ->   131052
On node 0 totalpages: 131052
0 pages DMA reserved
  DMA zone: 4096 pages, LIFO batch:0
1023 pages used for memmap
  Normal zone: 125933 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Detected 1410.384 MHz processor.
Built 1 zonelists.  Total pages: 130029
Kernel command line: root=/dev/vglinux1/lvroot video=vesafb:mtrr splash=silent resume=/dev/vglinux1/lvswap
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01407000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 904 kB
 per task-struct memory footprint: 1200 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514040k/524208k available (1613k kernel code, 9516k reserved, 1192k data, 164k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdffec000   ( 511 MB)
      .init : 0xc03c0000 - 0xc03e9000   ( 164 kB)
      .data : 0xc0293761 - 0xc03bd850   (1192 kB)
      .text : 0xc0100000 - 0xc0293761   (1613 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2824.51 BogoMIPS (lpj=5649032)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1600+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0005) - 356 Objects with 38 Devices 115 Methods 24 Regions
ACPI Namespace successfully loaded at root c0571670
ACPI: setting ELCR to 0200 (from 0820)
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
checking if image is initramfs... it is
Freeing initrd memory: 370k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
PM: Adding info for No Bus:virtual
PM: Adding info for No Bus:vtconsole
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 4 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 23/24 Regions 2/2 Fields 19/19 Buffers 11/14 Packages (365 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:
Executed 0 _INI methods requiring 0 _STA executions (examined 41 objects)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PM: Adding info for No Bus:pci0000:00
PCI quirk: region e200-e27f claimed by vt82c686 HW-mon
PCI quirk: region e800-e80f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:04.1
PM: Adding info for pci:0000:00:04.2
PM: Adding info for pci:0000:00:04.3
PM: Adding info for pci:0000:00:04.4
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0d.0
PM: Adding info for pci:0000:01:00.0
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c0103949>] show_trace_log_lvl+0x12/0x25
 [<c0103a2a>] show_trace+0xd/0x10
 [<c010415f>] dump_stack+0x19/0x1b
 [<c01ffa1a>] acpi_format_exception+0xa2/0xaf
 [<c01fcacc>] acpi_ut_status_exit+0x2b/0x58
 [<c01f8ee5>] acpi_walk_resources+0x103/0x10f
 [<c020a8f6>] acpi_motherboard_add+0x22/0x32
 [<c020998a>] acpi_bus_driver_init+0x2f/0x7f
 [<c0209e33>] acpi_bus_register_driver+0x8b/0xfa
 [<c03d582c>] acpi_motherboard_init+0xd/0xf9
 [<c01003b4>] init+0x88/0x209
 [<c0103863>] kernel_thread_helper+0x7/0x10
 =======================
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c0103949>] show_trace_log_lvl+0x12/0x25
 [<c0103a2a>] show_trace+0xd/0x10
 [<c010415f>] dump_stack+0x19/0x1b
 [<c01ffa1a>] acpi_format_exception+0xa2/0xaf
 [<c01fcacc>] acpi_ut_status_exit+0x2b/0x58
 [<c01f8ee5>] acpi_walk_resources+0x103/0x10f
 [<c020a8f6>] acpi_motherboard_add+0x22/0x32
 [<c020998a>] acpi_bus_driver_init+0x2f/0x7f
 [<c0209e33>] acpi_bus_register_driver+0x8b/0xfa
 [<c03d5836>] acpi_motherboard_init+0x17/0xf9
 [<c01003b4>] init+0x88/0x209
 [<c0103863>] kernel_thread_helper+0x7/0x10
 =======================
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
 [<c0103949>] show_trace_log_lvl+0x12/0x25
 [<c0103a2a>] show_trace+0xd/0x10
 [<c010415f>] dump_stack+0x19/0x1b
 [<c01ffa1a>] acpi_format_exception+0xa2/0xaf
 [<c01fcacc>] acpi_ut_status_exit+0x2b/0x58
 [<c01f8ee5>] acpi_walk_resources+0x103/0x10f
 [<c020a8f6>] acpi_motherboard_add+0x22/0x32
 [<c020998a>] acpi_bus_driver_init+0x2f/0x7f
 [<c0209e33>] acpi_bus_register_driver+0x8b/0xfa
 [<c03d5836>] acpi_motherboard_init+0x17/0xf9
 [<c01003b4>] init+0x88/0x209
 [<c0103863>] kernel_thread_helper+0x7/0x10
 =======================
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c6000000-c7efffff
  PREFETCH window: c7f00000-cfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 655360 bytes)
TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
PM: Adding info for platform:pcspkr
Simple Boot Flag at 0x3a set to 0x1
PM: Adding info for No Bus:misc
PM: Adding info for No Bus:snapshot
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PM: Adding info for platform:vesafb.0
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 16 throttling states)
PM: Adding info for No Bus:vc
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
PM: Adding info for serio:serio1
PM: Adding info for No Bus:psaux
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
swsusp: Resume From Partition /dev/vglinux1/lvswap
PM: Checking swsusp image.
swsusp: Error -6 check for resume file
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 164k freed
Write protecting the kernel read-only data: 711k
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
SCSI subsystem initialized
libata version 2.00 loaded.
input: AT Translated Set 2 keyboard as /class/input/input0
pata_via 0000:00:04.1: version 0.1.13
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xD808 irq 15
scsi0 : pata_via
PM: Adding info for No Bus:host0
Time: acpi_pm clocksource has been installed.
ata1.00: ATA-5, max UDMA/100, 78165360 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
scsi1 : pata_via
PM: Adding info for No Bus:host1
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
ata2.01: ATAPI, max MWDMA2, CDB intr
ata2.01: configured for MWDMA2
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      ST340016A        3.75 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
PM: Adding info for No Bus:target0:0:1
scsi 0:0:1:0: Direct-Access     ATA      Maxtor 6Y080L0   YAR4 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:1:0
PM: Adding info for No Bus:target1:0:1
scsi 1:0:1:0: CD-ROM            E-IDE    CD-950E/AKU      A4Q  PQ: 0 ANSI: 5
PM: Adding info for scsi:1:0:1:0
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
sd 0:0:1:0: Attached scsi disk sdb
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
sr0: scsi3-mmc drive: 0x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
warning: process `sleep' used the obsolete sysctl system call
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc4-mm3 uhci_hcd
usb usb1: SerialNumber: 0000:00:04.2
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.3: irq 5, io base 0x0000d000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc4-mm3 uhci_hcd
usb usb2: SerialNumber: 0000:00:04.3
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
PCI: Enabling device 0000:00:09.0 (0014 -> 0016)
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
PM: Adding info for ieee1394:fw-host0
usb 1-2: new low speed USB device using uhci_hcd and address 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[c5800000-c58007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
usb 1-2: new device found, idVendor=044f, idProduct=b303
usb 1-2: new device strings: Mfr=4, Product=30, SerialNumber=0
usb 1-2: Product: FireStorm Dual Analog 2
usb 1-2: Manufacturer: THRUSTMASTER
PM: Adding info for usb:1-2
PM: Adding info for No Bus:usbdev1.2_ep00
usb 1-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-2:1.0
PM: Adding info for No Bus:usbdev1.2_ep81
PM: Adding info for No Bus:usbdev1.2
ohci1394: fw-host0: Running dma failed because Node ID is not valid
input: THRUSTMASTER FireStorm Dual Analog 2 as /class/input/input2
input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
warning: process `date' used the obsolete sysctl system call
PM: Adding info for ieee1394:00308d0120e085ca
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input3
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
PM: Adding info for No Bus:agpgart
agpgart: AGP aperture is 256M @ 0xd0000000
Using specific hotkey driver
EXT3 FS on dm-11, internal journal
Adding 1048568k swap on /dev/mapper/vglinux1-lvswap.  Priority:-1 extents:1 across:1048568k
Adding 1048568k swap on /dev/mapper/vglinux1-lvswap2.  Priority:-2 extents:1 across:1048568k
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-5: found reiserfs format "3.6" with standard journal
ReiserFS: dm-5: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-5: journal params: device dm-5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-5: checking transaction log (dm-5)
ReiserFS: dm-5: Using r5 hash to sort names
Loading Reiser4. See www.namesys.com for a description of Reiser4.
ReiserFS: dm-4: found reiserfs format "3.6" with standard journal
ReiserFS: dm-4: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-4: journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-4: checking transaction log (dm-4)
ReiserFS: dm-4: Using r5 hash to sort names
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
ReiserFS: dm-10: found reiserfs format "3.6" with standard journal
ReiserFS: dm-10: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-10: journal params: device dm-10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-10: checking transaction log (dm-10)
ReiserFS: dm-10: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
warning: process `ls' used the obsolete sysctl system call
warning: process `prcsys' used the obsolete sysctl system call
warning: process `prcsys' used the obsolete sysctl system call
Using specific hotkey driver
PM: Adding info for No Bus:vcs12
PM: Adding info for No Bus:vcsa12
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
NET: Registered protocol family 17
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Enabling device 0000:00:0b.0 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL-8029 found at 0xa400, IRQ 11, 00:40:95:46:6E:2D.
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
PM: Adding info for No Bus:i2c-0
PM: Adding info for No Bus:i2c-9191
PM: Adding info for No Bus:sound
PM: Adding info for No Bus:timer
PM: Adding info for i2c:0-002d
PM: Adding info for i2c:0-0049
PM: Adding info for i2c:0-0048
PCI: Enabling device 0000:00:0d.0 (0004 -> 0005)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
PM: Adding info for No Bus:midiC0D0
PM: Adding info for No Bus:midi
PM: Adding info for No Bus:dmmidi
PM: Adding info for No Bus:pcmC0D1p
PM: Adding info for No Bus:pcmC0D0p
PM: Adding info for No Bus:pcmC0D0c
PM: Adding info for ac97:0-0:TR28602
PM: Adding info for No Bus:controlC0
i2c_adapter i2c-9191: sensors disabled - enable with force_addr=0xe200
PM: Adding info for No Bus:mixer
PM: Adding info for No Bus:adsp
PM: Adding info for No Bus:dsp
PM: Adding info for No Bus:audio
PM: Adding info for No Bus:seq
PM: Adding info for No Bus:sequencer
PM: Adding info for No Bus:sequencer2

--------------070306080606070608080600
Content-Type: text/plain;
 name="acpidump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpidump.txt"

DSDT @ 0x1ffec100
  0000: 44 53 44 54 e1 2c 00 00 01 64 41 53 55 53 00 00  DSDT.,...dASUS..
  0010: 41 37 56 31 33 33 2d 43 00 10 00 00 4d 53 46 54  A7V133-C....MSFT
  0020: 0b 00 00 01 14 11 4d 49 4e 5f 02 a0 06 95 68 69  ......MIN_....hi
  0030: a4 68 a1 03 a4 69 14 09 53 4c 45 4e 01 a4 87 68  .h...i..SLEN...h
  0040: 14 21 53 32 42 46 09 72 53 4c 45 4e 68 01 60 08  .!S2BF.rSLENh.`.
  0050: 42 55 46 46 11 02 60 70 68 42 55 46 46 a4 42 55  BUFF..`phBUFF.BU
  0060: 46 46 14 47 06 53 43 4d 50 02 70 53 32 42 46 68  FF.G.SCMP.pS2BFh
  0070: 60 70 53 32 42 46 69 61 70 00 64 70 53 4c 45 4e  `pS2BFiap.dpSLEN
  0080: 68 65 70 53 4c 45 4e 69 66 70 4d 49 4e 5f 65 66  hepSLENifpMIN_ef
  0090: 67 a2 24 95 64 67 70 83 88 60 64 00 62 70 83 88  g.$.dgp..`d.bp..
  00a0: 61 64 00 63 a0 06 94 62 63 a4 01 a1 08 a0 06 95  ad.c...bc.......
  00b0: 62 63 a4 ff 75 64 a0 06 95 64 65 a4 01 a1 0c a0  bc..ud...de.....
  00c0: 06 95 64 66 a4 ff a1 03 a4 00 5b 80 46 53 45 47  ..df......[.FSEG
  00d0: 00 0c 00 df 0f 00 0b 00 01 5b 81 47 05 46 53 45  .........[.G.FSE
  00e0: 47 00 41 43 50 52 20 4d 4d 53 5a 10 4e 50 53 32  G.ACPR MMSZ.NPS2
  00f0: 08 53 54 52 46 08 48 43 55 44 08 48 43 50 49 08  .STRF.HCUD.HCPI.
  0100: 48 44 55 44 08 48 44 50 49 08 48 45 55 44 08 48  HDUD.HDPI.HEUD.H
  0110: 45 50 49 08 48 46 55 44 08 48 46 50 49 08 4c 50  EPI.HFUD.HFPI.LP
  0120: 54 4d 08 43 4d 32 4d 08 49 52 4d 44 08 46 4c 47  TM.CM2M.IRMD.FLG
  0130: 30 08 5b 80 4e 56 53 52 00 41 43 50 52 0b 00 01  0.[.NVSR.ACPR...
  0140: 5b 81 30 4e 56 53 52 00 54 52 54 59 08 53 4c 50  [.0NVSR.TRTY.SLP
  0150: 54 08 00 08 4b 50 53 57 08 4d 50 53 57 08 54 52  T...KPSW.MPSW.TR
  0160: 44 30 08 54 52 44 31 08 54 52 44 32 08 54 52 44  D0.TRD1.TRD2.TRD
  0170: 33 08 10 19 5c 5f 50 52 5f 5b 83 11 5c 2e 5f 50  3...\_PR_[..\._P
  0180: 52 5f 43 50 55 30 01 10 e4 00 00 06 08 5c 5f 53  R_CPU0.......\_S
  0190: 30 5f 12 0a 04 0a 00 0a 00 0a 00 0a 00 08 5c 5f  0_............\_
  01a0: 53 31 5f 12 0a 04 0a 03 0a 03 0a 00 0a 00 08 5c  S1_............\
  01b0: 5f 53 33 5f 12 0a 04 0a 03 0a 03 0a 00 0a 00 08  _S3_............
  01c0: 5c 5f 53 34 5f 12 0a 04 0a 07 0a 07 0a 00 0a 00  \_S4_...........
  01d0: 08 5c 5f 53 35 5f 12 0a 04 0a 07 0a 07 0a 00 0a  .\_S5_..........
  01e0: 00 5b 80 5c 44 45 42 47 01 0a 80 0a 01 5b 81 0c  .[.\DEBG.....[..
  01f0: 5c 44 45 42 47 01 44 42 47 31 08 5b 80 47 50 53  \DEBG.DBG1.[.GPS
  0200: 43 01 0b 2f e4 0a 01 5b 81 0b 47 50 53 43 01 53  C../...[..GPSC.S
  0210: 4d 43 4d 08 14 13 49 53 4d 49 09 70 68 54 52 54  MCM...ISMI.phTRT
  0220: 59 70 0a a7 53 4d 43 4d 5b 80 47 50 4f 42 01 0b  Yp..SMCM[.GPOB..
  0230: 2a e4 0a 02 5b 81 0f 47 50 4f 42 01 00 0e 54 52  *...[..GPOB...TR
  0240: 50 30 01 00 01 5b 80 45 43 4f 53 01 0a 72 0a 02  P0...[.ECOS..r..
  0250: 5b 81 10 45 43 4f 53 01 43 49 44 58 08 43 44 41  [..ECOS.CIDX.CDA
  0260: 54 08 5b 86 1e 43 49 44 58 43 44 41 54 01 00 48  T.[..CIDXCDAT..H
  0270: 67 53 55 53 33 01 52 54 43 57 01 00 02 53 4c 53  gSUS3.RTCW...SLS
  0280: 54 04 08 50 52 57 31 12 1e 04 12 06 02 0a 0b 0a  T..PRW1.........
  0290: 01 12 06 02 0a 09 0a 01 12 06 02 0a 08 0a 01 12  ................
  02a0: 06 02 0a 0d 0a 01 08 50 52 57 33 12 1e 04 12 06  .......PRW3.....
  02b0: 02 0a 0b 0a 03 12 06 02 0a 09 0a 03 12 06 02 0a  ................
  02c0: 08 0a 03 12 06 02 0a 0d 0a 03 08 50 52 57 34 12  ...........PRW4.
  02d0: 1e 04 12 06 02 0a 0b 0a 04 12 06 02 0a 09 0a 04  ................
  02e0: 12 06 02 0a 08 0a 04 12 06 02 0a 0d 0a 04 08 50  ...............P
  02f0: 52 57 54 12 0a 04 0a 0b 0a 09 0a 08 0a 0d 14 23  RWT............#
  0300: 53 50 52 57 01 70 89 50 52 57 54 01 68 00 0a 00  SPRW.p.PRWT.h...
  0310: 0a 00 60 70 53 55 53 33 62 a4 83 88 50 52 57 34  ..`pSUS3b...PRW4
  0320: 60 00 08 42 55 30 30 11 0b 0a 08 00 00 00 00 00  `..BU00.........
  0330: 00 00 00 8a 42 55 30 30 0a 00 47 41 52 54 8a 42  ....BU00..GART.B
  0340: 55 30 30 0a 04 41 47 50 53 14 47 0a 5c 5f 50 54  U00..AGPS.G.\_PT
  0350: 53 01 70 68 53 4c 53 54 70 68 53 4c 50 54 a0 2f  S.phSLSTphSLPT./
  0360: 93 68 0a 03 4d 55 53 4d 0a 00 53 47 4f 48 0a 83  .h..MUSM..SGOH..
  0370: 0a 04 53 47 4f 4c 0a 80 0a 04 53 47 4f 48 0a 80  ..SGOL....SGOH..
  0380: 0a 04 53 47 4f 48 0a 83 0a 01 45 4e 31 38 a0 3c  ..SGOH....EN18.<
  0390: 91 93 68 0a 03 93 68 0a 04 70 5c 2f 04 5f 53 42  ..h...h..p\/._SB
  03a0: 5f 50 43 49 30 42 58 30 30 47 41 52 54 5c 47 41  _PCI0BX00GART\GA
  03b0: 52 54 70 5c 2f 04 5f 53 42 5f 50 43 49 30 42 58  RTp\/._SB_PCI0BX
  03c0: 30 30 41 47 50 53 5c 41 47 50 53 70 01 54 52 50  00AGPS\AGPSp.TRP
  03d0: 30 70 01 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58  0p.\/._SB_PCI0PX
  03e0: 34 30 50 43 53 30 7d 68 0a f0 62 70 62 44 42 47  40PCS0}h..bpbDBG
  03f0: 31 14 4e 0a 5c 5f 57 41 4b 01 a0 3c 91 93 68 0a  1.N.\_WAK..<..h.
  0400: 03 93 68 0a 04 70 5c 47 41 52 54 5c 2f 04 5f 53  ..h..p\GART\/._S
  0410: 42 5f 50 43 49 30 42 58 30 30 47 41 52 54 70 5c  B_PCI0BX00GARTp\
  0420: 41 47 50 53 5c 2f 04 5f 53 42 5f 50 43 49 30 42  AGPS\/._SB_PCI0B
  0430: 58 30 30 41 47 50 53 a0 4b 04 93 68 0a 03 70 00  X00AGPS.K..h..p.
  0440: 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 50  \/._SB_PCI0PX40P
  0450: 43 53 30 5b 21 0a 50 70 00 54 52 50 30 5b 21 0a  CS0[!.Pp.TRP0[!.
  0460: 50 4d 55 53 4d 0a 00 5b 21 0a 50 53 47 4f 4c 0a  PMUSM..[!.PSGOL.
  0470: 83 0a 04 5b 21 0a 50 53 47 4f 4c 0a 83 0a 01 5b  ...[!.PSGOL....[
  0480: 21 0a 50 70 0a ff 44 42 47 31 a0 15 93 52 54 43  !.Pp..DBG1...RTC
  0490: 57 0a 00 86 5c 2e 5f 53 42 5f 50 57 52 42 0a 02  W...\._SB_PWRB..
  04a0: 5b 80 53 4d 30 30 01 0b 00 e8 0a 07 5b 81 26 53  [.SM00......[.&S
  04b0: 4d 30 30 01 48 53 54 53 08 00 08 43 54 4c 52 08  M00.HSTS...CTLR.
  04c0: 43 4d 44 52 08 41 44 44 52 08 44 41 54 30 08 44  CMDR.ADDR.DAT0.D
  04d0: 41 54 31 08 14 1f 53 57 46 53 00 7b 48 53 54 53  AT1...SWFS.{HSTS
  04e0: 0a 06 60 a2 10 93 60 00 5b 21 0a 01 7b 48 53 54  ..`...`.[!..{HST
  04f0: 53 0a 06 60 14 26 53 4d 42 57 00 7b 48 53 54 53  S..`.&SMBW.{HSTS
  0500: 0a 01 62 a2 17 93 62 01 5b 21 0a 0a 70 0a ff 48  ..b...b.[!..p..H
  0510: 53 54 53 7b 48 53 54 53 0a 01 62 14 28 53 42 59  STS{HSTS..b.(SBY
  0520: 54 02 53 4d 42 57 70 68 41 44 44 52 70 69 43 4d  T.SMBWphADDRpiCM
  0530: 44 52 70 0a ff 48 53 54 53 70 0a 44 43 54 4c 52  DRp..HSTSp.DCTLR
  0540: 53 57 46 53 14 2e 57 42 59 54 03 53 4d 42 57 70  SWFS..WBYT.SMBWp
  0550: 68 41 44 44 52 70 69 43 4d 44 52 70 6a 44 41 54  hADDRpiCMDRpjDAT
  0560: 30 70 0a ff 48 53 54 53 70 0a 48 43 54 4c 52 53  0p..HSTSp.HCTLRS
  0570: 57 46 53 14 34 57 57 52 44 04 53 4d 42 57 70 68  WFS.4WWRD.SMBWph
  0580: 41 44 44 52 70 69 43 4d 44 52 70 6a 44 41 54 30  ADDRpiCMDRpjDAT0
  0590: 70 6b 44 41 54 31 70 0a ff 48 53 54 53 70 0a 4c  pkDAT1p..HSTSp.L
  05a0: 43 54 4c 52 53 57 46 53 14 46 05 52 42 59 54 02  CTLRSWFS.F.RBYT.
  05b0: 53 4d 42 57 7d 68 0a 01 61 70 61 41 44 44 52 70  SMBW}h..apaADDRp
  05c0: 69 43 4d 44 52 70 0a ff 48 53 54 53 70 0a 48 43  iCMDRp..HSTSp.HC
  05d0: 54 4c 52 7b 48 53 54 53 0a 02 60 a2 1e 93 60 00  TLR{HSTS..`...`.
  05e0: 70 0a ff 48 53 54 53 70 0a 48 43 54 4c 52 53 57  p..HSTSp.HCTLRSW
  05f0: 46 53 7b 48 53 54 53 0a 02 60 a4 44 41 54 30 14  FS{HSTS..`.DAT0.
  0600: 3e 52 57 52 44 02 53 4d 42 57 7d 68 0a 01 41 44  >RWRD.SMBW}h..AD
  0610: 44 52 70 69 43 4d 44 52 70 0a ff 48 53 54 53 70  DRpiCMDRp..HSTSp
  0620: 0a 4c 43 54 4c 52 53 57 46 53 70 44 41 54 30 60  .LCTLRSWFSpDAT0`
  0630: 79 44 41 54 31 0a 08 61 7d 60 61 62 a4 62 14 1d  yDAT1..a}`ab.b..
  0640: 53 47 4f 48 02 70 0a 90 60 70 52 42 59 54 60 68  SGOH.p..`pRBYT`h
  0650: 61 7d 61 69 61 57 42 59 54 60 68 61 14 20 53 47  a}aiaWBYT`ha. SG
  0660: 4f 4c 02 70 0a 90 60 70 52 42 59 54 60 68 61 80  OL.p..`pRBYT`ha.
  0670: 69 62 7b 61 62 61 57 42 59 54 60 68 61 14 12 46  ib{abaWBYT`ha..F
  0680: 41 4e 43 01 70 0a 5a 60 57 42 59 54 60 0a 59 68  ANC.p.Z`WBYT`.Yh
  0690: 14 12 46 41 4e 50 01 70 0a 5a 60 57 42 59 54 60  ..FANP.p.Z`WBYT`
  06a0: 0a 5a 68 14 20 45 4e 31 38 00 70 0a 5a 60 70 52  .Zh. EN18.p.Z`pR
  06b0: 42 59 54 60 0a 5f 61 7b 61 0a df 61 57 42 59 54  BYT`._a{a..aWBYT
  06c0: 60 0a 5f 61 14 20 44 53 31 38 00 70 0a 5a 60 70  `._a. DS18.p.Z`p
  06d0: 52 42 59 54 60 0a 5f 61 7d 61 0a 20 61 57 42 59  RBYT`._a}a. aWBY
  06e0: 54 60 0a 5f 61 14 20 44 53 31 37 00 70 0a 5a 60  T`._a. DS17.p.Z`
  06f0: 70 52 42 59 54 60 0a 5f 61 7b 61 0a bf 61 57 42  pRBYT`._a{a..aWB
  0700: 59 54 60 0a 5f 61 14 20 45 4e 31 37 00 70 0a 5a  YT`._a. EN17.p.Z
  0710: 60 70 52 42 59 54 60 0a 5f 61 7d 61 0a 40 61 57  `pRBYT`._a}a.@aW
  0720: 42 59 54 60 0a 5f 61 10 4f 0a 5c 5f 53 49 5f 14  BYT`._a.O.\_SI_.
  0730: 4a 04 5f 4d 53 47 01 a0 28 93 68 00 53 47 4f 4c  J._MSG..(.h.SGOL
  0740: 0a 81 0a 02 5b 21 0a 50 53 47 4f 48 0a 81 0a 01  ....[!.PSGOH....
  0750: 5b 21 0a 50 53 47 4f 4c 0a 81 0a 01 5b 21 0a 50  [!.PSGOL....[!.P
  0760: a1 19 53 47 4f 48 0a 81 0a 02 5b 21 0a 50 53 47  ..SGOH....[!.PSG
  0770: 4f 4c 0a 81 0a 02 5b 21 0a 50 14 4c 05 5f 53 53  OL....[!.P.L._SS
  0780: 54 01 a0 11 93 68 0a 00 53 47 4f 48 0a 80 0a 40  T....h..SGOH...@
  0790: 5b 21 0a 50 a1 42 04 a0 21 93 68 0a 03 53 47 4f  [!.P.B..!.h..SGO
  07a0: 4c 0a 80 0a 40 5b 21 0a 50 53 47 4f 4c 0a 80 0a  L...@[!.PSGOL...
  07b0: 80 5b 21 0a 50 5b 21 0a 50 a1 1d 53 47 4f 4c 0a  .[!.P[!.P..SGOL.
  07c0: 80 0a 40 5b 21 0a 50 53 47 4f 48 0a 80 0a 80 5b  ..@[!.PSGOH....[
  07d0: 21 0a 50 5b 21 0a 50 5b 80 5c 53 47 50 4f 01 0b  !.P[!.P[.\SGPO..
  07e0: 4c e4 0a 04 5b 81 1b 53 47 50 4f 01 47 50 4f 30  L...[..SGPO.GPO0
  07f0: 01 00 07 47 50 4f 38 01 00 02 47 50 31 31 01 00  ...GPO8...GP11..
  0800: 14 14 43 05 4d 55 53 4d 01 a0 19 93 68 0a 02 70  ..C.MUSM....h..p
  0810: 00 47 50 4f 38 5b 21 0a 50 70 01 47 50 31 31 5b  .GPO8[!.Pp.GP11[
  0820: 21 0a 50 a1 31 a0 19 93 68 0a 01 70 01 47 50 4f  !.P.1...h..p.GPO
  0830: 38 5b 21 0a 50 70 00 47 50 31 31 5b 21 0a 50 a1  8[!.Pp.GP11[!.P.
  0840: 15 70 00 47 50 4f 38 5b 21 0a 50 70 00 47 50 31  .p.GPO8[!.Pp.GP1
  0850: 31 5b 21 0a 50 14 1f 46 41 4e 41 01 a0 0c 68 70  1[!.P..FANA...hp
  0860: 01 47 50 4f 30 5b 21 0a 50 a1 0b 70 00 47 50 4f  .GPO0[!.P..p.GPO
  0870: 30 5b 21 0a 50 10 86 3c 02 5c 5f 53 42 5f 5b 82  0[!.P..<.\_SB_[.
  0880: 25 50 57 52 42 08 5f 48 49 44 0c 41 d0 0c 0c 14  %PWRB._HID.A....
  0890: 09 5f 53 54 41 00 a4 0a 0b 08 5f 50 52 57 12 06  ._STA....._PRW..
  08a0: 02 0a 0b 0a 05 5b 82 4c 07 4d 45 4d 31 08 5f 48  .....[.L.MEM1._H
  08b0: 49 44 0c 41 d0 0c 01 14 4b 06 5f 43 52 53 00 08  ID.A....K._CRS..
  08c0: 42 55 46 31 11 35 0a 32 86 09 00 01 00 00 00 00  BUF1.5.2........
  08d0: 00 00 0a 00 86 09 00 00 00 00 0f 00 00 00 01 00  ................
  08e0: 86 09 00 01 00 00 10 00 00 00 00 00 86 09 00 00  ................
  08f0: 00 00 fe ff 00 00 02 00 79 00 8a 42 55 46 31 0a  ........y..BUF1.
  0900: 20 45 4d 4c 4e 70 4d 45 4d 53 45 4d 4c 4e 76 45   EMLNpMEMSEMLNvE
  0910: 4d 4c 4e 79 45 4d 4c 4e 0a 14 45 4d 4c 4e a4 42  MLNyEMLN..EMLN.B
  0920: 55 46 31 14 0b 4d 45 4d 53 00 a4 4d 4d 53 5a 5b  UF1..MEMS..MMSZ[
  0930: 82 4b 0f 4c 4e 4b 41 08 5f 48 49 44 0c 41 d0 0c  .K.LNKA._HID.A..
  0940: 0f 08 5f 55 49 44 0a 01 14 2a 5f 53 54 41 00 70  .._UID...*_STA.p
  0950: 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 50  \/._SB_PCI0PX40P
  0960: 49 52 41 60 a0 09 92 93 60 0a 00 a4 0a 0b a1 04  IRA`....`.......
  0970: a4 0a 09 08 5f 50 52 53 11 09 0a 06 23 f8 de 18  ...._PRS....#...
  0980: 79 00 14 1c 5f 44 49 53 00 70 0a 00 5c 2f 04 5f  y..._DIS.p..\/._
  0990: 53 42 5f 50 43 49 30 50 58 34 30 50 49 52 41 14  SB_PCI0PX40PIRA.
  09a0: 4c 04 5f 43 52 53 00 08 42 55 46 41 11 09 0a 06  L._CRS..BUFA....
  09b0: 23 00 00 18 79 00 8b 42 55 46 41 0a 01 49 52 41  #...y..BUFA..IRA
  09c0: 5f 70 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58 34  _p\/._SB_PCI0PX4
  09d0: 30 50 49 52 41 60 a0 10 92 93 60 0a 00 79 01 60  0PIRA`....`..y.`
  09e0: 61 70 61 49 52 41 5f a4 42 55 46 41 14 3f 5f 53  apaIRA_.BUFA.?_S
  09f0: 52 53 01 8b 68 0a 01 49 52 41 31 70 49 52 41 31  RS..h..IRA1pIRA1
  0a00: 60 70 0a 00 61 7a 60 0a 01 60 a2 0c 94 60 0a 00  `p..az`..`...`..
  0a10: 75 61 7a 60 0a 01 60 70 61 5c 2f 04 5f 53 42 5f  uaz`..`pa\/._SB_
  0a20: 50 43 49 30 50 58 34 30 50 49 52 41 5b 82 4b 0f  PCI0PX40PIRA[.K.
  0a30: 4c 4e 4b 42 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f  LNKB._HID.A...._
  0a40: 55 49 44 0a 02 14 2a 5f 53 54 41 00 70 5c 2f 04  UID...*_STA.p\/.
  0a50: 5f 53 42 5f 50 43 49 30 50 58 34 30 50 49 52 42  _SB_PCI0PX40PIRB
  0a60: 60 a0 09 92 93 60 0a 00 a4 0a 0b a1 04 a4 0a 09  `....`..........
  0a70: 08 5f 50 52 53 11 09 0a 06 23 f8 de 18 79 00 14  ._PRS....#...y..
  0a80: 1c 5f 44 49 53 00 70 0a 00 5c 2f 04 5f 53 42 5f  ._DIS.p..\/._SB_
  0a90: 50 43 49 30 50 58 34 30 50 49 52 42 14 4c 04 5f  PCI0PX40PIRB.L._
  0aa0: 43 52 53 00 08 42 55 46 42 11 09 0a 06 23 00 00  CRS..BUFB....#..
  0ab0: 18 79 00 8b 42 55 46 42 0a 01 49 52 42 5f 70 5c  .y..BUFB..IRB_p\
  0ac0: 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 50 49  /._SB_PCI0PX40PI
  0ad0: 52 42 60 a0 10 92 93 60 0a 00 79 01 60 61 70 61  RB`....`..y.`apa
  0ae0: 49 52 42 5f a4 42 55 46 42 14 3f 5f 53 52 53 01  IRB_.BUFB.?_SRS.
  0af0: 8b 68 0a 01 49 52 42 31 70 49 52 42 31 60 70 0a  .h..IRB1pIRB1`p.
  0b00: 00 61 7a 60 0a 01 60 a2 0c 94 60 0a 00 75 61 7a  .az`..`...`..uaz
  0b10: 60 0a 01 60 70 61 5c 2f 04 5f 53 42 5f 50 43 49  `..`pa\/._SB_PCI
  0b20: 30 50 58 34 30 50 49 52 42 5b 82 4b 0f 4c 4e 4b  0PX40PIRB[.K.LNK
  0b30: 43 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44  C._HID.A...._UID
  0b40: 0a 03 14 2a 5f 53 54 41 00 70 5c 2f 04 5f 53 42  ...*_STA.p\/._SB
  0b50: 5f 50 43 49 30 50 58 34 30 50 49 52 43 60 a0 09  _PCI0PX40PIRC`..
  0b60: 92 93 60 0a 00 a4 0a 0b a1 04 a4 0a 09 08 5f 50  ..`..........._P
  0b70: 52 53 11 09 0a 06 23 f8 de 18 79 00 14 1c 5f 44  RS....#...y..._D
  0b80: 49 53 00 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49  IS.p..\/._SB_PCI
  0b90: 30 50 58 34 30 50 49 52 43 14 4c 04 5f 43 52 53  0PX40PIRC.L._CRS
  0ba0: 00 08 42 55 46 43 11 09 0a 06 23 00 00 18 79 00  ..BUFC....#...y.
  0bb0: 8b 42 55 46 43 0a 01 49 52 43 5f 70 5c 2f 04 5f  .BUFC..IRC_p\/._
  0bc0: 53 42 5f 50 43 49 30 50 58 34 30 50 49 52 43 60  SB_PCI0PX40PIRC`
  0bd0: a0 10 92 93 60 0a 00 79 01 60 61 70 61 49 52 43  ....`..y.`apaIRC
  0be0: 5f a4 42 55 46 43 14 3f 5f 53 52 53 01 8b 68 0a  _.BUFC.?_SRS..h.
  0bf0: 01 49 52 43 31 70 49 52 43 31 60 70 0a 00 61 7a  .IRC1pIRC1`p..az
  0c00: 60 0a 01 60 a2 0c 94 60 0a 00 75 61 7a 60 0a 01  `..`...`..uaz`..
  0c10: 60 70 61 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58  `pa\/._SB_PCI0PX
  0c20: 34 30 50 49 52 43 5b 82 4b 0f 4c 4e 4b 44 08 5f  40PIRC[.K.LNKD._
  0c30: 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a 04 14  HID.A...._UID...
  0c40: 2a 5f 53 54 41 00 70 5c 2f 04 5f 53 42 5f 50 43  *_STA.p\/._SB_PC
  0c50: 49 30 50 58 34 30 50 49 52 44 60 a0 09 92 93 60  I0PX40PIRD`....`
  0c60: 0a 00 a4 0a 0b a1 04 a4 0a 09 08 5f 50 52 53 11  ..........._PRS.
  0c70: 09 0a 06 23 f8 de 18 79 00 14 1c 5f 44 49 53 00  ...#...y..._DIS.
  0c80: 70 0a 00 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58  p..\/._SB_PCI0PX
  0c90: 34 30 50 49 52 44 14 4c 04 5f 43 52 53 00 08 42  40PIRD.L._CRS..B
  0ca0: 55 46 44 11 09 0a 06 23 00 00 18 79 00 8b 42 55  UFD....#...y..BU
  0cb0: 46 44 0a 01 49 52 44 5f 70 5c 2f 04 5f 53 42 5f  FD..IRD_p\/._SB_
  0cc0: 50 43 49 30 50 58 34 30 50 49 52 44 60 a0 10 92  PCI0PX40PIRD`...
  0cd0: 93 60 0a 00 79 01 60 61 70 61 49 52 44 5f a4 42  .`..y.`apaIRD_.B
  0ce0: 55 46 44 14 3f 5f 53 52 53 01 8b 68 0a 01 49 52  UFD.?_SRS..h..IR
  0cf0: 44 31 70 49 52 44 31 60 70 0a 00 61 7a 60 0a 01  D1pIRD1`p..az`..
  0d00: 60 a2 0c 94 60 0a 00 75 61 7a 60 0a 01 60 70 61  `...`..uaz`..`pa
  0d10: 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 50  \/._SB_PCI0PX40P
  0d20: 49 52 44 5b 82 87 f1 01 50 43 49 30 08 5f 48 49  IRD[....PCI0._HI
  0d30: 44 0c 41 d0 0a 03 08 5f 41 44 52 0a 00 08 43 52  D.A...._ADR...CR
  0d40: 45 53 11 4c 08 0a 88 88 0d 00 02 0c 00 00 00 00  ES.L............
  0d50: 00 ff 00 00 00 00 01 47 01 f8 0c f8 0c 01 08 88  .......G........
  0d60: 0d 00 01 0c 03 00 00 00 00 f7 0c 00 00 f8 0c 88  ................
  0d70: 0d 00 01 0c 03 00 00 00 0d ff ff 00 00 00 f3 87  ................
  0d80: 17 00 00 0c 03 00 00 00 00 00 00 0a 00 ff ff 0b  ................
  0d90: 00 00 00 00 00 00 00 02 00 87 17 00 00 0c 03 00  ................
  0da0: 00 00 00 00 80 0c 00 ff ff 0d 00 00 00 00 00 00  ................
  0db0: 80 01 00 87 17 00 00 0c 03 00 00 00 00 00 00 10  ................
  0dc0: 00 ff ff ff ff 00 00 00 00 00 00 f0 ff 79 00 14  .............y..
  0dd0: 49 04 5f 43 52 53 00 8a 43 52 45 53 0a 76 52 41  I._CRS..CRES.vRA
  0de0: 4d 54 8a 43 52 45 53 0a 82 52 41 4d 52 70 4d 45  MT.CRES..RAMRpME
  0df0: 4d 53 52 41 4d 54 79 52 41 4d 54 0a 14 52 41 4d  MSRAMTyRAMT..RAM
  0e00: 54 74 0c ff ff ff ff 52 41 4d 54 52 41 4d 52 75  Tt.....RAMTRAMRu
  0e10: 52 41 4d 52 a4 43 52 45 53 08 50 49 43 4d 12 4b  RAMR.CRES.PICM.K
  0e20: 31 24 12 15 04 0c ff ff 0c 00 0a 00 5c 2e 5f 53  1$..........\._S
  0e30: 42 5f 4c 4e 4b 41 0a 00 12 15 04 0c ff ff 0c 00  B_LNKA..........
  0e40: 0a 01 5c 2e 5f 53 42 5f 4c 4e 4b 42 0a 00 12 15  ..\._SB_LNKB....
  0e50: 04 0c ff ff 0c 00 0a 02 5c 2e 5f 53 42 5f 4c 4e  ........\._SB_LN
  0e60: 4b 43 0a 00 12 15 04 0c ff ff 0c 00 0a 03 5c 2e  KC............\.
  0e70: 5f 53 42 5f 4c 4e 4b 44 0a 00 12 15 04 0c ff ff  _SB_LNKD........
  0e80: 0b 00 0a 00 5c 2e 5f 53 42 5f 4c 4e 4b 42 0a 00  ....\._SB_LNKB..
  0e90: 12 15 04 0c ff ff 0b 00 0a 01 5c 2e 5f 53 42 5f  ..........\._SB_
  0ea0: 4c 4e 4b 43 0a 00 12 15 04 0c ff ff 0b 00 0a 02  LNKC............
  0eb0: 5c 2e 5f 53 42 5f 4c 4e 4b 44 0a 00 12 15 04 0c  \._SB_LNKD......
  0ec0: ff ff 0b 00 0a 03 5c 2e 5f 53 42 5f 4c 4e 4b 41  ......\._SB_LNKA
  0ed0: 0a 00 12 15 04 0c ff ff 0a 00 0a 00 5c 2e 5f 53  ............\._S
  0ee0: 42 5f 4c 4e 4b 43 0a 00 12 15 04 0c ff ff 0a 00  B_LNKC..........
  0ef0: 0a 01 5c 2e 5f 53 42 5f 4c 4e 4b 44 0a 00 12 15  ..\._SB_LNKD....
  0f00: 04 0c ff ff 0a 00 0a 02 5c 2e 5f 53 42 5f 4c 4e  ........\._SB_LN
  0f10: 4b 41 0a 00 12 15 04 0c ff ff 0a 00 0a 03 5c 2e  KA............\.
  0f20: 5f 53 42 5f 4c 4e 4b 42 0a 00 12 15 04 0c ff ff  _SB_LNKB........
  0f30: 09 00 0a 00 5c 2e 5f 53 42 5f 4c 4e 4b 44 0a 00  ....\._SB_LNKD..
  0f40: 12 15 04 0c ff ff 09 00 0a 01 5c 2e 5f 53 42 5f  ..........\._SB_
  0f50: 4c 4e 4b 41 0a 00 12 15 04 0c ff ff 09 00 0a 02  LNKA............
  0f60: 5c 2e 5f 53 42 5f 4c 4e 4b 42 0a 00 12 15 04 0c  \._SB_LNKB......
  0f70: ff ff 09 00 0a 03 5c 2e 5f 53 42 5f 4c 4e 4b 43  ......\._SB_LNKC
  0f80: 0a 00 12 15 04 0c ff ff 0d 00 0a 00 5c 2e 5f 53  ............\._S
  0f90: 42 5f 4c 4e 4b 44 0a 00 12 15 04 0c ff ff 0d 00  B_LNKD..........
  0fa0: 0a 01 5c 2e 5f 53 42 5f 4c 4e 4b 41 0a 00 12 15  ..\._SB_LNKA....
  0fb0: 04 0c ff ff 0d 00 0a 02 5c 2e 5f 53 42 5f 4c 4e  ........\._SB_LN
  0fc0: 4b 42 0a 00 12 15 04 0c ff ff 0d 00 0a 03 5c 2e  KB............\.
  0fd0: 5f 53 42 5f 4c 4e 4b 43 0a 00 12 15 04 0c ff ff  _SB_LNKC........
  0fe0: 12 00 0a 00 5c 2e 5f 53 42 5f 4c 4e 4b 41 0a 00  ....\._SB_LNKA..
  0ff0: 12 15 04 0c ff ff 12 00 0a 01 5c 2e 5f 53 42 5f  ..........\._SB_
  1000: 4c 4e 4b 42 0a 00 12 15 04 0c ff ff 12 00 0a 02  LNKB............
  1010: 5c 2e 5f 53 42 5f 4c 4e 4b 43 0a 00 12 15 04 0c  \._SB_LNKC......
  1020: ff ff 12 00 0a 03 5c 2e 5f 53 42 5f 4c 4e 4b 44  ......\._SB_LNKD
  1030: 0a 00 12 15 04 0c ff ff 11 00 0a 00 5c 2e 5f 53  ............\._S
  1040: 42 5f 4c 4e 4b 42 0a 00 12 15 04 0c ff ff 11 00  B_LNKB..........
  1050: 0a 01 5c 2e 5f 53 42 5f 4c 4e 4b 43 0a 00 12 15  ..\._SB_LNKC....
  1060: 04 0c ff ff 11 00 0a 02 5c 2e 5f 53 42 5f 4c 4e  ........\._SB_LN
  1070: 4b 44 0a 00 12 15 04 0c ff ff 11 00 0a 03 5c 2e  KD............\.
  1080: 5f 53 42 5f 4c 4e 4b 41 0a 00 12 15 04 0c ff ff  _SB_LNKA........
  1090: 01 00 0a 00 5c 2e 5f 53 42 5f 4c 4e 4b 41 0a 00  ....\._SB_LNKA..
  10a0: 12 15 04 0c ff ff 01 00 0a 01 5c 2e 5f 53 42 5f  ..........\._SB_
  10b0: 4c 4e 4b 42 0a 00 12 15 04 0c ff ff 01 00 0a 02  LNKB............
  10c0: 5c 2e 5f 53 42 5f 4c 4e 4b 43 0a 00 12 15 04 0c  \._SB_LNKC......
  10d0: ff ff 01 00 0a 03 5c 2e 5f 53 42 5f 4c 4e 4b 44  ......\._SB_LNKD
  10e0: 0a 00 12 15 04 0c ff ff 04 00 0a 00 5c 2e 5f 53  ............\._S
  10f0: 42 5f 4c 4e 4b 41 0a 00 12 15 04 0c ff ff 04 00  B_LNKA..........
  1100: 0a 01 5c 2e 5f 53 42 5f 4c 4e 4b 42 0a 00 12 15  ..\._SB_LNKB....
  1110: 04 0c ff ff 04 00 0a 02 5c 2e 5f 53 42 5f 4c 4e  ........\._SB_LN
  1120: 4b 43 0a 00 12 15 04 0c ff ff 04 00 0a 03 5c 2e  KC............\.
  1130: 5f 53 42 5f 4c 4e 4b 44 0a 00 08 41 50 49 43 12  _SB_LNKD...APIC.
  1140: 4b 1f 24 12 0d 04 0c ff ff 0c 00 0a 00 0a 00 0a  K.$.............
  1150: 10 12 0d 04 0c ff ff 0c 00 0a 01 0a 00 0a 11 12  ................
  1160: 0d 04 0c ff ff 0c 00 0a 02 0a 00 0a 12 12 0d 04  ................
  1170: 0c ff ff 0c 00 0a 03 0a 00 0a 13 12 0d 04 0c ff  ................
  1180: ff 0b 00 0a 00 0a 00 0a 11 12 0d 04 0c ff ff 0b  ................
  1190: 00 0a 01 0a 00 0a 12 12 0d 04 0c ff ff 0b 00 0a  ................
  11a0: 02 0a 00 0a 13 12 0d 04 0c ff ff 0b 00 0a 03 0a  ................
  11b0: 00 0a 10 12 0d 04 0c ff ff 0a 00 0a 00 0a 00 0a  ................
  11c0: 12 12 0d 04 0c ff ff 0a 00 0a 01 0a 00 0a 13 12  ................
  11d0: 0d 04 0c ff ff 0a 00 0a 02 0a 00 0a 10 12 0d 04  ................
  11e0: 0c ff ff 0a 00 0a 03 0a 00 0a 11 12 0d 04 0c ff  ................
  11f0: ff 09 00 0a 00 0a 00 0a 13 12 0d 04 0c ff ff 09  ................
  1200: 00 0a 01 0a 00 0a 10 12 0d 04 0c ff ff 09 00 0a  ................
  1210: 02 0a 00 0a 11 12 0d 04 0c ff ff 09 00 0a 03 0a  ................
  1220: 00 0a 12 12 0d 04 0c ff ff 0d 00 0a 00 0a 00 0a  ................
  1230: 13 12 0d 04 0c ff ff 0d 00 0a 01 0a 00 0a 10 12  ................
  1240: 0d 04 0c ff ff 0d 00 0a 02 0a 00 0a 11 12 0d 04  ................
  1250: 0c ff ff 0d 00 0a 03 0a 00 0a 12 12 0d 04 0c ff  ................
  1260: ff 12 00 0a 00 0a 00 0a 10 12 0d 04 0c ff ff 12  ................
  1270: 00 0a 01 0a 00 0a 11 12 0d 04 0c ff ff 12 00 0a  ................
  1280: 02 0a 00 0a 12 12 0d 04 0c ff ff 12 00 0a 03 0a  ................
  1290: 00 0a 13 12 0d 04 0c ff ff 11 00 0a 00 0a 00 0a  ................
  12a0: 11 12 0d 04 0c ff ff 11 00 0a 01 0a 00 0a 12 12  ................
  12b0: 0d 04 0c ff ff 11 00 0a 02 0a 00 0a 13 12 0d 04  ................
  12c0: 0c ff ff 11 00 0a 03 0a 00 0a 10 12 0d 04 0c ff  ................
  12d0: ff 01 00 0a 00 0a 00 0a 10 12 0d 04 0c ff ff 01  ................
  12e0: 00 0a 01 0a 00 0a 11 12 0d 04 0c ff ff 01 00 0a  ................
  12f0: 02 0a 00 0a 12 12 0d 04 0c ff ff 01 00 0a 03 0a  ................
  1300: 00 0a 13 12 0d 04 0c ff ff 04 00 0a 00 0a 00 0a  ................
  1310: 10 12 0d 04 0c ff ff 04 00 0a 01 0a 00 0a 11 12  ................
  1320: 0d 04 0c ff ff 04 00 0a 02 0a 00 0a 12 12 0d 04  ................
  1330: 0c ff ff 04 00 0a 03 0a 00 0a 13 14 0b 5f 50 52  ............._PR
  1340: 54 00 a4 50 49 43 4d 5b 82 41 39 49 44 45 30 08  T..PICM[.A9IDE0.
  1350: 5f 41 44 52 0c 01 00 04 00 08 50 49 4f 54 12 0e  _ADR......PIOT..
  1360: 05 0b 58 02 0b 7c 01 0a f0 0a b4 0a 78 08 55 44  ..X..|......x.UD
  1370: 4d 54 12 0e 06 0a 78 0a 50 0a 3c 0a 2d 0a 1e 0a  MT....x.P.<.-...
  1380: 14 14 44 08 43 56 44 52 03 08 47 54 46 42 11 11  ..D.CVDR..GTFB..
  1390: 0a 0e 03 00 00 00 00 00 ef 03 00 00 00 00 00 ef  ................
  13a0: 8c 47 54 46 42 0a 01 4d 44 44 4d 8c 47 54 46 42  .GTFB..MDDM.GTFB
  13b0: 0a 05 44 52 44 4d 8c 47 54 46 42 0a 08 4d 44 50  ..DRDM.GTFB..MDP
  13c0: 49 8c 47 54 46 42 0a 0c 44 52 50 49 a0 0e 92 93  I.GTFB..DRPI....
  13d0: 69 0a 0f 7d 69 0a 40 4d 44 44 4d a1 11 70 68 60  i..}i.@MDDM..ph`
  13e0: 74 60 0a 02 60 7d 60 0a 20 4d 44 44 4d 70 6a 44  t`..`}`. MDDMpjD
  13f0: 52 44 4d 7d 68 0a 08 4d 44 50 49 70 6a 44 52 50  RDM}h..MDPIpjDRP
  1400: 49 a4 47 54 46 42 14 4b 05 53 55 44 4d 03 7b 6a  I.GTFB.K.SUDM.{j
  1410: 0a 01 60 a0 06 60 70 0a 04 60 a1 05 70 0a 01 60  ..`..`p..`..p..`
  1420: 7b 68 60 60 a0 28 60 70 89 55 44 4d 54 01 69 00  {h``.(`p.UDMT.i.
  1430: 0a 00 0a 00 60 a0 17 92 93 60 ff 70 6a 54 52 44  ....`....`.pjTRD
  1440: 30 70 60 54 52 44 31 49 53 4d 49 0a 08 a1 14 70  0p`TRD1ISMI....p
  1450: 6a 54 52 44 30 70 0a ff 54 52 44 31 49 53 4d 49  jTRD0p..TRD1ISMI
  1460: 0a 08 14 49 0f 47 54 4d 43 04 08 42 55 30 30 11  ...I.GTMC..BU00.
  1470: 17 0a 14 ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  1480: ff ff ff 00 00 00 00 8a 42 55 30 30 0a 00 50 49  ........BU00..PI
  1490: 4f 30 8a 42 55 30 30 0a 04 44 4d 41 30 8a 42 55  O0.BU00..DMA0.BU
  14a0: 30 30 0a 08 50 49 4f 31 8a 42 55 30 30 0a 0c 44  00..PIO1.BU00..D
  14b0: 4d 41 31 8a 42 55 30 30 0a 10 46 4c 41 47 70 0a  MA1.BU00..FLAGp.
  14c0: 10 46 4c 41 47 a0 1e 92 93 68 0a 0f 70 83 88 50  .FLAG....h..p..P
  14d0: 49 4f 54 68 00 50 49 4f 30 7d 46 4c 41 47 0a 02  IOTh.PIO0}FLAG..
  14e0: 46 4c 41 47 a0 1e 92 93 69 0a 0f 70 83 88 55 44  FLAG....i..p..UD
  14f0: 4d 54 69 00 44 4d 41 30 7d 46 4c 41 47 0a 01 46  MTi.DMA0}FLAG..F
  1500: 4c 41 47 a1 0a 70 50 49 4f 30 44 4d 41 30 a0 1e  LAG..pPIO0DMA0..
  1510: 92 93 6a 0a 0f 70 83 88 50 49 4f 54 6a 00 50 49  ..j..p..PIOTj.PI
  1520: 4f 31 7d 46 4c 41 47 0a 08 46 4c 41 47 a0 1e 92  O1}FLAG..FLAG...
  1530: 93 6b 0a 0f 70 83 88 55 44 4d 54 6b 00 44 4d 41  .k..p..UDMTk.DMA
  1540: 31 7d 46 4c 41 47 0a 04 46 4c 41 47 a1 0a 70 50  1}FLAG..FLAG..pP
  1550: 49 4f 31 44 4d 41 31 a4 42 55 30 30 5b 82 4d 0b  IO1DMA1.BU00[.M.
  1560: 43 48 4e 30 08 5f 41 44 52 0a 00 14 1b 5f 47 54  CHN0._ADR...._GT
  1570: 4d 00 a4 47 54 4d 43 48 43 50 49 48 43 55 44 48  M..GTMCHCPIHCUDH
  1580: 44 50 49 48 44 55 44 14 4b 04 5f 53 54 4d 03 8a  DPIHDUD.K._STM..
  1590: 68 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41 30 8a  h..PIO0.h..DMA0.
  15a0: 68 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41 31 8a  h..PIO1.h..DMA1.
  15b0: 68 0a 10 46 4c 41 47 53 55 44 4d 46 4c 41 47 44  h..FLAGSUDMFLAGD
  15c0: 4d 41 30 0a 00 53 55 44 4d 46 4c 41 47 44 4d 41  MA0..SUDMFLAGDMA
  15d0: 31 0a 01 5b 82 22 44 52 56 30 08 5f 41 44 52 0a  1..[."DRV0._ADR.
  15e0: 00 14 15 5f 47 54 46 00 a4 43 56 44 52 48 43 50  ..._GTF..CVDRHCP
  15f0: 49 48 43 55 44 0a a0 5b 82 22 44 52 56 31 08 5f  IHCUD..[."DRV1._
  1600: 41 44 52 0a 01 14 15 5f 47 54 46 00 a4 43 56 44  ADR...._GTF..CVD
  1610: 52 48 44 50 49 48 44 55 44 0a b0 5b 82 4d 0b 43  RHDPIHDUD..[.M.C
  1620: 48 4e 31 08 5f 41 44 52 0a 01 14 1b 5f 47 54 4d  HN1._ADR...._GTM
  1630: 00 a4 47 54 4d 43 48 45 50 49 48 45 55 44 48 46  ..GTMCHEPIHEUDHF
  1640: 50 49 48 46 55 44 14 4b 04 5f 53 54 4d 03 8a 68  PIHFUD.K._STM..h
  1650: 0a 00 50 49 4f 30 8a 68 0a 04 44 4d 41 30 8a 68  ..PIO0.h..DMA0.h
  1660: 0a 08 50 49 4f 31 8a 68 0a 0c 44 4d 41 31 8a 68  ..PIO1.h..DMA1.h
  1670: 0a 10 46 4c 41 47 53 55 44 4d 46 4c 41 47 44 4d  ..FLAGSUDMFLAGDM
  1680: 41 30 0a 02 53 55 44 4d 46 4c 41 47 44 4d 41 31  A0..SUDMFLAGDMA1
  1690: 0a 03 5b 82 22 44 52 56 30 08 5f 41 44 52 0a 00  ..[."DRV0._ADR..
  16a0: 14 15 5f 47 54 46 00 a4 43 56 44 52 48 45 50 49  .._GTF..CVDRHEPI
  16b0: 48 45 55 44 0a a0 5b 82 22 44 52 56 31 08 5f 41  HEUD..[."DRV1._A
  16c0: 44 52 0a 01 14 15 5f 47 54 46 00 a4 43 56 44 52  DR...._GTF..CVDR
  16d0: 48 46 50 49 48 46 55 44 0a b0 5b 82 83 1c 01 50  HFPIHFUD..[....P
  16e0: 58 34 30 08 5f 41 44 52 0c 00 00 04 00 5b 80 49  X40._ADR.....[.I
  16f0: 4f 43 47 02 0a 48 0a 0b 5b 81 31 49 4f 43 47 01  OCG..H..[.1IOCG.
  1700: 00 02 45 55 53 42 01 00 05 00 38 46 4c 44 41 02  ..EUSB....8FLDA.
  1710: 4c 50 44 41 02 00 04 46 4c 49 52 04 4c 50 49 52  LPDA...FLIR.LPIR
  1720: 04 55 31 49 52 04 55 32 49 52 04 5b 80 50 49 52  .U1IR.U2IR.[.PIR
  1730: 51 02 0a 55 0a 03 5b 81 1e 50 49 52 51 01 00 04  Q..U..[..PIRQ...
  1740: 50 49 52 41 04 50 49 52 42 04 50 49 52 43 04 00  PIRA.PIRB.PIRC..
  1750: 04 50 49 52 44 04 5b 80 4d 46 45 4e 02 0a 85 0a  .PIRD.[.MFEN....
  1760: 01 5b 81 21 4d 46 45 4e 01 49 4f 45 4e 01 45 4e  .[.!MFEN.IOEN.EN
  1770: 32 43 01 46 55 4e 35 01 46 55 4e 36 01 46 55 4e  2C.FUN5.FUN6.FUN
  1780: 33 01 00 03 5b 80 50 43 53 45 02 0a 8b 0a 01 5b  3...[.PCSE.....[
  1790: 81 0d 50 43 53 45 01 50 43 53 30 01 00 07 5b 82  ..PCSE.PCS0...[.
  17a0: 40 09 53 59 53 31 08 5f 48 49 44 0c 41 d0 0c 02  @.SYS1._HID.A...
  17b0: 08 5f 55 49 44 0a 01 14 48 07 5f 43 52 53 00 08  ._UID...H._CRS..
  17c0: 42 55 46 31 11 46 06 0a 62 47 01 10 00 10 00 00  BUF1.F..bG......
  17d0: 10 47 01 22 00 22 00 00 0c 47 01 30 00 30 00 00  .G."."...G.0.0..
  17e0: 10 47 01 44 00 44 00 00 1c 47 01 62 00 62 00 00  .G.D.D...G.b.b..
  17f0: 02 47 01 65 00 65 00 00 0b 47 01 74 00 74 00 00  .G.e.e...G.t.t..
  1800: 0c 47 01 91 00 91 00 00 03 47 01 a2 00 a2 00 00  .G.......G......
  1810: 1e 47 01 e0 00 e0 00 00 10 47 01 f0 03 f0 03 00  .G.......G......
  1820: 02 47 01 d0 04 d0 04 00 02 79 00 a4 42 55 46 31  .G.......y..BUF1
  1830: 5b 82 3d 53 59 53 32 08 5f 48 49 44 0c 41 d0 0c  [.=SYS2._HID.A..
  1840: 02 08 5f 55 49 44 0a 02 14 26 5f 43 52 53 00 08  .._UID...&_CRS..
  1850: 42 55 46 31 11 15 0a 12 47 01 00 e4 00 e4 01 80  BUF1....G.......
  1860: 47 01 00 e8 00 e8 01 10 79 00 a4 42 55 46 31 5b  G.......y..BUF1[
  1870: 82 41 08 53 59 53 33 08 5f 48 49 44 0c 41 d0 0c  .A.SYS3._HID.A..
  1880: 02 08 5f 55 49 44 0a 03 14 4e 04 5f 53 54 41 00  .._UID...N._STA.
  1890: 7b 4e 50 53 32 0a 10 60 7b 4e 50 53 32 0a 08 61  {NPS2..`{NPS2..a
  18a0: a0 13 93 61 0a 08 a0 08 93 60 0a 10 a4 0a 0f a1  ...a.....`......
  18b0: 04 a4 0a 00 a1 22 7b 46 4c 47 30 0a 04 61 a0 08  ....."{FLG0..a..
  18c0: 93 61 0a 04 a4 0a 00 a1 0f a0 08 93 60 0a 10 a4  .a..........`...
  18d0: 0a 0f a1 04 a4 0a 00 14 1a 5f 43 52 53 00 08 42  ........._CRS..B
  18e0: 55 46 31 11 09 0a 06 23 00 10 01 79 00 a4 42 55  UF1....#...y..BU
  18f0: 46 31 5b 82 2b 50 49 43 5f 08 5f 48 49 44 0b 41  F1[.+PIC_._HID.A
  1900: d0 08 5f 43 52 53 11 18 0a 15 47 01 20 00 20 00  .._CRS....G. . .
  1910: 01 02 47 01 a0 00 a0 00 01 02 22 04 00 79 00 5b  ..G......."..y.[
  1920: 82 3d 44 4d 41 31 08 5f 48 49 44 0c 41 d0 02 00  .=DMA1._HID.A...
  1930: 08 5f 43 52 53 11 28 0a 25 2a 10 04 47 01 00 00  ._CRS.(.%*..G...
  1940: 00 00 01 10 47 01 80 00 80 00 01 11 47 01 94 00  ....G.......G...
  1950: 94 00 01 0c 47 01 c0 00 c0 00 01 20 79 00 5b 82  ....G...... y.[.
  1960: 25 54 4d 52 5f 08 5f 48 49 44 0c 41 d0 01 00 08  %TMR_._HID.A....
  1970: 5f 43 52 53 11 10 0a 0d 47 01 40 00 40 00 01 04  _CRS....G.@.@...
  1980: 22 01 00 79 00 5b 82 25 52 54 43 5f 08 5f 48 49  "..y.[.%RTC_._HI
  1990: 44 0c 41 d0 0b 00 08 5f 43 52 53 11 10 0a 0d 47  D.A...._CRS....G
  19a0: 01 70 00 70 00 01 04 22 00 01 79 00 5b 82 22 53  .p.p..."..y.[."S
  19b0: 50 4b 52 08 5f 48 49 44 0c 41 d0 08 00 08 5f 43  PKR._HID.A...._C
  19c0: 52 53 11 0d 0a 0a 47 01 61 00 61 00 01 01 79 00  RS....G.a.a...y.
  19d0: 5b 82 25 43 4f 50 52 08 5f 48 49 44 0c 41 d0 0c  [.%COPR._HID.A..
  19e0: 04 08 5f 43 52 53 11 10 0a 0d 47 01 f0 00 f0 00  .._CRS....G.....
  19f0: 01 10 22 00 20 79 00 5b 80 56 36 38 36 01 0b f0  ..". y.[.V686...
  1a00: 03 0a 02 5b 81 10 56 36 38 36 01 4e 49 44 58 08  ...[..V686.NIDX.
  1a10: 4e 44 41 54 08 5b 86 47 05 4e 49 44 58 4e 44 41  NDAT.[.G.NIDXNDA
  1a20: 54 01 00 40 70 49 4f 49 44 08 49 4f 56 52 08 49  T..@pIOID.IOVR.I
  1a30: 4f 46 4e 08 46 43 49 4f 08 00 10 50 50 49 4f 08  OFN.FCIO...PPIO.
  1a40: 53 31 49 4f 08 53 32 49 4f 08 00 28 53 50 43 47  S1IO.S2IO..(SPCG
  1a50: 08 50 44 43 54 08 50 50 43 54 08 53 50 43 54 08  .PDCT.PPCT.SPCT.
  1a60: 00 20 46 43 43 47 08 00 08 46 44 43 54 08 5b 80  . FCCG...FDCT.[.
  1a70: 50 43 49 43 01 0b f8 0c 0a 08 5b 81 10 50 43 49  PCIC......[..PCI
  1a80: 43 03 50 49 4e 44 20 50 44 41 54 20 14 0c 45 4e  C.PIND PDAT ..EN
  1a90: 46 47 00 70 01 45 4e 32 43 14 0c 45 58 46 47 00  FG.p.EN2C..EXFG.
  1aa0: 70 00 45 4e 32 43 5b 82 4a 1d 46 44 43 30 08 5f  p.EN2C[.J.FDC0._
  1ab0: 48 49 44 0c 41 d0 07 00 14 43 05 5f 53 54 41 00  HID.A....C._STA.
  1ac0: 70 49 4f 45 4e 60 a0 07 93 60 00 a4 0a 00 a1 3d  pIOEN`...`.....=
  1ad0: 45 4e 46 47 70 49 4f 46 4e 60 7b 60 0a 10 60 a0  ENFGpIOFN`{`..`.
  1ae0: 0d 92 93 60 0a 00 45 58 46 47 a4 0a 0f a1 1e 70  ...`..EXFG.....p
  1af0: 46 43 49 4f 61 a0 0d 92 93 61 0a 00 45 58 46 47  FCIOa....a..EXFG
  1b00: a4 0a 0d a1 08 45 58 46 47 a4 0a 00 14 1f 5f 44  .....EXFG....._D
  1b10: 49 53 00 45 4e 46 47 70 49 4f 46 4e 60 7b 60 0a  IS.ENFGpIOFN`{`.
  1b20: ef 60 70 60 49 4f 46 4e 45 58 46 47 14 42 08 5f  .`p`IOFNEXFG.B._
  1b30: 43 52 53 00 08 42 55 46 30 11 1c 0a 19 47 01 f2  CRS..BUF0....G..
  1b40: 03 f2 03 00 04 47 01 f7 03 f7 03 00 01 23 40 00  .....G.......#@.
  1b50: 01 2a 04 00 79 00 8b 42 55 46 30 0a 11 49 52 51  .*..y..BUF0..IRQ
  1b60: 57 8c 42 55 46 30 0a 15 44 4d 41 56 70 5c 2f 04  W.BUF0..DMAVp\/.
  1b70: 5f 53 42 5f 50 43 49 30 50 58 34 30 46 4c 49 52  _SB_PCI0PX40FLIR
  1b80: 60 70 01 61 79 61 60 49 52 51 57 70 5c 2f 04 5f  `p.aya`IRQWp\/._
  1b90: 53 42 5f 50 43 49 30 50 58 34 30 46 4c 44 41 60  SB_PCI0PX40FLDA`
  1ba0: 70 01 61 79 61 60 44 4d 41 56 a4 42 55 46 30 08  p.aya`DMAV.BUF0.
  1bb0: 5f 50 52 53 11 1c 0a 19 47 01 f2 03 f2 03 00 04  _PRS....G.......
  1bc0: 47 01 f7 03 f7 03 00 01 23 40 00 01 2a 04 00 79  G.......#@..*..y
  1bd0: 00 14 40 0b 5f 53 52 53 01 8c 68 0a 02 49 4f 4c  ..@._SRS..h..IOL
  1be0: 4f 8c 68 0a 03 49 4f 48 49 8b 68 0a 11 49 52 51  O.h..IOHI.h..IRQ
  1bf0: 57 8c 68 0a 15 44 4d 41 56 45 4e 46 47 70 49 4f  W.h..DMAVENFGpIO
  1c00: 46 4e 60 7b 60 0a ef 61 70 61 49 4f 46 4e 70 49  FN`{`..apaIOFNpI
  1c10: 4f 4c 4f 60 7a 60 0a 02 60 7b 60 0a fc 60 70 49  OLO`z`..`{`..`pI
  1c20: 4f 48 49 61 79 61 0a 06 61 7d 60 61 60 70 60 46  OHIaya..a}`a`p`F
  1c30: 43 49 4f 82 49 52 51 57 60 76 60 70 60 5c 2f 04  CIO.IRQW`v`p`\/.
  1c40: 5f 53 42 5f 50 43 49 30 50 58 34 30 46 4c 49 52  _SB_PCI0PX40FLIR
  1c50: 82 44 4d 41 56 60 76 60 70 60 5c 2f 04 5f 53 42  .DMAV`v`p`\/._SB
  1c60: 5f 50 43 49 30 50 58 34 30 46 4c 44 41 70 49 4f  _PCI0PX40FLDApIO
  1c70: 46 4e 60 7d 60 0a 10 61 70 61 49 4f 46 4e 45 58  FN`}`..apaIOFNEX
  1c80: 46 47 5b 82 46 1f 4c 50 54 5f 08 5f 48 49 44 0c  FG[.F.LPT_._HID.
  1c90: 41 d0 04 00 14 49 05 5f 53 54 41 00 a0 09 92 49  A....I._STA....I
  1ca0: 4f 45 4e a4 0a 00 45 4e 46 47 70 49 4f 46 4e 60  OEN...ENFGpIOFN`
  1cb0: 7b 60 0a 01 60 a0 09 60 45 58 46 47 a4 0a 00 a1  {`..`..`EXFG....
  1cc0: 2e a0 23 50 50 49 4f 7b 50 44 43 54 0a 10 60 a0  ..#PPIO{PDCT..`.
  1cd0: 0c 93 60 0a 10 45 58 46 47 a4 0a 0d a1 08 45 58  ..`..EXFG.....EX
  1ce0: 46 47 a4 0a 0f a1 08 45 58 46 47 a4 0a 00 14 19  FG.....EXFG.....
  1cf0: 5f 44 49 53 00 45 4e 46 47 7d 50 44 43 54 0a 10  _DIS.ENFG}PDCT..
  1d00: 50 44 43 54 45 58 46 47 14 42 0c 5f 43 52 53 00  PDCTEXFG.B._CRS.
  1d10: 08 42 55 46 45 11 10 0a 0d 47 01 78 03 78 03 08  .BUFE....G.x.x..
  1d20: 08 22 80 00 79 00 8b 42 55 46 45 0a 02 49 4d 49  ."..y..BUFE..IMI
  1d30: 31 8b 42 55 46 45 0a 04 49 4d 41 31 8c 42 55 46  1.BUFE..IMA1.BUF
  1d40: 45 0a 06 41 4c 4e 31 8c 42 55 46 45 0a 07 4c 45  E..ALN1.BUFE..LE
  1d50: 4e 31 8b 42 55 46 45 0a 09 49 52 51 30 45 4e 46  N1.BUFE..IRQ0ENF
  1d60: 47 70 50 50 49 4f 60 45 58 46 47 70 60 61 7b 61  GpPPIO`EXFGp`a{a
  1d70: 0a c0 61 79 61 0a 02 61 79 60 0a 02 60 7d 60 61  ..aya..ay`..`}`a
  1d80: 60 70 60 49 4d 49 31 70 60 49 4d 41 31 a0 17 93  `p`IMI1p`IMA1...
  1d90: 49 4d 49 31 0b bc 03 70 0a 04 41 4c 4e 31 70 0a  IMI1...p..ALN1p.
  1da0: 04 4c 45 4e 31 a1 0f 70 0a 08 41 4c 4e 31 70 0a  .LEN1..p..ALN1p.
  1db0: 08 4c 45 4e 31 70 4c 50 49 52 60 70 0a 01 61 79  .LEN1pLPIR`p..ay
  1dc0: 61 60 49 52 51 30 a4 42 55 46 45 08 5f 50 52 53  a`IRQ0.BUFE._PRS
  1dd0: 11 2a 0a 27 30 47 01 78 03 78 03 08 08 22 a0 00  .*.'0G.x.x..."..
  1de0: 30 47 01 78 02 78 02 08 08 22 a0 00 30 47 01 bc  0G.x.x..."..0G..
  1df0: 03 bc 03 04 04 22 a0 00 38 79 00 14 4e 07 5f 53  ....."..8y..N._S
  1e00: 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a 03 49  RS..h..IOLO.h..I
  1e10: 4f 48 49 8b 68 0a 09 49 52 51 30 45 4e 46 47 70  OHI.h..IRQ0ENFGp
  1e20: 49 4f 46 4e 62 7d 62 0a 03 63 70 63 49 4f 46 4e  IOFNb}b..cpcIOFN
  1e30: 70 49 4f 4c 4f 60 7a 60 0a 02 60 70 49 4f 48 49  pIOLO`z`..`pIOHI
  1e40: 61 79 61 0a 06 61 7d 60 61 60 70 60 50 50 49 4f  aya..a}`a`p`PPIO
  1e50: 82 49 52 51 30 60 a0 08 92 93 60 0a 00 76 60 70  .IRQ0`....`..v`p
  1e60: 60 4c 50 49 52 70 62 49 4f 46 4e 7b 50 44 43 54  `LPIRpbIOFN{PDCT
  1e70: 0a ef 50 44 43 54 45 58 46 47 5b 82 4c 28 45 43  ..PDCTEXFG[.L(EC
  1e80: 50 5f 08 5f 48 49 44 0c 41 d0 04 01 14 4c 05 5f  P_._HID.A....L._
  1e90: 53 54 41 00 a0 09 92 49 4f 45 4e a4 0a 00 45 4e  STA....IOEN...EN
  1ea0: 46 47 70 49 4f 46 4e 60 7b 60 0a 03 60 a0 32 93  FGpIOFN`{`..`.2.
  1eb0: 60 0a 01 a0 23 50 50 49 4f 7b 50 44 43 54 0a 10  `...#PPIO{PDCT..
  1ec0: 60 a0 0c 93 60 0a 10 45 58 46 47 a4 0a 0d a1 08  `...`..EXFG.....
  1ed0: 45 58 46 47 a4 0a 0f a1 08 45 58 46 47 a4 0a 00  EXFG.....EXFG...
  1ee0: a1 08 45 58 46 47 a4 0a 00 14 19 5f 44 49 53 00  ..EXFG....._DIS.
  1ef0: 45 4e 46 47 7d 50 44 43 54 0a 10 50 44 43 54 45  ENFG}PDCT..PDCTE
  1f00: 58 46 47 14 46 11 5f 43 52 53 00 08 42 55 46 45  XFG.F._CRS..BUFE
  1f10: 11 1b 0a 18 47 01 78 03 78 03 08 08 47 01 78 07  ....G.x.x...G.x.
  1f20: 78 07 04 04 22 80 00 2a 08 00 79 00 8b 42 55 46  x..."..*..y..BUF
  1f30: 45 0a 02 49 4d 49 31 8b 42 55 46 45 0a 04 49 4d  E..IMI1.BUFE..IM
  1f40: 41 31 8c 42 55 46 45 0a 06 41 4c 4e 31 8c 42 55  A1.BUFE..ALN1.BU
  1f50: 46 45 0a 07 4c 45 4e 31 8b 42 55 46 45 0a 0a 49  FE..LEN1.BUFE..I
  1f60: 4d 49 32 8b 42 55 46 45 0a 0c 49 4d 41 32 8b 42  MI2.BUFE..IMA2.B
  1f70: 55 46 45 0a 11 49 52 51 30 8c 42 55 46 45 0a 14  UFE..IRQ0.BUFE..
  1f80: 44 4d 41 30 45 4e 46 47 70 50 50 49 4f 60 45 58  DMA0ENFGpPPIO`EX
  1f90: 46 47 70 60 61 7b 61 0a c0 61 79 61 0a 02 61 79  FGp`a{a..aya..ay
  1fa0: 60 0a 02 60 7d 60 61 60 70 60 49 4d 49 31 70 60  `..`}`a`p`IMI1p`
  1fb0: 49 4d 41 31 72 60 0b 00 04 60 70 60 49 4d 49 32  IMA1r`...`p`IMI2
  1fc0: 70 60 49 4d 41 32 a0 17 93 49 4d 49 31 0b bc 03  p`IMA2...IMI1...
  1fd0: 70 0a 04 41 4c 4e 31 70 0a 04 4c 45 4e 31 a1 0f  p..ALN1p..LEN1..
  1fe0: 70 0a 08 41 4c 4e 31 70 0a 08 4c 45 4e 31 70 4c  p..ALN1p..LEN1pL
  1ff0: 50 49 52 60 70 0a 01 61 79 61 60 49 52 51 30 70  PIR`p..aya`IRQ0p
  2000: 4c 50 44 41 60 7b 60 0a 03 60 70 0a 01 61 79 61  LPDA`{`..`p..aya
  2010: 60 44 4d 41 30 a4 42 55 46 45 08 5f 50 52 53 11  `DMA0.BUFE._PRS.
  2020: 4c 04 0a 48 30 47 01 78 03 78 03 08 08 47 01 78  L..H0G.x.x...G.x
  2030: 07 78 07 04 04 22 a0 00 2a 0b 00 30 47 01 78 02  .x..."..*..0G.x.
  2040: 78 02 08 08 47 01 78 06 78 06 04 04 22 a0 00 2a  x...G.x.x..."..*
  2050: 0b 00 30 47 01 bc 03 bc 03 04 04 47 01 bc 07 bc  ..0G.......G....
  2060: 07 04 04 22 a0 00 2a 0b 00 38 79 00 14 4b 09 5f  ..."..*..8y..K._
  2070: 53 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a 03  SRS..h..IOLO.h..
  2080: 49 4f 48 49 8b 68 0a 11 49 52 51 30 8c 68 0a 14  IOHI.h..IRQ0.h..
  2090: 44 4d 41 30 45 4e 46 47 70 49 4f 46 4e 62 7d 62  DMA0ENFGpIOFNb}b
  20a0: 0a 03 63 70 63 49 4f 46 4e 70 49 4f 4c 4f 60 7a  ..cpcIOFNpIOLO`z
  20b0: 60 0a 02 60 70 49 4f 48 49 61 79 61 0a 06 61 7d  `..`pIOHIaya..a}
  20c0: 60 61 60 70 60 50 50 49 4f 82 49 52 51 30 60 a0  `a`p`PPIO.IRQ0`.
  20d0: 08 92 93 60 0a 00 76 60 70 60 4c 50 49 52 82 44  ...`..v`p`LPIR.D
  20e0: 4d 41 30 60 a0 08 92 93 60 0a 00 76 60 70 60 4c  MA0`....`..v`p`L
  20f0: 50 44 41 70 62 49 4f 46 4e 7b 50 44 43 54 0a ef  PDApbIOFN{PDCT..
  2100: 50 44 43 54 45 58 46 47 5b 82 4d 22 55 41 52 31  PDCTEXFG[.M"UAR1
  2110: 08 5f 48 49 44 0c 41 d0 05 01 08 5f 55 49 44 0a  ._HID.A...._UID.
  2120: 01 14 44 05 5f 53 54 41 00 70 49 4f 45 4e 60 a0  ..D._STA.pIOEN`.
  2130: 08 93 60 0a 00 a4 0a 00 a1 3d 45 4e 46 47 70 49  ..`......=ENFGpI
  2140: 4f 46 4e 60 7b 60 0a 04 60 a0 0d 92 93 60 0a 00  OFN`{`..`....`..
  2150: 45 58 46 47 a4 0a 0f a1 1e 70 53 31 49 4f 61 a0  EXFG.....pS1IOa.
  2160: 0d 92 93 61 0a 00 45 58 46 47 a4 0a 0d a1 08 45  ...a..EXFG.....E
  2170: 58 46 47 a4 0a 00 14 19 5f 44 49 53 00 45 4e 46  XFG....._DIS.ENF
  2180: 47 7b 49 4f 46 4e 0a fb 49 4f 46 4e 45 58 46 47  G{IOFN..IOFNEXFG
  2190: 14 49 0b 5f 43 52 53 00 08 42 55 46 31 11 11 0a  .I._CRS..BUF1...
  21a0: 0e 47 01 f8 03 f8 03 00 08 23 10 00 01 79 00 8c  .G.......#...y..
  21b0: 42 55 46 31 0a 02 49 4f 4c 4f 8c 42 55 46 31 0a  BUF1..IOLO.BUF1.
  21c0: 03 49 4f 48 49 8c 42 55 46 31 0a 04 49 4f 52 4c  .IOHI.BUF1..IORL
  21d0: 8c 42 55 46 31 0a 05 49 4f 52 48 8b 42 55 46 31  .BUF1..IORH.BUF1
  21e0: 0a 09 49 52 51 57 45 4e 46 47 70 53 31 49 4f 60  ..IRQWENFGpS1IO`
  21f0: 70 53 31 49 4f 61 7b 61 0a c0 61 7a 61 0a 06 61  pS1IOa{a..aza..a
  2200: 7b 60 0a 3f 60 79 60 0a 02 60 70 60 49 4f 4c 4f  {`.?`y`..`p`IOLO
  2210: 70 60 49 4f 52 4c 70 61 49 4f 48 49 70 61 49 4f  p`IORLpaIOHIpaIO
  2220: 52 48 45 58 46 47 70 5c 2f 04 5f 53 42 5f 50 43  RHEXFGp\/._SB_PC
  2230: 49 30 50 58 34 30 55 31 49 52 60 70 01 61 79 61  I0PX40U1IR`p.aya
  2240: 60 49 52 51 57 a4 42 55 46 31 08 5f 50 52 53 11  `IRQW.BUF1._PRS.
  2250: 4d 04 0a 49 31 05 47 01 f8 03 f8 03 00 08 23 10  M..I1.G.......#.
  2260: 00 01 31 05 47 01 f8 02 f8 02 00 08 23 08 00 01  ..1.G.......#...
  2270: 31 05 47 01 e8 03 e8 03 00 08 23 10 00 01 31 05  1.G.......#...1.
  2280: 47 01 e8 02 e8 02 00 08 23 08 00 01 31 05 47 01  G.......#...1.G.
  2290: e8 02 f8 03 00 08 23 b8 14 01 38 79 00 14 4b 08  ......#...8y..K.
  22a0: 5f 53 52 53 01 8c 68 0a 02 49 4f 4c 4f 8c 68 0a  _SRS..h..IOLO.h.
  22b0: 03 49 4f 48 49 8b 68 0a 09 49 52 51 57 45 4e 46  .IOHI.h..IRQWENF
  22c0: 47 70 49 4f 46 4e 60 7b 60 0a fb 61 70 61 49 4f  GpIOFN`{`..apaIO
  22d0: 46 4e 70 49 4f 4c 4f 60 7a 60 0a 02 60 7b 60 0a  FNpIOLO`z`..`{`.
  22e0: fe 60 70 49 4f 48 49 61 79 61 0a 06 61 7d 60 61  .`pIOHIaya..a}`a
  22f0: 60 70 60 53 31 49 4f 82 49 52 51 57 60 76 60 70  `p`S1IO.IRQW`v`p
  2300: 60 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30  `\/._SB_PCI0PX40
  2310: 55 31 49 52 70 49 4f 46 4e 60 7d 60 0a 04 61 70  U1IRpIOFN`}`..ap
  2320: 61 49 4f 46 4e 45 58 46 47 14 0d 5f 50 52 57 00  aIOFNEXFG.._PRW.
  2330: a4 53 50 52 57 0a 08 5b 82 46 25 55 41 52 32 08  .SPRW..[.F%UAR2.
  2340: 5f 48 49 44 0c 41 d0 05 01 08 5f 55 49 44 0a 02  _HID.A...._UID..
  2350: 14 4c 06 5f 53 54 41 00 70 49 4f 45 4e 60 a0 08  .L._STA.pIOEN`..
  2360: 93 60 0a 00 a4 0a 00 a1 45 05 45 4e 46 47 70 53  .`......E.ENFGpS
  2370: 50 43 47 60 7b 60 0a 38 60 a0 3a 93 60 0a 00 70  PCG`{`.8`.:.`..p
  2380: 53 32 49 4f 61 a0 25 92 93 61 0a 00 7b 49 4f 46  S2IOa.%..a..{IOF
  2390: 4e 0a 08 62 a0 0d 92 93 62 0a 00 45 58 46 47 a4  N..b....b..EXFG.
  23a0: 0a 0f a1 08 45 58 46 47 a4 0a 0d a1 08 45 58 46  ....EXFG.....EXF
  23b0: 47 a4 0a 00 a1 08 45 58 46 47 a4 0a 00 14 2a 5f  G.....EXFG....*_
  23c0: 44 49 53 00 45 4e 46 47 70 53 50 43 47 60 7b 60  DIS.ENFGpSPCG`{`
  23d0: 0a 38 60 a0 10 93 60 0a 00 7b 49 4f 46 4e 0a f7  .8`...`..{IOFN..
  23e0: 49 4f 46 4e 45 58 46 47 14 49 0b 5f 43 52 53 00  IOFNEXFG.I._CRS.
  23f0: 08 42 55 46 31 11 11 0a 0e 47 01 f8 02 f8 02 00  .BUF1....G......
  2400: 08 23 08 00 01 79 00 8c 42 55 46 31 0a 02 49 4f  .#...y..BUF1..IO
  2410: 4c 4f 8c 42 55 46 31 0a 03 49 4f 48 49 8c 42 55  LO.BUF1..IOHI.BU
  2420: 46 31 0a 04 49 4f 52 4c 8c 42 55 46 31 0a 05 49  F1..IORL.BUF1..I
  2430: 4f 52 48 8b 42 55 46 31 0a 09 49 52 51 57 45 4e  ORH.BUF1..IRQWEN
  2440: 46 47 70 53 32 49 4f 60 70 53 32 49 4f 61 7b 61  FGpS2IO`pS2IOa{a
  2450: 0a c0 61 7a 61 0a 06 61 7b 60 0a 3f 60 79 60 0a  ..aza..a{`.?`y`.
  2460: 02 60 70 60 49 4f 4c 4f 70 60 49 4f 52 4c 70 61  .`p`IOLOp`IORLpa
  2470: 49 4f 48 49 70 61 49 4f 52 48 45 58 46 47 70 5c  IOHIpaIORHEXFGp\
  2480: 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 55 32  /._SB_PCI0PX40U2
  2490: 49 52 60 70 01 61 79 61 60 49 52 51 57 a4 42 55  IR`p.aya`IRQW.BU
  24a0: 46 31 08 5f 50 52 53 11 4d 04 0a 49 31 05 47 01  F1._PRS.M..I1.G.
  24b0: f8 02 f8 02 00 08 23 08 00 01 31 05 47 01 f8 03  ......#...1.G...
  24c0: f8 03 00 08 23 10 00 01 31 05 47 01 e8 02 e8 02  ....#...1.G.....
  24d0: 00 08 23 08 00 01 31 05 47 01 e8 03 e8 03 00 08  ..#...1.G.......
  24e0: 23 10 00 01 31 05 47 01 e8 02 f8 03 00 08 23 b8  #...1.G.......#.
  24f0: 14 01 38 79 00 14 4b 08 5f 53 52 53 01 8c 68 0a  ..8y..K._SRS..h.
  2500: 02 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8b 68 0a  .IOLO.h..IOHI.h.
  2510: 09 49 52 51 57 45 4e 46 47 70 49 4f 46 4e 60 7b  .IRQWENFGpIOFN`{
  2520: 60 0a f7 61 70 61 49 4f 46 4e 70 49 4f 4c 4f 60  `..apaIOFNpIOLO`
  2530: 7a 60 0a 02 60 7b 60 0a fe 60 70 49 4f 48 49 61  z`..`{`..`pIOHIa
  2540: 79 61 0a 06 61 7d 60 61 60 70 60 53 32 49 4f 82  ya..a}`a`p`S2IO.
  2550: 49 52 51 57 60 76 60 70 60 5c 2f 04 5f 53 42 5f  IRQW`v`p`\/._SB_
  2560: 50 43 49 30 50 58 34 30 55 32 49 52 70 49 4f 46  PCI0PX40U2IRpIOF
  2570: 4e 60 7d 60 0a 08 61 70 61 49 4f 46 4e 45 58 46  N`}`..apaIOFNEXF
  2580: 47 14 0d 5f 50 52 57 00 a4 53 50 52 57 0a 08 5b  G.._PRW..SPRW..[
  2590: 82 41 24 49 52 44 41 08 5f 48 49 44 0c 41 d0 05  .A$IRDA._HID.A..
  25a0: 10 14 4c 06 5f 53 54 41 00 70 49 4f 45 4e 60 a0  ..L._STA.pIOEN`.
  25b0: 08 93 60 0a 00 a4 0a 00 a1 45 05 45 4e 46 47 70  ..`......E.ENFGp
  25c0: 53 50 43 47 60 7b 60 0a 38 60 a0 3a 93 60 0a 08  SPCG`{`.8`.:.`..
  25d0: 70 53 32 49 4f 61 a0 25 92 93 61 0a 00 7b 49 4f  pS2IOa.%..a..{IO
  25e0: 46 4e 0a 08 62 a0 0d 92 93 62 0a 00 45 58 46 47  FN..b....b..EXFG
  25f0: a4 0a 0f a1 08 45 58 46 47 a4 0a 0d a1 08 45 58  .....EXFG.....EX
  2600: 46 47 a4 0a 00 a1 08 45 58 46 47 a4 0a 00 14 2a  FG.....EXFG....*
  2610: 5f 44 49 53 00 45 4e 46 47 70 53 50 43 47 60 7b  _DIS.ENFGpSPCG`{
  2620: 60 0a 38 60 a0 10 93 60 0a 08 7b 49 4f 46 4e 0a  `.8`...`..{IOFN.
  2630: f7 49 4f 46 4e 45 58 46 47 14 49 0b 5f 43 52 53  .IOFNEXFG.I._CRS
  2640: 00 08 42 55 46 31 11 11 0a 0e 47 01 f8 02 f8 02  ..BUF1....G.....
  2650: 00 08 23 08 00 01 79 00 8c 42 55 46 31 0a 02 49  ..#...y..BUF1..I
  2660: 4f 4c 4f 8c 42 55 46 31 0a 03 49 4f 48 49 8c 42  OLO.BUF1..IOHI.B
  2670: 55 46 31 0a 04 49 4f 52 4c 8c 42 55 46 31 0a 05  UF1..IORL.BUF1..
  2680: 49 4f 52 48 8b 42 55 46 31 0a 09 49 52 51 57 45  IORH.BUF1..IRQWE
  2690: 4e 46 47 70 53 32 49 4f 60 70 53 32 49 4f 61 7b  NFGpS2IO`pS2IOa{
  26a0: 61 0a c0 61 7a 61 0a 06 61 7b 60 0a 3f 60 79 60  a..aza..a{`.?`y`
  26b0: 0a 02 60 70 60 49 4f 4c 4f 70 60 49 4f 52 4c 70  ..`p`IOLOp`IORLp
  26c0: 61 49 4f 48 49 70 61 49 4f 52 48 45 58 46 47 70  aIOHIpaIORHEXFGp
  26d0: 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 55  \/._SB_PCI0PX40U
  26e0: 32 49 52 60 70 01 61 79 61 60 49 52 51 57 a4 42  2IR`p.aya`IRQW.B
  26f0: 55 46 31 08 5f 50 52 53 11 4d 04 0a 49 31 05 47  UF1._PRS.M..I1.G
  2700: 01 f8 02 f8 02 00 08 23 08 00 01 31 05 47 01 f8  .......#...1.G..
  2710: 03 f8 03 00 08 23 10 00 01 31 05 47 01 e8 02 e8  .....#...1.G....
  2720: 02 00 08 23 08 00 01 31 05 47 01 e8 03 e8 03 00  ...#...1.G......
  2730: 08 23 10 00 01 31 05 47 01 e8 02 f8 03 00 08 23  .#...1.G.......#
  2740: b8 14 01 38 79 00 14 4b 08 5f 53 52 53 01 8c 68  ...8y..K._SRS..h
  2750: 0a 02 49 4f 4c 4f 8c 68 0a 03 49 4f 48 49 8b 68  ..IOLO.h..IOHI.h
  2760: 0a 09 49 52 51 57 45 4e 46 47 70 49 4f 46 4e 60  ..IRQWENFGpIOFN`
  2770: 7b 60 0a f7 61 70 61 49 4f 46 4e 70 49 4f 4c 4f  {`..apaIOFNpIOLO
  2780: 60 7a 60 0a 02 60 7b 60 0a fe 60 70 49 4f 48 49  `z`..`{`..`pIOHI
  2790: 61 79 61 0a 06 61 7d 60 61 60 70 60 53 32 49 4f  aya..a}`a`p`S2IO
  27a0: 82 49 52 51 57 60 76 60 70 60 5c 2f 04 5f 53 42  .IRQW`v`p`\/._SB
  27b0: 5f 50 43 49 30 50 58 34 30 55 32 49 52 70 49 4f  _PCI0PX40U2IRpIO
  27c0: 46 4e 60 7d 60 0a 08 61 70 61 49 4f 46 4e 45 58  FN`}`..apaIOFNEX
  27d0: 46 47 5b 80 47 52 4d 31 00 0b b2 04 0a 01 5b 81  FG[.GRM1......[.
  27e0: 0b 47 52 4d 31 01 4e 50 53 32 08 5b 82 3a 50 53  .GRM1.NPS2.[.:PS
  27f0: 32 4b 08 5f 48 49 44 0c 41 d0 03 03 14 2a 5f 43  2K._HID.A....*_C
  2800: 52 53 00 08 42 55 46 30 11 19 0a 16 47 01 60 00  RS..BUF0....G.`.
  2810: 60 00 00 01 47 01 64 00 64 00 00 01 23 02 00 01  `...G.d.d...#...
  2820: 79 00 a4 42 55 46 30 5b 80 50 53 4d 47 00 0b 10  y..BUF0[.PSMG...
  2830: 04 0a 01 5b 81 0d 50 53 4d 47 01 00 02 50 53 32  ...[..PSMG...PS2
  2840: 45 01 5b 82 4b 05 50 53 32 4d 08 5f 48 49 44 0c  E.[.K.PS2M._HID.
  2850: 41 d0 0f 13 14 3c 5f 53 54 41 00 7b 4e 50 53 32  A....<_STA.{NPS2
  2860: 0a 08 60 a0 08 93 60 0a 08 a4 0a 00 a0 1f 92 93  ..`...`.........
  2870: 50 53 32 45 0a 00 7b 46 4c 47 30 0a 04 60 a0 08  PS2E..{FLG0..`..
  2880: 93 60 0a 04 a4 0a 0f a1 04 a4 0a 00 a1 04 a4 0a  .`..............
  2890: 00 08 5f 43 52 53 11 08 0a 05 22 00 10 79 00 5b  .._CRS...."..y.[
  28a0: 82 4a 04 50 58 34 33 08 5f 41 44 52 0c 04 00 04  .J.PX43._ADR....
  28b0: 00 5b 80 49 50 4d 55 02 0a 48 0a 02 5b 81 10 49  .[.IPMU..H..[..I
  28c0: 50 4d 55 01 50 4d 30 30 08 50 4d 30 31 08 5b 80  PMU.PM00.PM01.[.
  28d0: 49 53 4d 42 02 0a 90 0a 02 5b 81 10 49 53 4d 42  ISMB.....[..ISMB
  28e0: 01 53 42 30 30 08 53 42 30 31 08 5b 82 4d 06 42  .SB00.SB01.[.M.B
  28f0: 58 30 30 08 5f 41 44 52 0a 00 5b 80 49 44 52 42  X00._ADR..[.IDRB
  2900: 02 0a 57 0a 01 5b 81 0b 49 44 52 42 01 44 52 42  ..W..[..IDRB.DRB
  2910: 37 08 5b 80 50 4d 55 43 02 0a 78 0a 01 5b 81 0b  7.[.PMUC..x..[..
  2920: 50 4d 55 43 01 50 4d 43 52 08 5b 80 47 54 4c 42  PMUC.PMCR.[.GTLB
  2930: 02 0a 88 0a 04 5b 81 0b 47 54 4c 42 03 47 41 52  .....[..GTLB.GAR
  2940: 54 20 5b 80 41 47 50 43 02 0a a8 0a 04 5b 81 0b  T [.AGPC.....[..
  2950: 41 47 50 43 03 41 47 50 53 20 5b 82 4e 07 55 53  AGPC.AGPS [.N.US
  2960: 42 30 08 5f 41 44 52 0c 02 00 04 00 14 09 5f 53  B0._ADR......._S
  2970: 31 44 00 a4 0a 01 14 31 5f 53 33 44 00 a0 25 93  1D.....1_S3D..%.
  2980: 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73  SCMP\_OS_.Micros
  2990: 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00 00  oft Windows NT..
  29a0: a4 0a 03 a1 04 a4 0a 02 14 0d 5f 50 52 57 00 a4  .........._PRW..
  29b0: 53 50 52 57 0a 09 14 23 5f 53 54 41 00 a0 17 5c  SPRW...#_STA...\
  29c0: 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 45 55  /._SB_PCI0PX40EU
  29d0: 53 42 a4 0a 00 a1 04 a4 0a 0f 5b 82 4e 07 55 53  SB........[.N.US
  29e0: 42 31 08 5f 41 44 52 0c 03 00 04 00 14 09 5f 53  B1._ADR......._S
  29f0: 31 44 00 a4 0a 01 14 31 5f 53 33 44 00 a0 25 93  1D.....1_S3D..%.
  2a00: 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73  SCMP\_OS_.Micros
  2a10: 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00 00  oft Windows NT..
  2a20: a4 0a 03 a1 04 a4 0a 02 14 0d 5f 50 52 57 00 a4  .........._PRW..
  2a30: 53 50 52 57 0a 09 14 23 5f 53 54 41 00 a0 17 5c  SPRW...#_STA...\
  2a40: 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 46 55  /._SB_PCI0PX40FU
  2a50: 4e 33 a4 0a 00 a1 04 a4 0a 0f 5b 82 4c 0f 41 43  N3........[.L.AC
  2a60: 39 37 08 5f 41 44 52 0c 05 00 04 00 5b 80 41 43  97._ADR.....[.AC
  2a70: 46 4e 02 0a 42 0a 02 5b 81 30 41 43 46 4e 01 53  FN..B..[.0ACFN.S
  2a80: 42 45 4e 01 4d 44 45 4e 01 46 4d 45 4e 01 47 50  BEN.MDEN.FMEN.GP
  2a90: 45 4e 01 00 04 53 42 42 41 02 4d 44 42 41 02 53  EN...SBBA.MDBA.S
  2aa0: 42 44 41 02 53 42 49 51 02 5b 80 47 49 4f 50 02  BDA.SBIQ.[.GIOP.
  2ab0: 0a 4a 0a 02 5b 81 10 47 49 4f 50 01 49 4f 4c 42  .J..[..GIOP.IOLB
  2ac0: 08 49 4f 48 42 08 14 23 5f 53 54 41 00 a0 17 5c  .IOHB..#_STA...\
  2ad0: 2f 04 5f 53 42 5f 50 43 49 30 50 58 34 30 46 55  /._SB_PCI0PX40FU
  2ae0: 4e 35 a4 0a 00 a1 04 a4 0a 0f 14 09 5f 53 31 44  N5.........._S1D
  2af0: 00 a4 0a 01 14 45 05 5f 53 33 44 00 a0 25 93 53  .....E._S3D..%.S
  2b00: 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63 72 6f 73 6f  CMP\_OS_.Microso
  2b10: 66 74 20 57 69 6e 64 6f 77 73 20 4e 54 00 00 a4  ft Windows NT...
  2b20: 0a 03 a0 22 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d  ...".SCMP\_OS_.M
  2b30: 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73  icrosoft Windows
  2b40: 00 00 a4 0a 03 a1 04 a4 0a 02 14 0d 5f 50 52 57  ............_PRW
  2b50: 00 a4 53 50 52 57 0a 0d 5b 82 42 0a 4d 43 39 37  ..SPRW..[.B.MC97
  2b60: 08 5f 41 44 52 0c 06 00 04 00 14 23 5f 53 54 41  ._ADR......#_STA
  2b70: 00 a0 17 5c 2f 04 5f 53 42 5f 50 43 49 30 50 58  ...\/._SB_PCI0PX
  2b80: 34 30 46 55 4e 36 a4 0a 00 a1 04 a4 0a 0f 14 09  40FUN6..........
  2b90: 5f 53 31 44 00 a4 0a 01 14 45 05 5f 53 33 44 00  _S1D.....E._S3D.
  2ba0: a0 25 93 53 43 4d 50 5c 5f 4f 53 5f 0d 4d 69 63  .%.SCMP\_OS_.Mic
  2bb0: 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77 73 20 4e  rosoft Windows N
  2bc0: 54 00 00 a4 0a 03 a0 22 93 53 43 4d 50 5c 5f 4f  T......".SCMP\_O
  2bd0: 53 5f 0d 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e  S_.Microsoft Win
  2be0: 64 6f 77 73 00 00 a4 0a 03 a1 04 a4 0a 02 14 0d  dows............
  2bf0: 5f 50 52 57 00 a4 53 50 52 57 0a 0d 14 31 5f 53  _PRW..SPRW...1_S
  2c00: 33 44 00 a0 25 93 53 43 4d 50 5c 5f 4f 53 5f 0d  3D..%.SCMP\_OS_.
  2c10: 4d 69 63 72 6f 73 6f 66 74 20 57 69 6e 64 6f 77  Microsoft Window
  2c20: 73 20 4e 54 00 00 a4 0a 03 a1 04 a4 0a 02 14 0d  s NT............
  2c30: 5f 50 52 57 00 a4 53 50 52 57 0a 0b 10 44 0a 5c  _PRW..SPRW...D.\
  2c40: 5f 47 50 45 14 2a 5f 4c 30 39 00 86 5c 2f 03 5f  _GPE.*_L09..\/._
  2c50: 53 42 5f 50 43 49 30 55 53 42 30 0a 02 86 5c 2f  SB_PCI0USB0...\/
  2c60: 03 5f 53 42 5f 50 43 49 30 55 53 42 31 0a 02 14  ._SB_PCI0USB1...
  2c70: 32 5f 4c 30 38 00 86 5c 2f 04 5f 53 42 5f 50 43  2_L08..\/._SB_PC
  2c80: 49 30 50 58 34 30 55 41 52 31 0a 02 86 5c 2f 04  I0PX40UAR1...\/.
  2c90: 5f 53 42 5f 50 43 49 30 50 58 34 30 55 41 52 32  _SB_PCI0PX40UAR2
  2ca0: 0a 02 14 13 5f 4c 30 42 00 86 5c 2e 5f 53 42 5f  ...._L0B..\._SB_
  2cb0: 50 43 49 30 0a 02 14 2a 5f 4c 30 44 00 86 5c 2f  PCI0...*_L0D..\/
  2cc0: 03 5f 53 42 5f 50 43 49 30 41 43 39 37 0a 02 86  ._SB_PCI0AC97...
  2cd0: 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 43 39 37 0a  \/._SB_PCI0MC97.
  2ce0: 02                                               .

FACS @ 0x1ffff000
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

FACP @ 0x1ffec080
  0000: 46 41 43 50 74 00 00 00 01 c9 41 53 55 53 20 20  FACPt.....ASUS  
  0010: 41 37 56 31 33 33 2d 43 31 30 30 30 4d 53 46 54  A7V133-C1000MSFT
  0020: 31 30 31 31 00 f0 ff 1f 00 c1 fe 1f 00 00 09 00  1011............
  0030: 2f e4 00 00 a1 a0 00 00 00 e4 00 00 00 00 00 00  /...............
  0040: 04 e4 00 00 00 00 00 00 00 00 00 00 08 e4 00 00  ................
  0050: 20 e4 00 00 00 00 00 00 04 02 00 04 04 00 00 00   ...............
  0060: 5a 00 84 03 00 00 00 00 00 04 7d 7e 00 00 00 00  Z.........}~....
  0070: a6 00 00 00                                      ....

BOOT @ 0x1ffec040
  0000: 42 4f 4f 54 28 00 00 00 01 5a 41 53 55 53 20 20  BOOT(....ZASUS  
  0010: 41 37 56 31 33 33 2d 43 31 30 30 30 4d 53 46 54  A7V133-C1000MSFT
  0020: 31 30 31 31 3a 00 00 00                          1011:...

RSDT @ 0x1ffec000
  0000: 52 53 44 54 2c 00 00 00 01 0d 41 53 55 53 20 20  RSDT,.....ASUS  
  0010: 41 37 56 31 33 33 2d 43 31 30 30 30 4d 53 46 54  A7V133-C1000MSFT
  0020: 31 30 31 31 80 c0 fe 1f 40 c0 fe 1f              1011....@...

RSD PTR @ 0xf6a80
  0000: 52 53 44 20 50 54 52 20 88 41 53 55 53 20 20 00  RSD PTR .ASUS  .
  0010: 00 c0 fe 1f                                      ....


--------------070306080606070608080600--
