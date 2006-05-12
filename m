Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWELQ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWELQ7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWELQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:59:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750742AbWELQ7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:59:15 -0400
Date: Fri, 12 May 2006 09:59:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John Kelly <jak@isp2dial.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
In-Reply-To: <200605121630.k4CGUuiU005025@isp2dial.com>
Message-ID: <Pine.LNX.4.64.0605120949060.3866@g5.osdl.org>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
 <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
 <200605121619.k4CGJCtR004972@isp2dial.com> <Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com>
 <200605121630.k4CGUuiU005025@isp2dial.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, John Kelly wrote:
> 
> Users who need vintage features can use vintage kernels.  They haven't
> been pulled off the market.

I disagree.

We have two cases:

 - newer kernels don't always support vintage hardware any more. We don't, 
   for example, boot on 1MB PCs (I _think_ we used to), and quite frankly, 
   if you have 4MB, I'd be surprised it worked either (and that definitely 
   used to work a long time ago).

   Similarly, we've occsionally dropped a driver just because it wasn't 
   getting maintained, and we knew it couldn't work in the state it was 
   in. So over the years, machines have stopped being supported (that 
   said, if somebody complains, we try to re-instate the driver. Most 
   dropped drivers have never even been commented upon, because they 
   really aren't used any more. When was the last time you saw an MCA 
   machine or a PC98? I bet some people on this list have never even 
   heard of either)

 - we sometimes drop sw features that have been deprecated long ago, and 
   that there are better alternatives for. That said, this is pretty damn 
   rare too. I can remember Xiafs, and devfs is obviously on that path 
   too.

But we do _not_ drop features just because they are deemed "unnecessary". 
As long as somebody actually _uses_ smbfs, and as long as those users are 
willing to test and perhaps send in patches for when/if it breaks, we 
should not drop it.

The cost of keeping a filesystem is not normally very high. The way 
filesystems in particular get deprecated is if they have really serious 
problems, and nobody ends up being able or willing to fix them at all, and 
you _can_ migrate away. But if we're talking about win98, it probably 
still actually has a pretty big user base, and most of the machines that 
run it probably really cannot upgrade.

For exactly the same reason you mention:

	"Users who need vintage features can use vintage kernels."

ie you end up having people who have vintage hardware, and they use 
vintage kernels, but in their case, the "vintage" is Win95 or Win98. That 
does't mean that the _linux_ machine they use is necessarily vintage.

		Linus
