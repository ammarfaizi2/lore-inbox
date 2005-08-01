Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVHAHQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVHAHQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVHAHQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:16:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30353 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262019AbVHAHQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:16:06 -0400
Date: Mon, 1 Aug 2005 09:15:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, ambx1@neo.rr.com,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050801071557.GJ27580@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org> <20050731230507.GE27580@elf.ucw.cz> <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org> <20050731232735.GF27580@elf.ucw.cz> <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org> <21d7e9970507311659259e5560@mail.gmail.com> <Pine.LNX.4.58.0507311709410.14342@g5.osdl.org> <21d7e9970507311744261a3bb7@mail.gmail.com> <Pine.LNX.4.58.0507311800560.14342@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507311800560.14342@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You said earlier we only should fix drivers that need fixing, but they
> > all need fixing
> 
> I think you're still talking from a theoretical standpoing, while all my 
> arguments are practical.
> 
> In _practice_, I hope that
> 
>  (a) we don't see that very much (ie the people for whom things work 
>      already are a strong argument that this is less of a problem in
>      practice than people try to make it appear)
> 
>  (b) drivers, _especially_ on notebooks, are already able to handle an 
>      incoming interrupt with the device in D3 state and returning 0xff
>      for all reads.
> 
>      In particular, this is exactly the same thing that you get on a 
>      surprise device removal too.

Not all devices that we want power-managed are hot-pluggable, even on
notebooks. If I need to go all over the tree fixing drivers, I'd much
rather add free_irq/request_irq than mess with interrupt routines on
hardware I don't have...
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
