Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbTI3J2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTI3J2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:28:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31104 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261237AbTI3J2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:28:02 -0400
Date: Tue, 30 Sep 2003 02:24:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930022410.08c5649c.davem@redhat.com>
In-Reply-To: <1064913241.21551.69.camel@hades.cambridge.redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	<20030928231842.GE1039@conectiva.com.br>
	<20030928232403.GX15338@fs.tum.de>
	<20030929220916.19c9c90d.davem@redhat.com>
	<1064903562.6154.160.camel@imladris.demon.co.uk>
	<20030930000302.3e1bf8bb.davem@redhat.com>
	<1064907572.21551.31.camel@hades.cambridge.redhat.com>
	<20030930010855.095c2c35.davem@redhat.com>
	<1064910398.21551.41.camel@hades.cambridge.redhat.com>
	<20030930013025.697c786e.davem@redhat.com>
	<1064911360.21551.49.camel@hades.cambridge.redhat.com>
	<20030930015125.5de36d97.davem@redhat.com>
	<1064913241.21551.69.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 10:14:02 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> Not at all. You're talking about something entirely different.

I think they are the same.  It's module building depending upon the
kernel image being up to date.

modules: vmlinux image
	... blah blah blah

or however you want to express it in the makefiles.

> In the 2.6 kernel, I suspect that these same version strings are now
> produced as a side-effect of the 'make vmlinux' stage, and hence that
> it's required to 'make vmlinux' before any modules can be built.

What this means is that it's required for the kernel image to be up to
date before any modules can be built.  If we can check that in the
build system for the sake of modversions (and if we're not doing that
now it's a bug we should fix) we can do it equally for ipv6.

> This (potential) dependency is entirely unrelated to any _changes_ in
> configuration.

I don't see how this changes the argument I'm trying to make.

I'm saying that either you accept that the kernel image must be
uptodate in order to build modules, or you don't.  It doesn't matter
what creates that dependency.

You can't say "the ipv6 thing is different because a config change
from 'n' to 'm' is creating the dependency", that doesn't make it
special.  In all such cases, modules require the kernel image they are
being built for to be uptodate.
