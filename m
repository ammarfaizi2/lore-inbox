Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUF0Lvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUF0Lvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUF0Lvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 07:51:31 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:46007 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262062AbUF0Lv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 07:51:29 -0400
Subject: 2.6.7-mm3 USB ehci IRQ problem
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088337721.7932.10.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 27 Jun 2004 14:02:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.7-mm3 I am missing my USB 2.0 memory stick. It doesn't show up
in the usb device listing. But when I unplug it I get:

irq 23: nobody cared!
 [<c0108106>] __report_bad_irq+0x2a/0x8b
 [<c01081f0>] note_interrupt+0x6f/0x9f
 [<c0108473>] do_IRQ+0x10c/0x10e
 [<c0106850>] common_interrupt+0x18/0x20
handlers:
[<f9d0f65c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
Disabling IRQ #23

The soundcard is still usable but there are no new interrupts.

When I try to reload the ehci module I get:

ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: can't reset
ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
ehci_hcd: probe of 0000:00:1d.7 failed with error -95

IRQ23 is normally shared between emu10k1 and the ehci controller without
problems.

Jurgen



