Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVCDCyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVCDCyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVCDCtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:49:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44082
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262768AbVCCXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:41:37 -0500
Date: Fri, 4 Mar 2005 00:41:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303234130.GR8880@opteron.random>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <1109888144.21780.53.camel@localhost.localdomain> <20050303223203.GA24966@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303223203.GA24966@havoc.gtf.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 05:32:03PM -0500, Jeff Garzik wrote:
> On Thu, Mar 03, 2005 at 10:15:46PM +0000, Alan Cox wrote:
> > We still need 2.6.x.y updates on a more official footing and with more
> > than one person as the "2.6.x.y" maintainer. I think that is actually
> > more important.
> 
> That appears to be the consensus conclusion we've arrived at.

FWIW I'm still unconvinced changing the 2.6.x naming scheme in any way
is needed to accomplish the goal of having more time to develop some
significant feature.

Another thing I'm unconvinced is that any numbering scheme could change
the amount of testing of the non-final stuff. The thing is that a lot of
users are just users, and they're not willing to test experimental
things, they've no time and no money to do that, they only need the
kernel running stable and fast. So I wouldn't even try to change the
release numbering if the object is to increase the testing userbase.

Comparing the number of people downloading the 2.6.11 compared to the
number of people downloading 2.6.11-rc5 is just like comparing apples to
oranges. We've to work with the oranges and we shouldn't expect
the apples to help with that. (this ignoring that lots of apples runs
the distro kernels anyways, I do too in my productive environments)

I don't see why we don't start with a very short 2.7.0/2.7.1/2.7.2
semi-stable cycle then after a few months we call it 2.8.0?  What's the
point of that 2.6 number, just to waste network bandwidth, disk space,
pixels and keypresses?

This way would be backwards compatible with the old numbering habits.

Perhaps one day we could even get a 3.0 kernel that way ;)

This still requires somebody taking care of a 2.6.12 if a security issue
showup, but 2.6.12 should not be developed any further since after a few
months 2.8.0 would be there already, so perhaps you can take care of the
security issues yourself without handing it off to a maintainer
dedicated to it.

This is very similar to what is being suggested except you want to
change the numbering scheme to do that, and that seems an unnecessary
complication to me.

The median number could go up to 255 without problems IIRC the limit is
256, like 2.200.0/1/2/3. So if Linus make a new release every week and 3
relases per stable/unstable cycle, we'll get 3.0.0 in another 14 years.

Still you can stack -pre/-rc on top of that.

So in short I don't really see the point of breaking the number scheme
to achieve your plan (whatever your plan is ;), 3 numbers + -pre/-rc
seems more than enough for whatever you're planning doing with the new 4th
number. You've just not to get emotional about 2.6/2.7 being magical and
unchangable, and to "unblock" them since now there seems to be need of
them for the first time (since 2.6 is getting mature but still we don't
want to slow down the development or wait years for the new features to
be usable and get stuck in heavy backports). You should just make clear
the semantics of 2.7 will not be the ones that 2.5 and 2.3 had.

I recall I made the example last year at KS that the 4th level ptes was
something that could open up 2.7, as Dave agreed that kind of stuff needs
a bit of time to settle, and 2.7 would have been ok for that, and a few
days ago you could have shipped a 2.8.0 instead of a 2.6.11! But at the
same time if a super security bug in the firewall code would showup
you'd be lined up to issue a 2.6.11 immediatly with only that bugfix in
it.

This will allow people to stay with the old rule, i.e. that if they use
the *.\..*[02468]\..* releases they're safe. No need to break this rule
established by decades to achieve your goal IMHO. Breaking rulings for
no good reason will only bring _more_confusion_ to the end user IMHO.

I've no idea if BK fits this, but (besides the fact I don't actually
care about that) it should pose you exactly same technical SCM troubles
that a fourth number would introduce, even ignoring the internal kernel
breakages with KERNEL_VERSION in include/linux/version.h.

Even with 2.6.8.1 I never got why it's called 2.6.8.1 and not 2.6.9,
what's the cost of a minor number, why to break the numbering? (even
ignoring that even 2.6.8.1 has an unstable VM that can underflow while
valuating the "min" value in alloc_pages due a NUMA patch, fixed by Nick
in 2.6.9-pre of course and is a more serious bug than what was fixed
between 2.6.8 and 2.6.8.1 IMHO ;)
