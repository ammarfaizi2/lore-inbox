Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbRBVUcQ>; Thu, 22 Feb 2001 15:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRBVUcG>; Thu, 22 Feb 2001 15:32:06 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:10514 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129678AbRBVUbt>;
	Thu, 22 Feb 2001 15:31:49 -0500
Date: Thu, 22 Feb 2001 21:30:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: Using ACPI to get PCI routing info?
Message-ID: <20010222213028.A1542@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Gigabyte (and/or AMI and/or VIA) decided that it is not worth 
of effort to create full mptable and since version F5a for 6VXD7 
they do not report PCI interrupts as 16-19, but only as traditional 
0-15 (and they do not report them as conforms/conforms, but as 
active-lo/level).

  For now I hardwired correct routing table into my kernel, as
I have other uses for IRQ < 16, but after some investigation I 
found that ACPI _SB_.PCI0._PRT element returns correct routing 
table (using IRQ 16-19). So my question is, are there any plans 
to use ACPI tables to get IRQ routing tables, or should I complain 
to Gigabyte that I'm not satisfied (I'll complain anyway, but...)?

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

P.S.: No, there is no MPS1.1/MPS1.4 switch in BIOS (anymore) :-(
And no, there is no way to disable ACPI in that BIOS :-((

/* Old working BIOS... 6VXD7 - F2 */
Dec 22 23:03:41 vana kernel: Intel MultiProcessor Specification v1.1
Dec 22 23:03:41 vana kernel:     Virtual Wire compatibility mode.
Dec 22 23:03:41 vana kernel: OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000

Dec 22 23:03:41 vana kernel: Bus #0 is PCI   
Dec 22 23:03:41 vana kernel: Bus #1 is PCI   
Dec 22 23:03:41 vana kernel: Bus #2 is ISA   
Dec 22 23:03:41 vana kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Dec 22 23:03:41 vana kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Dec 22 23:03:41 vana kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Dec 22 23:03:41 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 34, APIC ID 2, APIC INT 11
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 38, APIC ID 2, APIC INT 12
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 13
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 13
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 1f, APIC ID 2, APIC INT 13
Dec 22 23:03:41 vana kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 1f, APIC ID 2, APIC INT 13
Dec 22 23:03:41 vana kernel: Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Dec 22 23:03:41 vana kernel: Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Dec 22 23:03:41 vana kernel: Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Dec 22 23:03:41 vana kernel: Processors: 2

/* 'Broken' 6VXD7 - F5a */
Feb 22 19:53:16 vana kernel: Intel MultiProcessor Specification v1.1
Feb 22 19:53:16 vana kernel:     Virtual Wire compatibility mode.
Feb 22 19:53:16 vana kernel: OEM ID: VIA      Product ID: VT3075       APIC at: 0xFEE00000

Feb 22 19:53:16 vana kernel: Bus #0 is PCI   
Feb 22 19:53:16 vana kernel: Bus #1 is PCI   
Feb 22 19:53:16 vana kernel: Bus #2 is ISA   
Feb 22 19:53:16 vana kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb 22 19:53:16 vana kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Feb 22 19:53:16 vana kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Feb 22 19:53:16 vana kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Feb 22 19:53:16 vana kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Feb 22 19:53:16 vana kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Feb 22 19:53:16 vana kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Feb 22 19:53:16 vana kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Feb 22 19:53:16 vana kernel: Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Feb 22 19:53:16 vana kernel: Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Feb 22 19:53:16 vana kernel: Processors: 2

