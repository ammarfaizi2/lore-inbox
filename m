Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWIVIfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWIVIfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWIVIfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:35:52 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:61965 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750833AbWIVIfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:35:52 -0400
Date: Fri, 22 Sep 2006 09:35:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, davidsen@tmr.com, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060922083542.GA4246@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, jeff@garzik.org,
	davidsen@tmr.com, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921220539.GL26683@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 06:05:39PM -0400, Dave Jones wrote:
> We already have some subsystems that do once-per-release merges,
> and then let fixes build up in their out-of-tree SCM for months
> until the next window. It won't necessarily get worse, but unless
> everyone is participating in the odd/even rules, we won't get
> the benefits that it would offer.

I'm heading in that direction (once-per-release merges) actually.

On one hand, I'm credited with the ARM architecture being one of the
best maintained embedded architectures in the kernel tree.  On the
other hand, that appears to be winding Linus up due to the regular
merge requests, which were happening maybe once or twice a week.

Linus seems to be of the opinion that, if anyone can't wait a number
of months for their patch to get into mainline, then they shouldn't
be involved in this game.  The content of the tree which that comment
was made at contained (imho) just bug fixes.

At the moment, we're up to 528kB (initial commit Aug 21st) of IOP3xx
and S3C24xx machine updates, and various other developments.  As for
the other trees, MMC (9kB since Aug 27) and serial (20kB since Aug 30)
but neither have been looked at for a while, certainly not post 2.6.18.
I'm not even responding to mail about these because I haven't been even
thinking about them yet.

As far as -mm getting these, I have asked Andrew to pull this tree in
the past, but whenever I rebase the trees (eg, when 2.6.18 comes out)
and fix up the rejects, Andrew seems to have a hard time coping.  I
guess Andrew finds it too difficult to handle my devel branches.

Where I go from here I'm not sure - I'm running out of ideas for
correct "Care and Operation of (my) Linus Torvalds", except becoming
one of the Bad People who only merge _lots_ of changes once in a blue
moon.

So, what I'm going to be doing this cycle is essentially sitting on
stuff for quite some time and not really caring about where in the
release cycle mainline actually is.  (Anyone remember Linus moaning
at various people for doing exactly this?  Eg, ALSA people?)  It
pains me to do this because it's obviously not the _correct_ thing
to do, but I don't see any other way of keeping Linus happy.  And this
does mean giving up all hope of getting anything in mainline.

As far as my future, I will be handing MMC off to Pierre Ossman during
this cycle (there are other reasons for doing this which Pierre has been
aware of for some time.)

I'll also be dropping my serial tree entirely - I have no idea who could
stand in for serial, so there's going to be no real "hand over" for that.
I do have some outstanding in-progress changes which aren't really ready,
but those will probably end up in /dev/null (in much the same way that my
in-progress changes for PCMCIA ended up in a similar place when I handed
that tree over.)

So, it's going to mean that the only thing I'm going to be caring about
post-2.6.19 is ARM again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
