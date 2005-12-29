Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVL2W7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVL2W7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVL2W7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:59:48 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:46512 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751103AbVL2W7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:59:47 -0500
Message-ID: <43B453CA.9090005@wolfmountaingroup.com>
Date: Thu, 29 Dec 2005 14:23:22 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
In-Reply-To: <20051229224103.GF12056@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




The breakage issue is ridiculous, assinine, and unnecessary. I have been 
porting dsfs to the various releases over the past month,
and the breakage of user space, usb, nfs, memory management, is beyond 
absurd. Instead of constantly breaking the
interfaces in Linux, why not tell people **NO** every time they try to 
rewrite the memory management, etc.

Instead of creating new capabilities and features, everyone seems hell 
bent on rewriting the same stale, mouldy, boring sections
of the OS over and over again. So how many times does the memory manage 
and slab allocator need to get rewritten. Or how many
times does the vfs need to get broken over and over again.

This bullshit is killing Linux, it's too much work to keep up with 
breakage, most of which is INTENTIONAL and NEEDLESS.

STOP STOP STOP!!!

I can't even apply a kdb patch between . releases of the kernel without 
seeing major breakage between Kprobes and some other
BS someone decides to change for no other reason than THEY CAN DO IT. I 
have seen memory corruption in the rrecent kernels.
When a component of the OS is finished, then leave it the hell alone.

The only NEW features in Linux are more drivers and more processors. 
Most of what's been going on in the development over the
past few months has been unnecessary breakage. If you are trying to get 
people to stay off Linux as a stable platform, you are all
succeeding.

Jeff

Dave Jones wrote:

>On Thu, Dec 29, 2005 at 12:49:16PM -0800, Linus Torvalds wrote:
> 
> > Umm.. Complain more. I upgrade kernels a lot more often than I upgrade 
> > distros, and things don't break. They're not allowed to break, because I 
> > refuse to upgrade my user programs just because I do kernel development. 
> > But I'd only notice a small part of user space, so if people don't 
> > complain, they break not because we don't care, but because we didn't even 
> > know.
> > 
> > So if you have a user program that breaks, _complain_. It's really not 
> > supposed to happen outside of perhaps kernel module loaders etc things 
> > that get really really chummy with kernel internals (and even that was 
> > fixed: the modern way of loading modules isn't that chummy any more, so 
> > hopefully we'll not need to break even module loaders again).
> > 
> > If we change some /proc file thing, breakage is often totally 
> > unintentional, and complaining is the right thing - people might not even 
> > have realized it broke.
> > 
> > At least _I_ take breakage reports seriously. If there are maintainers 
> > that don't, complain to them. I'll back you up. Breaking user space simply 
> > isn't acceptable without years of preparation and warning.
>
>The udev situation I mentioned has been known about for at least a month,
>probably longer. With old udev, we don't get /dev/input/event* created
>with 2.6.15rc.
>
>At some point in time it became defacto that certain things like udev, hotplug,
>alsa-lib, wireless-tools and a bunch of others have to have kept in lockstep
>with the kernel, and if it breaks, it's your fault for not upgrading
>your userspace.
>
>Seriously, I (and many others) have been complaining about this
>for months. (Pretty much every time the "Please can we have a 2.7"
>thread comes up). [note, that I actually prefer the 'new' approach
>to development in 2.6, what I object to is that at the same time we
>threw out the 'lets be careful about not breaking userspace' mantra.]
>
>Just a few years ago, if someone suggested breaking a userspace
>app in a kernel upgrade, they'd be crucified on linux-kernel, now
>it's 'the norm').
>
>		Dave
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

