Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVBZLR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVBZLR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 06:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVBZLR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 06:17:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65295 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261162AbVBZLRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 06:17:54 -0500
Date: Sat, 26 Feb 2005 11:17:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050226111748.A1816@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org> <20050225222720.D27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251444590.9237@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0502251444590.9237@ppc970.osdl.org>; from torvalds@osdl.org on Fri, Feb 25, 2005 at 02:49:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 02:49:05PM -0800, Linus Torvalds wrote:
> On Fri, 25 Feb 2005, Russell King wrote:
> > That's fine until you consider the wide number of machines for ARM,
> > any of which could have this problem.
> 
> Fair enough. "ARM" doesn't end up being just one architecture, and that's 
> a good point.
> 
> > Unless of course, you believe that one person should carry everything,
> > which is what I feel your above comment is effectively saying.
> 
> No, let me be the last to argue for centralized Q&A. Doesn't work. I'd
> rather argue that it's not an issue of trying to get everybody to upgrade
> and making old versions "not supported". It seems more benign than that,
> in that it should be sufficient if there were just enough new versions out
> there, for some arbitrary value of "enough".
> 
> In particular, it seems downright _wrong_ that an issue like this has been 
> around forever, and nothing has actually been done about the fundamental 
> problem. At some point, "kernel build bandages" are just not worth it any 
> more, if people aren't even trying to actually fix the real issue.

Unfortunately, the makeup of the ARM community is mostly developer-based,
where developers are working away at getting something running on some
custom platform.  Since all the platforms are different, it means that
they're working in their own unique space.

If we had a single platform, or even a small number of platforms, then
your approach does make sense - a small number of people could use a
CVS version and be sure to cover 99 if not 100% of the cases.

However, with such a large number of platforms, there will always be
a significant chance where a small number of people will never see the
problems seen by the majority.

To put it another way, the code coverage achieved by a small number of
people running the fixed toolchains would be no where near good enough.

Having a properly working toolchain is of upmost importance for us.  In
reality though, we don't have sufficient weight of people with the right
mindset behind the toolchain to ensure bugs in or problems with it are
found quickly.  There are unfortunately plenty of users who are happy to
try to work around bugs without reporting them.

Another problem with the toolchain is the constant feature churn, with
old features which are in use vanishing, or documentated behaviour
suddenly being turned upon its head and being called a bug, fixed in
the toolchain code and then sometime later the documentation may get
updated if anyone noticed.  This, in itself, provides _me_ at least with
a big disincentive to upgrade from a version of the toolchain which has
been proven to work.  History has taught me that at every step.

So, I have to do _something_ to ensure that we have a reasonable status
quo in place.  Correction: _I_ don't have to do anything at all if I
don't care about Linux kernels standing a chance of being built correctly
by less experienced developers using buggy toolchains.  Then again, maybe
_that_ is the correct approach.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
