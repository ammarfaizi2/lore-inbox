Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVG3VbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVG3VbB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVG3VbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:31:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4619 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261656AbVG3Van (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:30:43 -0400
Date: Sat, 30 Jul 2005 22:30:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050730223031.L26592@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <20050730210306.D26592@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org> <20050730215403.J26592@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>; from torvalds@osdl.org on Sat, Jul 30, 2005 at 02:10:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 02:10:41PM -0700, Linus Torvalds wrote:
> On Sat, 30 Jul 2005, Russell King wrote:
> > I don't think so - I believe one of the problem cases is where you
> > have a screaming interrupt caused by an improperly setup device.
> 
> Not a problem.
> 
> The thing is, this is trivially solved by
>  - disable irq controller last on shutdown
>  - re-enable irq controller last on resume

I reserve further judgement on this idea until it's had some field
testing. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
