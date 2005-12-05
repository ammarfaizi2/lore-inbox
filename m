Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVLEKAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVLEKAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLEKAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:00:18 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:959 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1751098AbVLEKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:00:17 -0500
Date: Mon, 5 Dec 2005 11:00:10 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205100010.GA7896@merlin.emma.line.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com> <20051205062609.GA7096@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205062609.GA7096@alpha.home.local>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Willy Tarreau wrote:

> However, the problem is that you stop maintaining old versions
> and quickly switch to new ones when a new kernel comes up. I know
> it's not easy, and may be terribly more difficult to maintain
> several versions in a development kernel than in a stable kernel.
> But imagine the users' position : they run 2.6.14.3 which finally
> fixes all their problems. Then they get a new problem, but 2.6.15
> comes out. There will not be any other 2.6.14, so they have the
> choice of staying to 2.6.14.3 or jumping to fresh new and barely
> tested 2.6.15.

"Regression" as the threat of updating. That was the starting point :)

I believe the reason to abandon the previous "stable" branchlet was the
assumption that the new kernel had all fixes from the previous "stable"
merged, i. e. every patch between 2.6.14 and 2.6.14.3 would become part
of 2.6.15 (or the underlying problem addressed by a patch were resolved
some other way).

> What I think should be done is to still maintain older 2.6
> (eg: 2, 3 or 4 previous releases) so that people will have
> the time to switch to a new one. And I think that what Adrian
> wants to do would be useful *only* if he proceeds that way.

Perhaps a fixed number of releases doesn't cut it. Perhaps a fixed time
neither. If the changes betweeen two subsequent releases is low, one or
more extra versions come for free, but if lots of changes go in all over
the map, it's going to be a royal pain.

It ultimately boils down to the question: how far^Wfast the upstream
wants to run away^W^Wprogress from its previous release.

> Also, I think differently from Adrian. He wants to backport
> all new drivers and new features, while I think that they are
> the most sensible parts and the one which bring the more
> changes to the kernel. In fact, we should *only* maintain
> security and critical fixes on older releases. People in the
> need of a new driver must upgrade for this. This is the

I think there is no such thing as The Single One New Driver[tm]. Some
are quite intrusive, some aren't. Sometimes the new driver works with
older kernels (if the driver is self-contained, for instance just a
dozen new lines of code in an existing driver), sometimes not (because
midlayer or core changes are required to support the new driver).

-- 
Matthias Andree
