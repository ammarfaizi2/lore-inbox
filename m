Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVCCA2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVCCA2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVCCAXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:23:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:23198 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261373AbVCCAVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:21:23 -0500
Date: Wed, 2 Mar 2005 16:20:47 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303002047.GA10434@kroah.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 04:00:46PM -0800, Linus Torvalds wrote:
> 
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> > 
> > 30?  Try 310 changesets, in my netdev-2.6 pending queue.
> 
> Note that I don't think a 2.6.<even> would have problems with things like 
> driver updates.
> 
> This was somewhat brought on (at least for me, dunno about Davem) by 
> things like 4-level page tables etc stuff. I don't think most people even 
> realized how _smoothly_ that thing seems to have gone, even if the ppc64 
> people ended up having some really nasty debugging (and they came through 
> with flying colors, but they probably didn't much enjoy the thing).

I think this statement proves that the current development situation is
working quite well.  The nasty breakage and details got worked out in
the -mm tree, and then flowed into your tree when they seemed sane.

> I would not keep regular driver updates from a 2.6.<even> thing. But I 
> _would_ try to keep things like all the TSO pain, the 4-level page tables, 
> and in general big merges that have been in CVS trees etc, and can't claim 
> to be "lots of small stuff".

So, any driver stuff is just fine?  Great, I don't have an issue with
your proposal then, as it wouldn't affect me that much :)

I do understand what you are trying to achieve here, people don't really
test the -rc releases as much as a "real" 2.6.11 release.  Getting a
week of testing and bugfix only type patches to then release a 2.6.12
makes a lot of sense.  For example, see all of the bug reports that came
out of the woodwork today on lkml from the 2.6.11 release...

But accepting 310 netdev patches, 250 USB, 50 PCI, 50 I2c, and 100 ALSA
patches in one week and expect the tree to stay "stable" might be a
pretty unreasonable thing to wish for...

thanks,

greg k-h
