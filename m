Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbTHXKvw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 06:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbTHXKvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 06:51:51 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:30124 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263198AbTHXKvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 06:51:25 -0400
Date: Sun, 24 Aug 2003 12:46:15 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: 2.6.0-test3-bk6: hang at i8042.c when booting with no PS/2 mouse attached
Message-ID: <20030824104615.GC29804@ucw.cz>
References: <1061233756.1520.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061233756.1520.16.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 09:09:16PM +0200, Felipe Alfaro Solana wrote:

> If I try to boot my P4 box (i845DE motherboard) with no PS/2 mouse
> plugged into the PS/2 port, the kernel hangs while checking the AUX
> ports in function i8042_check_aux(). The i8042_check_aux() function is
> trying to request IRQ #12, but the call to request_irq() causes the
> hang. The kernel hangs exactly at:
> 
>         if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
>                                 "i8042", i8042_request_irq_cookie))

What happens if you remove the SA_SHIRQ and replace with 0?

> in drivers/input/serio/i8042.c, with a value of 12 for values->irq. If I
> boot with my PS/2 mouse attached, the kernel is able to boot normally.
> Also, disabling ACPI support in the kernel allows me to boot
> 2.6.0-test3-bk6 with no PS/2 mouse plugged in.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
