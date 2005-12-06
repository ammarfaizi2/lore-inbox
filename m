Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVLFNUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVLFNUz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbVLFNUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:20:55 -0500
Received: from gate.in-addr.de ([212.8.193.158]:37505 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751464AbVLFNUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:20:54 -0500
Date: Tue, 6 Dec 2005 14:20:07 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206132007.GU21914@marowsky-bree.de>
References: <20051203135608.GJ31395@stusta.de> <20051203205911.GX18919@marowsky-bree.de> <87wtij2iao.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wtij2iao.fsf@mid.deneb.enyo.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-12-06T01:14:23, Florian Weimer <fw@deneb.enyo.de> wrote:

> > The right way to address this is to work with the distribution of your
> > choice to make these updates available faster.
> Working with a distribution benefits that distribution alone.  Working
> on (e.g.) kernel security advisories would benefit everyone.  It's not
> a speed issue, it's more about coverage.  And full coverage is very
> hard to get without support from the real developers.

The distributions differ from another in their sync and branch points
from the main kernel, and there's no way before hell freezes over this
is going to change.

So, you essentially need to maintain the kernel your distribution
branched from. This means: backport fixes/features relevant to your
release, and make sure the rest of the system stays in sync. This puts
the effort there where it belongs: to those people benefitting from it.

The current model actually works _better_ for the existing
distributions, because they get to choose their branchpoint - with all
the features up to that point - instead of having, say, 2.6.x as the
stable base and then already starting out with having to backport major
features from 2.7 (because of user demand).

A single stable branch beneficial to all users means frozen innovation
for the distributions, and they still have to significant QA on the
releases and the updates to that kernel (to stay on that issue, it
applies to other major components too). Even with 2.4.x, a distribution
couldn't simply stick in newer 2.4.x+n releases instead of 2.4.x,
because, as someone already so well said, one users bugfix is another's
regression. And all the distributors would have to agree on the same
policy for kernel changes and sync even updates!

Thus, more effort for less gain.

The truth is that right now we have _several_ stable branches maintained
by the distributors (be they commercial or free) together with the
kernel-related user-land.

I daresay this is a feature and works pretty well.

If someone wants to maintain a stable 2.6.x release, nobody will stop
them from maintaining 2.6.x.y until y overflows, or until the 6 months
are full and then they can release their new major update and plot a
transition path with the updates to all required user-land.

The fact people are complaining about stems from the fact that the Linux
kernel itself is useless; it is intimately tied to various components
which reside in user-space, and so it is inherent to the process that a
major kernel update very likely maps to a distribution update. The
components are developed separately, but they do not have a stable
modular interface, at essentially no level but the POSIX/system call
interfaces and sometimes, glibc or what is specified in the LSB.

This is a _feature_! It allows us to more quickly move and adapt. The
BSD model is, as Dave pointed out, even further along this road, and
every distribution basically does exactly that, because our user
community is big enough to sustain it.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

