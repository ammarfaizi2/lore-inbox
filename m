Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUKOFwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUKOFwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 00:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKOFwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 00:52:32 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:7928 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261470AbUKOFwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 00:52:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Old thread: Nobody cared, chapter 10^3rd
Date: Mon, 15 Nov 2004 00:52:22 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411150052.22271.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.52.50] at Sun, 14 Nov 2004 23:52:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Board is a Biostar N7-NCD-Pro, Athlon 2800XP mounted, gig of ram.

Booting to 2.6.10-rc2 just now, I see that the dmesg log shows this:

PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
spurious 8259A interrupt: IRQ7.
[...]
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
ipmi message handler version v33
ipmi device interface version v33
irq 12: nobody cared!
 [<c0130bea>] __report_bad_irq+0x2a/0x90
 [<c01305a0>] handle_IRQ_event+0x30/0x70
 [<c0130cdc>] note_interrupt+0x6c/0xd0
 [<c0130710>] __do_IRQ+0x130/0x160
 [<c01043fe>] do_IRQ+0x3e/0x60
 =======================
 [<c01028aa>] common_interrupt+0x1a/0x20
 [<c011a470>] __do_softirq+0x30/0x90
 [<c0104501>] do_softirq+0x41/0x50
 =======================
 [<c0130564>] irq_exit+0x34/0x40
 [<c0104405>] do_IRQ+0x45/0x60
 [<c01028aa>] common_interrupt+0x1a/0x20
 [<c0130999>] setup_irq+0x99/0x120
 [<c024d050>] i8042_interrupt+0x0/0x190
 [<c0130b91>] request_irq+0x81/0xb0
 [<c042e372>] i8042_check_aux+0x32/0x170
 [<c024d050>] i8042_interrupt+0x0/0x190
 [<c042e8f0>] i8042_init+0x130/0x1b0
 [<c041681b>] do_initcalls+0x2b/0xc0
 [<c0433c3d>] sock_init+0x3d/0x80
 [<c0100440>] init+0x0/0x110
 [<c010046f>] init+0x2f/0x110
 [<c010086c>] kernel_thread_helper+0x0/0x14
 [<c0100871>] kernel_thread_helper+0x5/0x14
handlers:
[<c024d050>] (i8042_interrupt+0x0/0x190)
Disabling IRQ #12
serio: i8042 AUX port at 0x60,0x64 irq 12
[...]
Nov 15 00:35:40 coyote alsasound: Starting sound driver: snd-intel8x0
Nov 15 00:35:40 coyote kernel: ACPI: PCI Interrupt Link [LACI] enabled at IRQ 12
Nov 15 00:35:40 coyote kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 12 (level, low) -> IRQ 12
Nov 15 00:35:40 coyote kernel: intel8x0_measure_ac97_clock: measured 49922 usecs
Nov 15 00:35:40 coyote kernel: intel8x0: clocking to 47451
Nov 15 00:35:40 coyote alsasound: done
Nov 15 00:35:40 coyote rc: Starting alsasound:  succeeded

So there seems to be some confusion re the use of IRQ 12

Also during the early boot when its running on a vga 80x25 screen,
there are no fonts, just the occassional flicker of the curser
as it moves back and forth across the bottom of the screen, so
my early boot, after about 10 lines at the initiation, is invisible.

Later on it switches to an 80x30 screen, at which point I can
see the rest of the boot proceedure.  What causes this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
