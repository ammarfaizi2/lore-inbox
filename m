Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269207AbTCBNVc>; Sun, 2 Mar 2003 08:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269208AbTCBNVc>; Sun, 2 Mar 2003 08:21:32 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:1472 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S269207AbTCBNVO>;
	Sun, 2 Mar 2003 08:21:14 -0500
Date: Sun, 2 Mar 2003 14:31:38 +0100
From: bert hubert <ahu@ds9a.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: S4bios support for 2.5.63
Message-ID: <20030302133138.GA27031@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226211347.GA14903@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 10:13:47PM +0100, Pavel Machek wrote:

> This is S4bios support for 2.5.63. I'd like to see it in since it is
> easier to understand and more foolproof. Please apply,

Pavel,

Since 2.5.61 at least swsusp doesn't work here, with or without S4bios. It
lists a heap of processes entering the refrigerator, then prints '=|' and
moves one line downwards, cursor blinking on an empty line.

Nothing appears to happen then, except that if I press alt-f7, my screen
blanks as if X is still partly alive. Alt-SysRQ also works and shows heaps
of processes, most of them with 'refrigerator' somewhere in their traceback.

Nothing is written to disk however.

I try to suspend with "echo 4 > /proc/acpi/sleep".

>From dmesg on bootup:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bff8000 (ACPI data)
 BIOS-e820: 000000000bff8000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000ffef0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000fc740
ACPI: RSDT (v001 AMIINT AMIINT09 00000.04096) @ 0x0bff0000
ACPI: FADT (v001 AMIINT AMIINT09 00000.04096) @ 0x0bff0030
ACPI: DSDT (v001    SiS      630 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 resume=/dev/hda2
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1096.985 MHz processor.
--
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030122
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................................
Table [DSDT] - 419 Objects with 37 Devices 127 Methods 20 Regions
ACPI Namespace successfully loaded at root c040eb9c
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.....................................
37 Devices found containing: 37 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:................................................................
Initialized 16/20 Regions 0/0 Fields 29/29 Buffers 19/19 Packages (419 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 11)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [URP1] (off)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 6 7 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKC] (IRQs 6 7 10 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKD] (IRQs 11, disabled)
ACPI: Power Resource [FN10] (on)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
NET4: Frame Diverter 0.46
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LIDD]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU1] (supports C1 C2, 8 throttling states)
 exfldio-0140 [25] ex_setup_region       : Field [TMPS] Base+Offset+Width 4+0+4 is beyond end of region [M4D0] (length 6)
 psparse-1121: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node cbf11148), AE_AML_REGION_LIMIT
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
--
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ACPI: (supports S0 S1 S4 S5)


.config:
# egrep -i 'acpi|susp' /mnt/linux-2.5.63/.config
# Power management options (ACPI, APM)
CONFIG_SOFTWARE_SUSPEND=y
# ACPI Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

If you have further questions about my configuration, just let me know.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
