Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUGASUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUGASUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUGASUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:20:32 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:32457 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S266216AbUGASUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:20:30 -0400
Subject: Re: 2.6.7-mm5
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040630172656.6949ec60.akpm@osdl.org>
References: <20040630172656.6949ec60.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1088706673.7901.1.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Jul 2004 20:31:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 02:26, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/
> 
> - bk-acpi.patch is back.  If devices mysteriously fail to function please
>   try reverting it with
> 
>        patch -p1 -R -i ~/bk-acpi.patch
> 
> - last call for reviewers of the perfctr patches.
> 
> - s390, ppc64, ppc32 and IDE updates.
> 
Still the same problem with my EHCI controller.

usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: can't reset
ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
ehci_hcd: probe of 0000:00:1d.7 failed with error -95

Unplugging gives:

ACPI: PCI interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 23
irq 23: nobody cared!
 [<c0108106>] __report_bad_irq+0x2a/0x8b
 [<c01081f0>] note_interrupt+0x6f/0x9f
 [<c0108473>] do_IRQ+0x10c/0x10e
 [<c0106850>] common_interrupt+0x18/0x20
 [<c010401e>] default_idle+0x0/0x2c
 [<c0104047>] default_idle+0x29/0x2c
 [<c01040b0>] cpu_idle+0x33/0x3c
 [<c031684b>] start_kernel+0x1a0/0x1dd
 [<c0316309>] unknown_bootoption+0x0/0x149
handlers:
[<f8aa165c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
Disabling IRQ #23

Jurgen



