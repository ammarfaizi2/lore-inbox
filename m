Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTI3Iz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbTI3Iz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:55:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261235AbTI3Iz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:55:26 -0400
Date: Tue, 30 Sep 2003 01:51:25 -0700
From: "David S. Miller" <davem@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-Id: <20030930015125.5de36d97.davem@redhat.com>
In-Reply-To: <1064911360.21551.49.camel@hades.cambridge.redhat.com>
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
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 09:42:41 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> 'make modules' should make the modules. If for some reason this really
> does require the core kernel image to be present and up to date, perhaps
> for modversions, then I agree that it should also rebuild the core
> kernel.

So it's OK for modversions to make modules depend upon the main kernel
image, but it's not OK for ipv6 to do the same exact thing.  Is this
what you're saying?

> If there's no actual dependency on the core kernel image, however, then
> it should not be rebuilt for 'make modules'. If 'make modules' was
> equivalent to 'make all' then it should not exist at all.

I don't see how you can say that modversions can create this module
dependency upon the kernel image, but ipv6 is not allowed to.

And this doesn't turn 'make modules' into the same thing as 'make all'.
It will still behave differently in a lot of situations.
