Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVGaXHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVGaXHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 19:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVGaXHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 19:07:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39334 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262027AbVGaXF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 19:05:57 -0400
Date: Mon, 1 Aug 2005 01:05:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ambx1@neo.rr.com, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050731230507.GE27580@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In general, I think that calling free_irq is the right behavior.
> 
> I DO NOT CARE!
> 
> It breaks hundreds of drivers. End of discussion.
> 
> You can do the free_irq() and request_irq() changes _without_ breaking 
> hundreds of drivers by just doing one driver at a time. 
> 
> And if ACPI then restores the irq controller state, the drivers that 
> _don't_ do this will _also_ continue to work.
> 
> Let me re-iterate: the ACPI changes provably BROKE REAL PEOPLES SETUPS. 
> 
> For absolutely _zero_ gain. Drivers that want to free and re-aquire an 
> interrupt can do so _regardless_ of whether ACPI restores irq routings 
> automatically or not.
> 
> And that's my argument. We don't do stupid things that break peoples 
> existing setups in ways that nobody can debug. 

Ok, so we'll keep adding those free_irq/request_irq pairs, and
re-introduce that ACPI change when we are ready? It would be helpfull
to keep the "right thing" in -mm, so there's real motivation to add
free_irq/request_irq.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
