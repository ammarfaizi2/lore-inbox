Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTL1RWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTL1RWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:22:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:33544 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261774AbTL1RWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:22:21 -0500
Date: Sun, 28 Dec 2003 17:22:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Colin Ngam <cngam@sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031228172214.B21182@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Colin Ngam <cngam@sgi.com>, Pat Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com> <20031223090227.A5027@infradead.org> <3FE85533.E026DE86@sgi.com> <20031223165506.A8624@infradead.org> <3FEC8F0B.A8C30677@sgi.com> <20031228144415.B20391@infradead.org> <3FEF05B2.9184ABA0@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FEF05B2.9184ABA0@sgi.com>; from cngam@sgi.com on Sun, Dec 28, 2003 at 10:32:51AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 10:32:51AM -0600, Colin Ngam wrote:
> > the now almost legacy SHUB/PIC based Altixens?  Well, even if SGI does this
> 
> SHUB/PIC based Altixens are not Legacy in any form shape or manner.  I expect
> these IO Chipsets to drive Altix for the foreseable near future ..

Well, it looks like TIO is replacing it soon, doesn't it?


> Please do not question my resolve to drive us towards this direction.  Things can
> always change, but I am heading this direction.

Well, again talk is cheap, if you show the code this whole discussion
would be avoid.  I've done my part of showing the code and the only thing
I get in reply is bad flames and random obsfucations to break that code.

> architecture.  That is not a problem at all.  For ia64 Altix line, we want
> to follow what's being done on other ia64 platform.  Is this not the
> right approach?  You yourself had mentioned above that this is the
> way to go?

Again, I'd be more than happy if you moved that code to the PROM.  But as
long as we have code in the kernel to deal with that hardware different ports
should share it.  And as mentioned above I have that strong feeling that
for the first generation Altixens this is never going to happen.  Of course
I'd be more than happy to be proven wrong.

> This code sharing will not be possible when we do all of our initialization
> in System BIOS, just like every other ia64 platform.

Again, if you do that I'd be more than happy.  But as long as we need that
code in the kernel it should be done properly.

> Moreover, the ia64
> Altix line does not support Bridge/Xbridge chipsets and we do not want
> to be burdened by these legacy code as we move forward with the ia64
> product line.

Guess what, the current iommu code has exactly three lines of code that
make sense only for bridge.  Not to mention that I'll have no problem with
maintaining all that code, so you don't have to maintain more but rather
less code.  (In a double sense, given that the new code is also much
smaller despite support for the older revisions)

