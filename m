Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVCCAF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVCCAF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVCCABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:01:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:20703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbVCBX7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:59:40 -0500
Date: Wed, 2 Mar 2005 16:00:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <42265023.20804@pobox.com>
Message-ID: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Jeff Garzik wrote:
> 
> 30?  Try 310 changesets, in my netdev-2.6 pending queue.

Note that I don't think a 2.6.<even> would have problems with things like 
driver updates.

This was somewhat brought on (at least for me, dunno about Davem) by 
things like 4-level page tables etc stuff. I don't think most people even 
realized how _smoothly_ that thing seems to have gone, even if the ppc64 
people ended up having some really nasty debugging (and they came through 
with flying colors, but they probably didn't much enjoy the thing).

I would not keep regular driver updates from a 2.6.<even> thing. But I 
_would_ try to keep things like all the TSO pain, the 4-level page tables, 
and in general big merges that have been in CVS trees etc, and can't claim 
to be "lots of small stuff".

For example, there's some fundamental 16-bit PCMCIA cleanups pending in
the -mm tree, meaning that the kernel can work with PCMCIA cards without a
"cardmgr" deamon. That would be something that is _not_ appropriate in the
first stable version. That doesn't mean that individual PCMCIA device 
drivers could not get updated.

But hey, you may be right. It might just not be obvious enough which class 
any particular merge falls under.

		Linus
