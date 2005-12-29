Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVL2WlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVL2WlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVL2WlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:41:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41665 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751073AbVL2WlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:41:08 -0500
Date: Thu, 29 Dec 2005 17:41:03 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: userspace breakage
Message-ID: <20051229224103.GF12056@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 12:49:16PM -0800, Linus Torvalds wrote:
 
 > Umm.. Complain more. I upgrade kernels a lot more often than I upgrade 
 > distros, and things don't break. They're not allowed to break, because I 
 > refuse to upgrade my user programs just because I do kernel development. 
 > But I'd only notice a small part of user space, so if people don't 
 > complain, they break not because we don't care, but because we didn't even 
 > know.
 > 
 > So if you have a user program that breaks, _complain_. It's really not 
 > supposed to happen outside of perhaps kernel module loaders etc things 
 > that get really really chummy with kernel internals (and even that was 
 > fixed: the modern way of loading modules isn't that chummy any more, so 
 > hopefully we'll not need to break even module loaders again).
 > 
 > If we change some /proc file thing, breakage is often totally 
 > unintentional, and complaining is the right thing - people might not even 
 > have realized it broke.
 > 
 > At least _I_ take breakage reports seriously. If there are maintainers 
 > that don't, complain to them. I'll back you up. Breaking user space simply 
 > isn't acceptable without years of preparation and warning.

The udev situation I mentioned has been known about for at least a month,
probably longer. With old udev, we don't get /dev/input/event* created
with 2.6.15rc.

At some point in time it became defacto that certain things like udev, hotplug,
alsa-lib, wireless-tools and a bunch of others have to have kept in lockstep
with the kernel, and if it breaks, it's your fault for not upgrading
your userspace.

Seriously, I (and many others) have been complaining about this
for months. (Pretty much every time the "Please can we have a 2.7"
thread comes up). [note, that I actually prefer the 'new' approach
to development in 2.6, what I object to is that at the same time we
threw out the 'lets be careful about not breaking userspace' mantra.]

Just a few years ago, if someone suggested breaking a userspace
app in a kernel upgrade, they'd be crucified on linux-kernel, now
it's 'the norm').

		Dave

