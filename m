Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbULMPbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbULMPbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 10:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbULMPbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 10:31:16 -0500
Received: from fsmlabs.com ([168.103.115.128]:36557 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261239AbULMPbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 10:31:14 -0500
Date: Mon, 13 Dec 2004 08:30:51 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
In-Reply-To: <20041213135820.A24748@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0412130808010.22212@montezuma.fsmlabs.com>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Mon, 13 Dec 2004, Russell King wrote:

> This is an easy thing to grab hold of, but rather pointless in the
> overall scheme of things.  Those of us who have done power usage
> measurements know this already.
> 
> The only case where this really makes sense is where the CPU power
> usage outweighs the power consumption of all other peripherals by
> at least an order of magnitude such that the rest of the system is
> insignificant compared to the CPU power.
> 
> Note: the above CPU power consumption figures were taken from
> the Intel PXA255 processor electrical specifications, and the
> "rest of the system" current consumption taken from a real life
> device.  The timer interrupt taking 2us is probably an over-
> estimation.  Only the battery lifetime of 24 hours is ficticious.

While i do not disagree with your research and resultant conclusions for 
the PXA255 processor i think it may not be as representative of some of 
the target systems we're interested in, that is, x86 (cringe, cringe). A 
number of i386 systems enter model defined partial suspend states when 
execution of the hlt instruction takes place, resuming from these suspend 
states draws more power for a short period of time thus doing this every 
millisecond is going to be detrimental to total power consumption over 
time. But this isn't only an i386 trait as other desktop/workstation 
processors are similar.
