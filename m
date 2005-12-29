Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVL2XZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVL2XZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVL2XZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:25:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751156AbVL2XZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:25:50 -0500
Date: Fri, 30 Dec 2005 00:25:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: userspace breakage
Message-ID: <20051229232548.GT3811@stusta.de>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 02:56:16PM -0800, Linus Torvalds wrote:
> 
> On Thu, 29 Dec 2005, Dave Jones wrote:
>...
> > Just a few years ago, if someone suggested breaking a userspace
> > app in a kernel upgrade, they'd be crucified on linux-kernel, now
> > it's 'the norm').
> 
> That really isn't acceptable. Breaking user space - even things that are 
> "close" to the kernel like udev scripts and alsa-lib, really is NOT a good 
> idea.
> 
> We're much better off wasting a bit of time on backwards compatibility, 
> than wasting a lot of user time and irritation (and indirectly, developer 
> time) on linkages to packages outside the kernel.
> 
> If you cannot upgrade a kernel without ugrading some user package, that 
> should be considered a real bug and a regression.
> 
> There are real technical reasons for not allowing those kinds of version 
> linkages: it makes it MUCH harder to blame the right thing when things go 
> wrong. 
> 
> Now, I'm not saying that we can always support everything that goes on in 
> user space forever, but dammit, we can try damn hard.
>...

Was it a mistake to drop support for ipfwadm and ipchains?
Was it a mistake to drop support for devsfs?
Will it be a mistake to drop support for gcc < 3.2?
Will it be a mistake to remove the obsolete raw driver?
Will it be a mistake to drop the Video4Linux API 1 ioctls?
Will it be a mistake to drop support for pcmcia-cs?
...

And if any of these was or will not be a mistake, when is the right time  
for the userspace breakage?

I did agree with what you express before support for ipchains was 
removed and support for devfs was removed, and many more I do not 
remember currently, but I've now simply accepted that regarding kernel 
development, 6 is an odd number.

The fundamental problem is that the current development model 
contains no well-defined points where breakages of the kernel-related 
userspace were allowed and expected by users.

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

