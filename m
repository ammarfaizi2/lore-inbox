Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVCCJQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVCCJQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVCCJPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:15:12 -0500
Received: from orb.pobox.com ([207.8.226.5]:23995 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261728AbVCCJMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:12:35 -0500
Date: Thu, 3 Mar 2005 01:12:24 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303091224.GB9796@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:37:44PM -0800, Linus Torvalds wrote:
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
[snip]
> > 2.6.x-pre: bugfixes and features
> > 2.6.x-rc: bugfixes only
> 
> And the reason it does _not_ work is that all the people we want testing 
> sure as _hell_ won't be testing -rc versions.

Maybe that's because you redefined "rc" to mean "ridiculous count"?
People would rather test a release candidate than a ridiculous count. ;)

> That's the whole point here, at least to me. I want to have people test 
> things out, but it doesn't matter how many -rc kernels I'd do, it just 
> won't happen. It's not a "real release".
> 
> In contrast, making it a real release, and making it clear that it's a 
> release in its own right, might actually get people to use it. 
> 
> Might. Maybe.

Am I the only person here who doesn't see it as "either/or"? ISTM that
"odd/even" and the "2.4 approach" are orthogonal issues.

What about something like the following? (It probably needs tweaks but
it might be worth considering.)

2.6.odd-alpha1: Equivalent to 2.6.x-rc1.
...
2.6.odd-alphaA: Equivalent to 2.6.x-rcA. (A is a constant. Linus gets to
                set it, perhaps before relesing alpha1. Perhaps A=1 or
                A=2 could be tried for the 2.6.13 cycle. Setting it to
                an arbitrary value should free Linus's brain for other
                matters.)
2.6.odd-beta1:  Equivalent to 2.6.x-rc(A+1).
...
2.6.odd-betaX:  Equivalent to the last 2.6.x-rc in the current scheme.
2.6.odd-rc1:    Equivalent to 2.6.x *RELEASE* now.
...
2.6.odd:        *Identical* to last 2.6.odd-rc. Not a single patch of
                difference, except for the version number! If you
                committed anything since 2.6.odd-rcX, then either (a)
                you need to make a 2.6.odd-rc(X+1), or (b) you committed
                something that should have waited for the next 2.6.odd.
2.6.even-beta1: Skipping -alpha because we're only going for bugfixes
                in even, right? (*Please* listen to davej and don't
                treat drivers differently than core code. If you must
                include major driver updates, then don't skip -alpha.)
...
2.6.even-rc1:   This is when you think you're completely done with
                2.6.even and you think it's time to upload the final
                release.
...
2.6.even:       This is the last 2.6.even-rc, with no changes. (Same -rc
                rules as for 2.6.odd-rc.)
(...cycle repeats...)

For an approximation of the so-called "2.4 approach", let A=0 and
s/beta/pre/g. Perhaps the alpha/beta distinction won't *really* mean
anything, but it might have a subliminal effect on everyone. :) Anyway,
if the alpha/beta distinction is overengineering, it's easily removed
(see the beginning of this paragraph).

Whether with alpha/beta or just plain pre, this seems more robust to me
than the other suggestions so far.

-Barry K. Nathan <barryn@pobox.com>
