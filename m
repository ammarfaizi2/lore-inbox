Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUGETDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUGETDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUGETDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:03:05 -0400
Received: from fmr10.intel.com ([192.55.52.30]:45703 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S266163AbUGETC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:02:57 -0400
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
From: Len Brown <len.brown@intel.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FEF3E@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FEF3E@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089054167.15653.51.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 15:02:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-27 at 08:02, Jurgen Kramer wrote:
> With 2.6.7-mm3 I am missing my USB 2.0 memory stick. It doesn't show
> up in the usb device listing. But when I unplug it I get:
> 
> irq 23: nobody cared!
>  [<c0108106>] __report_bad_irq+0x2a/0x8b
>  [<c01081f0>] note_interrupt+0x6f/0x9f
>  [<c0108473>] do_IRQ+0x10c/0x10e
>  [<c0106850>] common_interrupt+0x18/0x20
> handlers:
> [<f9d0f65c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
> Disabling IRQ #23
> 
> The soundcard is still usable but there are no new interrupts.
> 
> When I try to reload the ehci module I get:
> 
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
> Controller
> ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> ehci_hcd 0000:00:1d.7: can't reset
> ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> 
> IRQ23 is normally shared between emu10k1 and the ehci controller
> without problems.

it worked normally in 2.6.7 vanilla?

it would be interesting to know if booting with "acpi_os_name=Linux"
makes any difference.

-Len


