Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVLEG32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVLEG32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 01:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVLEG32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 01:29:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24848 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751346AbVLEG31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 01:29:27 -0500
Date: Mon, 5 Dec 2005 07:26:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205062609.GA7096@alpha.home.local>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204232454.GG8914@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I've been following most of this thread but did hot take the time to
jump in.

On Sun, Dec 04, 2005 at 03:24:54PM -0800, Greg KH wrote:
> On Sun, Dec 04, 2005 at 12:56:50PM +0100, Matthias Andree wrote:
> > The problem is the upstream breaking backwards compatibility for no good
> > reason. This can sometimes be a genuine unintended regression (aka.
> > bug), but quite often this is deliberate breakage because someone wants
> > to get rid of cruft. While the motivation is sound, breaking between
> > 2.6.N and 2.6.M must stop.
> 
> What are we breaking that people are complaining so much about?
> Specifics please.

Speaking for myself, I will not be complaining about specific things
which break, but I'll explain my point of view on the real problem.

The kernel has entered a permanent development phase, with some
versions more stable/usable than others. You and Chris do a
wonderful job at producing stable versions. I know how difficult
it is, for doing the same in 2.4 (and 2.4 moves slower than 2.6).

However, the problem is that you stop maintaining old versions
and quickly switch to new ones when a new kernel comes up. I know
it's not easy, and may be terribly more difficult to maintain
several versions in a development kernel than in a stable kernel.
But imagine the users' position : they run 2.6.14.3 which finally
fixes all their problems. Then they get a new problem, but 2.6.15
comes out. There will not be any other 2.6.14, so they have the
choice of staying to 2.6.14.3 or jumping to fresh new and barely
tested 2.6.15.

People have been surprized that I still maintain several old
versions of 2.4 at once, but I've received lots of "thank you"
emails from people who still relied on them for a particular
tree which does not evolve as fast as mainline. And 2.4 is
easier to follow than 2.6.

What I think should be done is to still maintain older 2.6
(eg: 2, 3 or 4 previous releases) so that people will have
the time to switch to a new one. And I think that what Adrian
wants to do would be useful *only* if he proceeds that way.
 
Maybe you should just join forces, eg Chris and you to catch
new patches, and Adrian to merge them to older kernels ? Every
software maker always supports a few older releases for the
people who need to stay on something stable, and it is clearly
what is missing now in 2.6.

Also, I think differently from Adrian. He wants to backport
all new drivers and new features, while I think that they are
the most sensible parts and the one which bring the more
changes to the kernel. In fact, we should *only* maintain
security and critical fixes on older releases. People in the
need of a new driver must upgrade for this. This is the
difference between staying on an old thing because you don't
need to upgrade and switching to a new one because you need
this new shiny feature. It follows the "if it ain't broke,
don't fix it" rule. Users will never excuse you for breaking
their working kernels by adding something they don't use.

I would have liked to help in this area (I even discussed
about maintaining a 2.6-stable a long time ago) but I don't
have enough time for this. 2.4 is already time-consuming.

Regards,
Willy

