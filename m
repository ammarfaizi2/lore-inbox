Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUCLLsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 06:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUCLLsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 06:48:01 -0500
Received: from mail.shareable.org ([81.29.64.88]:54666 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261907AbUCLLr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 06:47:59 -0500
Date: Fri, 12 Mar 2004 11:47:55 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Message-ID: <20040312114755.GA17825@mail.shareable.org>
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org> <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.12.11.08.02.700169@smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Urlichs wrote:
> > That effect is to cause the whole world to be swapped out when people
> > return to their machines in the morning.
> 
> The correct solution to this problem is "suspend-to-disk" --
> if the machine isn't doing anything anyway, TURN IT OFF.

How is that better for people complaining that everything needs to be
swapped in in the morning?

Suspend-to-disk will cause everything to be paged in too.  Faster I
suspect (haven't tried it; it doesn't work on my box), but still a
wait especially when you add in the BIOS boot time.

Environmentally turning an unused machine off is good.  But I don't
see how suspend-to-disk will convince people who are annoyed by
swapping in the morning.

> One slightly more practical solution from the "you-now-who gets angry
> mails" POV anyway, would be to tie the reduced-rate scanning to the load
> average -- if nothing at all happens, swap-out doesn't need to happen
> either.

If nothing at all happens, does it matter that pages are written to
swap?  They're still in RAM as well.

-- Jamie
