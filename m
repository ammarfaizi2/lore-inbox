Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVACSsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVACSsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVACSpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:45:23 -0500
Received: from thunk.org ([69.25.196.29]:43935 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261779AbVACSl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:41:57 -0500
Date: Mon, 3 Jan 2005 13:36:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103183621.GA2885@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
	Diego Calleja <diegocg@teleline.es>,
	Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com,
	aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
	linux-kernel@vger.kernel.org
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:18:36PM -0500, Bill Davidsen wrote:
> I have to say that with a few minor exceptions the introduction of new
> features hasn't created long term (more than a few days) of problems. And
> we have had that in previous stable versions as well. New features
> themselves may not be totally stable, but in most cases they don't break
> existing features, or are fixed in bk1 or bk2. What worries me is removing
> features deliberately, and I won't beat that dead horse again, I've said
> my piece.

Indeed.  Part of the problem is that we don't get that much testing
with the rc* releases, so there are a lot of problems that don't get
noticed until after 2.6.x ships.  This has been true for both 2.6.9
and 2.6.10.  My personal practice is to never run with 2.6.x release,
but wait for 2.6.x plus one or 2 days (i.e. bk1 or bk2).  The problems
with this approach are that (1) out-of-tree patches against official
versions of the kernel (i.e., things like the mppc/mppe patch) don't
necessarly apply cleanly, and (2) other more destablizing patches get
folded in right after 2.6.x ships, so there is a chance bk1 or bk2 may
not be stable.

We could delay the destablizing changes until after rc1 ships, and
ship rc1 about 2-3 days after 2.6.x is released, so that the really
obvious/critical regressions can be addressed immediately.  The
problem with this approach though is that some people will just wait
until rc1 ships before they start using a new kernel version, and we
lose the testing we need to stablize the release.  

The real key, as always, is getting users to download and test a
release.  So another approach might be to shorten the time between
2.6.x and 2.6.x+1 releases, so as to recreate more testing points,
without training people to wait for -bk1, -bk2, -rc1, etc. before
trying out the kernel code.  This is the model that we used with the
2.3.x series, where the time between releases was often quite short.
That worked fairly well, but we stopped doing it when the introduction
of BitKeeper eliminated the developer synch-up problem.  But perhaps
we've gone too far between 2.6.x releases, and should shorten the time
in order to force more testing.  

							- Ted
