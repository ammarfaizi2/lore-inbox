Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUBAMCw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 07:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUBAMCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 07:02:52 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:14599
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S265274AbUBAMCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 07:02:49 -0500
Date: Sun, 1 Feb 2004 13:02:46 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI button problems since 2.4.22 continue with 2.6.X
Message-ID: <20040201120246.GA2104@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In this machine ACPI was running fine at 2.4.21, after that ACPI is fine
(powers off on halt without any problem, ...) but pressing the power button
makes the kernel crash, both in preentive and non-preentive kernels. Machine
is a UP Pentium MMX with an i430TX chipset.

I've been testing this with 2.6.2-rc3 and this is what the kernel said when
I pressed the power button:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c019a0eb
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c019a0eb>]    Not tainted
EFLAGS: 00010292
EIP is at acpi_ev_gpe_detect+0x23/0x120
eax: c02b4000   ebx: 00000000   ecx: 00000120   edx: 00000111
esi: 00000000   edi: 00000000   ebp: 00000009   esp: c02b5f10
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c02b4000 task=c027cbc0)
Stack: 00000000 00000000 00000000 00000009 c019863d 00000002 00000000 04000001 
       00000000 00000120 c0198b13 00000000 c7f94d20 04000001 c01944c9 00000000 
       c010a303 00000009 c01944bc c02b5f9c c02b4000 c02b4000 00000009 c02b5f94 
Call Trace:
 [<c019863d>] acpi_ev_fixed_event_detect+0x51/0x68
 [<c0198b13>] acpi_ev_sci_xrupt_handler+0x13/0x20
 [<c01944c9>] acpi_irq+0xd/0x1c
 [<c010a303>] handle_IRQ_event+0x2b/0x50
 [<c01944bc>] acpi_irq+0x0/0x1c
 [<c010a5f1>] do_IRQ+0x95/0x134
 [<c0105000>] _stext+0x0/0x58
 [<c0108fc8>] common_interrupt+0x18/0x20
 [<c0106e10>] default_idle+0x0/0x2c
 [<c0105000>] _stext+0x0/0x58
 [<c0106e36>] default_idle+0x26/0x2c
 [<c0106eab>] cpu_idle+0x2b/0x3c
 [<c0105055>] _stext+0x55/0x58
 [<c02b65e0>] start_kernel+0x148/0x150

Code: 8b 73 08 85 f6 0f 84 d5 00 00 00 c7 44 24 18 00 00 00 00 8b 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

These are the messages relating acpi that the kernel outputs on boot:

 BIOS-e820: 0000000007ffd000 - 0000000007ffd800 (ACPI NVS)
 BIOS-e820: 0000000007ffd800 - 0000000007fff400 (ACPI data)
ACPI: RSDP (v000                                           ) @ 0x000f6880
ACPI: RSDT (v001                 0x00000000  0x00000000) @ 0x07ffd800
ACPI: FADT (v001                 0x00000000  0x00000000) @ 0x07ffd840
ACPI: DSDT (v001  AWARD AWRDACPI 0x00001000 MSFT 0x01000000) @ 0x00000000
Kernel command line: root=/dev/hda2 pci=noacpi console=ttyS0,115200i
console=tty0
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-0887: *** Info: There are no GPE blocks defined in the FADT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Button (FF) [PWRF]

Well, I'd like to help getting this back working, so no problem in doing all
necesary tests or whatever is needed, just tell me.

Should I send a bug about this to the kernel tracker?

Regards...
-- 
Manty/BestiaTester -> http://manty.net
