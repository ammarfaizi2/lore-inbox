Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVGaX20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVGaX20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGaX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:28:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36004 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262075AbVGaX1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:27:43 -0400
Date: Mon, 1 Aug 2005 01:27:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ambx1@neo.rr.com, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050731232735.GF27580@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org> <20050731230507.GE27580@elf.ucw.cz> <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ok, so we'll keep adding those free_irq/request_irq pairs
> 
> I would suggest doing so only if you have a case where it can matter.
> 
> > and re-introduce that ACPI change when we are ready?
> 
> Why do it _ever_? There is _zero_ upside to doing it, I don't see why you 
> want to.

Being able to turn off your soundcard at runtime when you are not
using it was one of examples...

> Just make ACPI restore the dang thing. It's the right thing to do.

Requires interpretter running with interrupts disabled => ugly :-(.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
