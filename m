Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVGYXG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGYXG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGYXEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:04:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261212AbVGYXDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:03:55 -0400
Date: Tue, 26 Jul 2005 00:03:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050726000347.A913@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <20050725170419.C7629@flint.arm.linux.org.uk> <20050725220659.GF8684@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050725220659.GF8684@elf.ucw.cz>; from pavel@suse.cz on Tue, Jul 26, 2005 at 12:06:59AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 12:06:59AM +0200, Pavel Machek wrote:
> > > Also it looks to me like mcp.h should go into asm/arch-sa1100, so
> > > that other drivers can use it...
> > 
> > That doesn't make sense when you have other non-SA1100 devices using
> > mcp-core.c.  Whether that happens or not I've no idea - I can't see
> > what everyone's using out there (just like I've absolutely zero
> > idea what collie folk are doing or not doing.)
> 
> set_telecom_divisor relies on CONFIG_SA1100 being set (otherwise it
> breaks compilation, because struct members will not be available; at
> least in this version), so I doubt it has many non-SA1100 users...

That's not conclusive in itself - if it's only usable on SA1100
platforms, why was that ifdef added?

> > So, if the collie folk would like to clean their changes up and send
> > them to me as the driver author, I'll see about integrating them into
> > my version and we'll take it from there.
> 
> Okay, will do. [Is there chance to pull your tree using git? It would
> help a bit...]

My git usage is limited to the final stage of my development - iow
providing an integration and test bed for merging upstream.  My work
prior to that is all patch based (as per the tarball of patches I
posted previously) with scripts to manage them - I like the power to
re-order, split, merge, insert and remove patches at random, which
includes whole series of patches vs individual patches themselves.

Consequently, if I were to publish my git trees, what you'll find is
that they're indentical copies of Linus' tree except for maybe when
Linus is away, or hasn't pulled that night, or...

What you're actually seeing with the UCB stuff is the effect of me
stopping maintaining the -rmk trees - code effectively got "dropped"
from public view at that point, and I'm not going to start publishing
such a tree any time soon.  It completely detracts from the task of
ensuring mainline kernels work for ARM - since the -rmk tree is/was
seen as the tree for everything ARM to be merged into, and hence
upstream merging became my problem.  No, never again will I make a
fool of myself like that.  Hence, I'll never again publish a kernel
tree myself, except maybe for very limited purposes.

However, if the UCB stuff is going to get worked on, I don't mind
setting up, maintaining and publishing a git tree for that that,
provided it then vanishes once merged into mainline.  That falls
within the "very limited purposes" clause above.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
