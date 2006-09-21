Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWIUWII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWIUWII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWIUWII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:08:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17816 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751681AbWIUWIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:08:05 -0400
Date: Thu, 21 Sep 2006 18:05:39 -0400
From: Dave Jones <davej@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, davidsen@tmr.com, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060921220539.GL26683@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, jeff@garzik.org,
	davidsen@tmr.com, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921.145208.26283973.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 02:52:08PM -0700, David Miller wrote:

 > But even on that note I would love to have a release cycle where I
 > didn't merge any new features and could work entirely on the bugs
 > that never get worked on.

Would certainly be nice, even if we didn't do it every-other, but
once every half dozen or so releases.  I've been looking over the
osdl bugzilla recently (Ironically in a form of escapism from
the Fedora bugzilla). There's a ton of really old reports in there
that could be mopped up with a targetted bugfixing release.
Right now, with so many open bugs, it's difficult to get a real
picture of where the problem areas are because there's so much
crap in there. (Fedora's bugzilla is actually going through the
same problem right now too sadly, at least in part because
the last few releases have taken so damned long to come out, and
the -stable releases whilst an improvement, haven't gone far
enough to fixing a lot of issues users are seeing[*]).

 > Sure, I'll still be merging new features into my "N + 1" tree.
 > But my pure interactions with Linus's tree can focus entirely
 > on bug fixing, and I really want an environment in which to
 > concentrate on that exclusively.

There's nothing actually stopping you from enforcing this rule
in the trees you maintain though. You could do this for networking
in .19 without having a mandate from Linus that the kernel as
a whole is going to do the same.

Not that networking is an area that sees that many regressions
compared to other subsystems IMO. What's your secret? :)

 > I think the even/odd idea is great, personally.  And if this
 > makes some people have to wait a little bit longer for their
 > favorite feature to get merged, that's tough. :-)

My concern is that people will 'sit out' the even stage, and
just accumulate stuff in a single tree they dump once when
every odd release opens up.

We already have some subsystems that do once-per-release merges,
and then let fixes build up in their out-of-tree SCM for months
until the next window. It won't necessarily get worse, but unless
everyone is participating in the odd/even rules, we won't get
the benefits that it would offer.

	Dave

[*] I'm not demeaning Greg & Chris' work here at all, they've
been doing a stellar job, but I think we could use more people
going through the changelogs looking for stuff that needs
backporting.
