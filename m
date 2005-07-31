Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVGaPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVGaPxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGaPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:53:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261826AbVGaPx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:53:29 -0400
Date: Sun, 31 Jul 2005 08:53:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <20050731132958.GB14550@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0507310847560.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0507301331260.29650@g5.osdl.org> <20050731132958.GB14550@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Pavel Machek wrote:
> 
> Well, on some machines interrupts can change during suspend (or so I
> was told). I did not like the ACPI change at one point, but it is very
> wrong to revert PCMCIA fix without also fixing ACPI interpretter.

We _are_ going to fix the ACPI interpreter.

As to irq's changing during suspend - I'll believe that when I see it, not 
when some chicken little runs around worrying about it. I doubt anybody 
has ever seen it, and I'm 100% sure that we have serious breakage right 
now on machines where it definitely doesn't happen.

> And it indeed seems that ACPI interpretter is hard to fix in the right
> way.

We'll revert to the behaviour that it has traditionally had, and start 
working forwards in a more careful manner. Where we don't break working 
setups.

			Linus
