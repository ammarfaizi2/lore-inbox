Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVDNIR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVDNIR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVDNIR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:17:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261459AbVDNIRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:17:23 -0400
Date: Thu, 14 Apr 2005 10:17:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marco Gaddoni <marco.gaddoni@teknolab.net>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: swsuspend scheduling while atomic
Message-ID: <20050414081705.GA1360@elf.ucw.cz>
References: <42596B7F.4000808@teknolab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42596B7F.4000808@teknolab.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i am playing a little with swsuspend and getting
> "scheduling while atomic: bash/0x00000001/5244"
> messages while the system is resuming.
> Apparently  the  resume  work  correctly.
> Do i have to fear for my data?

It should be ok.

> Some data about my system:

> ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
> ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
> ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
> APIC error on CPU0: 00(00)
> ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
> ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> bttv0: reset, reinitialize
> bttv0: PLL: 28636363 => 35468950 .<3>scheduling while atomic: 
> bash/0x00000001/4686
> [<c04310ef>] schedule+0x44f/0x500
> [<c011a5b5>] call_console_drivers+0x65/0x140
> [<c0123775>] __mod_timer+0x1e5/0x1f0
> [<c0431b8d>] schedule_timeout+0x5d/0xb0
> [<c01241e0>] process_timeout+0x0/0x10
> [<c01245cf>] msleep+0x2f/0x40
> [<e0921233>] set_pll+0x63/0x1a0 [bttv]
> [<e09213b7>] bt848A_set_timing+0x47/0x140 [bttv]
> [<e09219c7>] set_tvnorm+0x87/0xb0 [bttv]
> [<e0921aa4>] set_input+0xb4/0xf0 [bttv]
> [<e0921d57>] bttv_reinit_bt848+0x77/0xb0 [bttv]
> [<e0927aca>] bttv_resume+0x4a/0x170 [bttv]
> [<c02300a7>] kobject_get+0x17/0x20

You need to fix bttv.

And BTW thanks, I'll fix maintainers file.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
