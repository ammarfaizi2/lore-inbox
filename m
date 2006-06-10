Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbWFJBHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbWFJBHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbWFJBHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:07:19 -0400
Received: from thunk.org ([69.25.196.29]:1416 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030425AbWFJBHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:07:17 -0400
Date: Fri, 9 Jun 2006 21:06:51 -0400
From: Theodore Tso <tytso@mit.edu>
To: Sven-Haegar Koch <haegar@sdinet.de>
Cc: Michael Poole <mdpoole@troilus.org>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610010651.GA20202@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Sven-Haegar Koch <haegar@sdinet.de>,
	Michael Poole <mdpoole@troilus.org>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <87irnab33v.fsf@graviton.dyn.troilus.org> <Pine.LNX.4.64.0606100245130.12765@mercury.sdinet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606100245130.12765@mercury.sdinet.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 02:49:32AM +0200, Sven-Haegar Koch wrote:
> I see a different problem with "ext3 + extends is not ext3 anymore" when 
> the feature goes mainstream:
> - user with old distri, no extends in use, no kernel support for them
> - user has some kind of problem
> - uses new rescue disk (aka knoppix at the time of problem) - that then
>   is current stuff, and certainly uses extents - fixes problem on disk
>   (may be a simple as running lilo/grub from chroot, happens often for me)
> - tries to boot back into his distri -> *boom* he lost

Incorrect, because unless you explicitly enable the use of extents,
the mere act of using a new kernel such as might be found on knoppix
will not result in the filesystem utilizing the extent feature.

There's a lot FUD being spread by people who haven't been bothering to
understand what is being proposed, and that's disappointing.

						- Ted
