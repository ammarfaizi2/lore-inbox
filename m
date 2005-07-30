Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVG3Uj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVG3Uj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVG3Ugz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:36:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263157AbVG3Ugr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:36:47 -0400
Date: Sat, 30 Jul 2005 13:36:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <20050730210306.D26592@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <20050730210306.D26592@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jul 2005, Russell King wrote:
> 
> What this probably means is that we need some way to turn off interrupts
> from devices on suspend, and on resume, keep them off until drivers
> have had a chance to quiesce all devices, turn them back on, and then
> do full resume.

No, we just need to suspend and resume the interrupt controller properly.  
Which we had the technology for, and we actually used to do, but for some
(incorrect) reason ACPI people thought it should be up to individual
drivers.

			Linus
