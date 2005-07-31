Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVGaNaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVGaNaI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVGaNaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:30:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3243 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261748AbVGaNaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:30:06 -0400
Date: Sun, 31 Jul 2005 15:29:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050731132958.GB14550@elf.ucw.cz>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <Pine.LNX.4.58.0507301331260.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507301331260.29650@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please revert the yenta free_irq on suspend patch (below)
> > which went into 2.6.13-rc4 after 2.6.13-rc3-git9.
> 
> Ok. Will do.

> And the ACPI people had better stop doing this crazy thing in the first 
> place. There's really no point at all to freeing and re-requesting the 
> interrupts, and the IRQ controller should just re-initialize itself 
> instead.

Well, on some machines interrupts can change during suspend (or so I
was told). I did not like the ACPI change at one point, but it is very
wrong to revert PCMCIA fix without also fixing ACPI interpretter.

And it indeed seems that ACPI interpretter is hard to fix in the right
way.

								Pavel 
-- 
if you have sharp zaurus hardware you don't need... you know my address
