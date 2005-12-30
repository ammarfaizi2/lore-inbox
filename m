Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVL3AqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVL3AqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVL3AqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:46:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48256 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751182AbVL3AqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:46:23 -0500
Date: Thu, 29 Dec 2005 19:46:08 -0500
From: Dave Jones <davej@redhat.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
Message-ID: <20051230004608.GA12822@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ryan Anderson <ryan@michonline.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B48176.3080509@michonline.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 07:38:14PM -0500, Ryan Anderson wrote:

 > The biggest complaint I've seen about udev isn't the fact that you
 > sometimes need to upgrade to use a new kernel, that's something that
 > people like Dave can handle via package dependencies.

Sure, we *can* do that, though the problem is it introduces latency between
the time I build a kernel, and time users can test it, as they have
to sit and wait for the userspace packages to also arrive.

There's a 2.6.15rc7 kernel that some Fedora Core 4 users could download
and play with right now. I thought it'd be great to get some extra testing
over the xmas holidays. Unfortunatly, due to the necessary udev upgrade, 
many users are turned off from testing by the inability to run X after
installing it.  It'll probably be some time in the new year when folks
like our udev packager get back from vacation before we get a test package for FC4.

The more people I'm reliant upon for having bits in place, the longer
users have to wait to be able to test, and the longer we all wait for
feedback.

 > The part of the udev situation that I've heard as a complaint (though I
 > haven't experienced myself) is that the new udev wasn't backwards
 > compatible with certain older kernels.  I think the description I've
 > heard is that you need one udev for < 2.6.12, one for 2.6.12 - 2.6.14,
 > and now a new one for 2.6.15, and at least, jumping from < 2.6.12 to
 > 2.6.15 is pretty much guaranteed to be difficult to get right.  (If the
 > kernel fails, you have a udev installed that won't work on the older
 > kernel correctly, apparently.)
 > 
 > This, for what it's worth, is the same breakage that Dave seemed to be
 > most frustrated with during his OLS keynote, regarding ALSA versions,
 > and a few other things that caused breakage and the user space failed to
 > work correctly when the kernel was reverted.  (I hope I'm not putting
 > words in your mouth, Dave).

Yep, That is another problem. It's not uncommon for someone to upgrade
to a new rebased kernel and its assorted userspace bits, then find out
their wireless card broke, so they go back to the old working kernel,
only to find the newer sound libraries misbehave on older kernels.
(ALSA isn't the only problem area here, but it's an easy target).

		Dave

