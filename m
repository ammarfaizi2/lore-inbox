Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTI3I0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTI3I0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:26:49 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:18894 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261186AbTI3I0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:26:47 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030930010855.095c2c35.davem@redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
	 <1064903562.6154.160.camel@imladris.demon.co.uk>
	 <20030930000302.3e1bf8bb.davem@redhat.com>
	 <1064907572.21551.31.camel@hades.cambridge.redhat.com>
	 <20030930010855.095c2c35.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1064910398.21551.41.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 09:26:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 01:08 -0700, David S. Miller wrote:
> If the user sets CONFIG_IPV6 to 'm' from 'n', and make then creates a
> new kernel image for him (which it will if dependencies are working
> correctly), if he can't figure out that he's gotta install that thing
> maybe he should enable module symbol versions to protect him from
> insmod'ing that ipv6 module by mistake.

Why would he run 'make'? He'll only run 'make modules' since he only
enabled one extra module, and then he expects to be able to load it
without a reboot.

He expects this because it is intuitive ('just a new module') and
because it is true for just about all other modular options in the tree.

> The suggestions I see do nothing to enhance the kernel tree as it currently
> stands.  If you wish to prevent the kernel image from changing due to
> out-of-tree modules being built, fine, but don't impose this restriction
> upon in-kernel modules.

It's a matter of taste. As I said, it's your right to disagree.

Some time during 2.7 I'm sure one of the many people who agree with
Adrian and myself will send patches to Linus and he'll get to arbitrate.

-- 
dwmw2

