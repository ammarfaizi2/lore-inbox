Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbUJXUVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUJXUVX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUJXUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:21:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:60397 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261643AbUJXUUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:20:14 -0400
Date: Sun, 24 Oct 2004 22:20:13 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.9] unhandled OHCI IRQs...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <16118.1098649213@www5.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When plugging in an Epson C62 USB 1.1 printer to my nForce 2 OHCI + EHCI USB
controllers, the IRQ doesn't seem to get handled [1]. Tried both with
acpi=noirq and without, printer support and full USB support enabled. Kernel
is 2.6.9.

Any ideas?

--- [1]

irq 7: nobody cared!
 [<c01063d4>] __report_bad_irq+0x24/0x80
 [<c01064b1>] note_interrupt+0x61/0x90
 [<c010637b>] handle_IRQ_event+0x2b/0x60
 [<c010676a>] do_IRQ+0x11a/0x130
 [<c010479c>] common_interrupt+0x18/0x20
 [<c0119f30>] __do_softirq+0x30/0x90
 [<c0119fb6>] do_softirq+0x26/0x30
 [<c010674b>] do_IRQ+0xfb/0x130
 [<c010479c>] common_interrupt+0x18/0x20
 [<c0101df0>] default_idle+0x0/0x30
 [<c0101e13>] default_idle+0x23/0x30
 [<c0101e8a>] cpu_idle+0x3a/0x60
 [<c035c8e1>] start_kernel+0x141/0x160
 [<c035c530>] unknown_bootoption+0x0/0x160
handlers:
[<c022dcd0>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #7
spurious 8259A interrupt: IRQ7.

--- [2]

# grep hcd /proc/interrupts 
  5:          0          XT-PIC  ohci_hcd
  7:     164004          XT-PIC  ohci_hcd
 12:          2          XT-PIC  ehci_hcd

-- 
Daniel J Blueman

+++ GMX DSL Premiumtarife 3 Monate gratis* + WLAN-Router 0,- EUR* +++
Clevere DSL-Nutzer wechseln jetzt zu GMX: http://www.gmx.net/de/go/dsl

