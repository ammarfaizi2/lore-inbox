Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVGaXZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVGaXZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGaXZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:25:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbVGaXYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:24:16 -0400
Date: Sun, 31 Jul 2005 16:24:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: ambx1@neo.rr.com, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <20050731230507.GE27580@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org> <20050731230507.GE27580@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Pavel Machek wrote:
> 
> Ok, so we'll keep adding those free_irq/request_irq pairs

I would suggest doing so only if you have a case where it can matter.

> and re-introduce that ACPI change when we are ready?

Why do it _ever_? There is _zero_ upside to doing it, I don't see why you 
want to.

Just make ACPI restore the dang thing. It's the right thing to do.

			Linus
