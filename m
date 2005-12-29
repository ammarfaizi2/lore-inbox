Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVL2W4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVL2W4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVL2W4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:56:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751077AbVL2W4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:56:32 -0500
Date: Thu, 29 Dec 2005 14:56:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: userspace breakage
In-Reply-To: <20051229224103.GF12056@redhat.com>
Message-ID: <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Dave Jones wrote:
> 
> At some point in time it became defacto that certain things like udev, hotplug,
> alsa-lib, wireless-tools and a bunch of others have to have kept in lockstep
> with the kernel, and if it breaks, it's your fault for not upgrading
> your userspace.

Hmm.. Time for some re-indoctrination?

We really shouldn't allow that. I know who to blame for udev, who else 
should I complain to?

> Just a few years ago, if someone suggested breaking a userspace
> app in a kernel upgrade, they'd be crucified on linux-kernel, now
> it's 'the norm').

That really isn't acceptable. Breaking user space - even things that are 
"close" to the kernel like udev scripts and alsa-lib, really is NOT a good 
idea.

We're much better off wasting a bit of time on backwards compatibility, 
than wasting a lot of user time and irritation (and indirectly, developer 
time) on linkages to packages outside the kernel.

If you cannot upgrade a kernel without ugrading some user package, that 
should be considered a real bug and a regression.

There are real technical reasons for not allowing those kinds of version 
linkages: it makes it MUCH harder to blame the right thing when things go 
wrong. 

Now, I'm not saying that we can always support everything that goes on in 
user space forever, but dammit, we can try damn hard.

(Somehow I'm not surprised about alsa. I think the whole alsa release 
process has always sucked. Dang).

			Linus
