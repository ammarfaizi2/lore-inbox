Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUGSHmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUGSHmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 03:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUGSHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 03:42:36 -0400
Received: from big.switch.gts.cz ([195.39.57.241]:2717 "EHLO big.switch.gts.cz")
	by vger.kernel.org with ESMTP id S264750AbUGSHmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 03:42:35 -0400
Date: Mon, 19 Jul 2004 09:42:31 +0200
From: Petr Cisar <pc@big.switch.gts.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1 and before: IO-APIC + DRI + RTL8139 = Disabling Ethernet IRQ
Message-ID: <20040719074231.GA11015@big.switch.gts.cz>
Reply-To: Petr Cisar <pc@gts.cz>
References: <40F4635C.3090003@reolight.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40F4635C.3090003@reolight.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problems with ATI Radeon 128. It occurs with when X (4.4) dies after using DRI. I tried with kernels 2.6.4 to 2.6.7 and the behaviour is identical.

It looks like it forgets to disable the interrupts in the video card. Commenting the DRI module out from XF86Config keeps it from happening. I don't have much expeirience with this stuff, so I can't tell whether the problem is in the X system or in the kernel driver.

Petr

> 
> When loading as a module or into kernel, when DRM is loading, I cannot
> use my network.
> 
> Here is a part of the dmesg:
> 
> [drm] Loading R200 Microcode
> irq 19: nobody cared!
>  [<c010732a>] __report_bad_irq+0x2a/0x8b
>  [<c0107414>] note_interrupt+0x6f/0x9f
>  [<c0107732>] do_IRQ+0x161/0x192
>  [<c0105a00>] common_interrupt+0x18/0x20
> handlers:
> [<c0245383>] (rtl8139_interrupt+0x0/0x207)
> Disabling IRQ #19
> 
> For the moment I can disabling IO-ACPI, but I'm thinking to change my
> processor with an processor w/HT. So IO-ACPI is enabling by default.
> 
> How solve that ?
> 
> Thanks in advance,
> 
> -- 
> Auzanneau Grégory
> GPG 0x99137BEE
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
