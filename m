Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUB0Sxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUB0Sxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:53:49 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:25306 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S262919AbUB0Sxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:53:45 -0500
Subject: USB stops working on two _different_ pc's. Worked fine with 2.6.2.
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077908020.787.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 19:53:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

quite often I get this message in my dmesg:

irq 10: nobody cared!
Call Trace:
 [<c010b424>] __report_bad_irq+0x24/0x90
 [<c010b511>] note_interrupt+0x61/0x90
 [<c010b78b>] do_IRQ+0xfb/0x100
 [<c0105000>] rest_init+0x0/0x40
 [<c0109bac>] common_interrupt+0x18/0x20
 [<c0107030>] default_idle+0x0/0x40
 [<c0105000>] rest_init+0x0/0x40
 [<c010705c>] default_idle+0x2c/0x40
 [<c01070eb>] cpu_idle+0x3b/0x50
 [<c060089a>] start_kernel+0x15a/0x180
 [<c0600490>] unknown_bootoption+0x0/0x120

handlers:
[<c035b280>] (usb_hcd_irq+0x0/0x60)
[<c035b280>] (usb_hcd_irq+0x0/0x60)
[<c035b280>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #10

I always have a round number of interrupts on irq10 when this happens:

           CPU0       CPU1       
  0:    1815656        248    IO-APIC-edge  timer
  1:       2274          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:         13          0    IO-APIC-edge  serial
  8:          4          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 10:     800000          0   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd
 14:        423          0    IO-APIC-edge  ide0
 15:         23          0    IO-APIC-edge  ide1
 16:          2          1   IO-APIC-level  HiSax
 17:     296723     611709   IO-APIC-level  aic7xxx, EMU10K1
 18:      31174          1   IO-APIC-level  aic7xxx, yenta
 19:      59209          1   IO-APIC-level  saa7134[0], yenta, eth0
NMI:          0          0 
LOC:    1815676    1815739 
ERR:          0
MIS:          0

And obviously, usb stops working after this. This happens quite often,
on two _different_ motherboards. (both SMP). Earlier USB had irq 5, now
I have these lines:

PCI: Via IRQ fixup for 0000:00:11.2, from 5 to 10
PCI: Via IRQ fixup for 0000:00:11.3, from 5 to 10
PCI: Via IRQ fixup for 0000:00:11.4, from 5 to 10

Have no idea if this matters. Hope someone could help me sort this out.

Best regards,
Stian

