Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTAET3i>; Sun, 5 Jan 2003 14:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAET3i>; Sun, 5 Jan 2003 14:29:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265037AbTAET3f>;
	Sun, 5 Jan 2003 14:29:35 -0500
Date: Sun, 5 Jan 2003 11:34:58 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Paul Rolland <rol@as2917.net>
cc: "'Andrew S. Johnson'" <andy@asjohnson.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54 + ACPI] Slow [Was: Re: [2.5.53] So sloowwwww......]
In-Reply-To: <Pine.LNX.4.33L2.0301051108480.13312-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0301051133340.13312-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jan 2003, Randy.Dunlap wrote:

| On Sun, 5 Jan 2003, Paul Rolland wrote:
|
| | Hello,
| | >
| | > Did you try using acpi=no-idle in your kernel append line (if using
| | > lilo) and see what difference that makes?  It works in 2.4.
| | >
| | Followed your advice, and due to lack of documentation regarding
| | the acpi= kernel parameters, I tried :
| |  - acpi=no-idle
|
| This one (above) is the correct syntax.
| Looking at the code, it only takes effect if you are using
| only 1 CPU.

Sorry, I was looking at old source code.
apm=no-idle isn't in 2.5.54.

| |  - acpi=noidle
| |  - acpi=no_idle
| | without success on a 2.5.54 kernel.
| |
| | 2.5.54 and ACPI (not only ACPI enumaration) is definitely slow.
| | Messages at boot :
| | Machine check exception polling timer started.
| | CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
| | Enabling fast FPU save and restore... done.
| | Enabling unmasked SIMD FPU exception support... done.
| | Checking 'hlt' instruction... OK.
| | POSIX conformance testing by UNIFIX
| | enabled ExtINT on CPU#0
| | ESR value before enabling vector: 00000000
| | ESR value after enabling vector: 00000000
| | ENABLING IO-APIC IRQs
| | ..TIMER: vector=0x31 pin1=2 pin2=0
| | testing the IO APIC.......................
| |
| |  WARNING: unexpected IO-APIC, please mail
| |           to linux-smp@vger.kernel.org
| | .................................... done.
| | Using local APIC timer interrupts.
| | calibrating APIC timer ...
| | ..... CPU clock speed is 2423.0564 MHz.
| | ..... host bus clock speed is 134.0642 MHz.
| | Linux NET4.0 for Linux 2.4
| | Based upon Swansea University Computer Society NET3.039
| | Initializing RT netlink socket
| | mtrr: v2.0 (20020519)
| | PCI: PCI BIOS revision 2.10 entry at 0xf11a0, last bus=1
| | PCI: Using configuration type 1
| | BIO: pool of 256 setup, 14Kb (56 bytes/bio)
| | biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
| | biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
| | biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
| | biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
| | biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
| | biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
| | ACPI: Subsystem revision 20021217
| |     ACPI-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
| |     ACPI-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
| | ACPI: Interpreter enabled
| | ACPI: Using IOAPIC for interrupt routing
| | ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
| | ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
| | ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12 14 15)
| | ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
| | ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled
| | at IRQ 9)
| | ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled
| | at IRQ 9)
| | ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled
| | at IRQ 9)
| | ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled
| | at IRQ 9)
| | ACPI: PCI Root Bridge [PCI0] (00:00)
| | PCI: Probing PCI hardware (bus 00)

-- 
~Randy

