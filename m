Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTHXPFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 11:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTHXPFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 11:05:40 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:14983 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261170AbTHXPFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 11:05:37 -0400
Date: Sun, 24 Aug 2003 08:05:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: piggin@cyberone.com.au
Subject: [Bug 1137] New: non fatal ACPI errors on boot
Message-ID: <24040000.1061737501@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1137

           Summary: non fatal ACPI errors on boot
    Kernel Version: 2.6.0-test2-mm4
            Status: NEW
          Severity: low
             Owner: len.brown@intel.com
         Submitter: piggin@cyberone.com.au


Distribution: Debian unstable
Problem Description:
The following ACPI errors on boot. System boots fine and I have not noticed any
regressions or loss of functionality. ACPI does not detect power button events
though.

ACPI: Subsystem revision 20030714
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
   ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA]
(Node d7eeace0), AE_AML_REGION_LIMIT
   ACPI-0098: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA]
(Node d7eeace0), AE_AML_REGION_LIMIT
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
   ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.SBRG.PS2M._STA]
(Node d7eeace0), AE_AML_REGION_LIMIT

and

irq 20: nobody cared!
Call Trace:
[<c010b7ba>] __report_bad_irq+0x2a/0x90
[<c010b8b0>] note_interrupt+0x70/0xb0
[<c010bb41>] do_IRQ+0x111/0x120
[<c0106ff0>] default_idle+0x0/0x50
[<c0109d7c>] common_interrupt+0x18/0x20
[<c0106ff0>] default_idle+0x0/0x50
[<c010701c>] default_idle+0x2c/0x50
[<c01070c9>] cpu_idle+0x49/0x60
[<c0105000>] _stext+0x0/0x50
[<c035e89b>] start_kernel+0x15b/0x160
[<c035e4b0>] unknown_bootoption+0x0/0x120

handlers:
[<c01f3f4b>] (acpi_irq+0x0/0x16)
Disabling IRQ #20


