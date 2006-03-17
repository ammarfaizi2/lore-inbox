Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWCQSEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWCQSEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCQSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:04:20 -0500
Received: from verein.lst.de ([213.95.11.210]:63106 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751351AbWCQSET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:04:19 -0500
Date: Fri, 17 Mar 2006 19:03:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: carsteno@de.ibm.com
Cc: Jes Sorensen <jes@sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
Message-ID: <20060317180355.GA8232@lst.de>
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <20060316163728.06f49c00.akpm@osdl.org> <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org> <1142571490.9022.37.camel@localhost.localdomain> <441A7E34.90508@sgi.com> <441AB9A9.2000704@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441AB9A9.2000704@de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 02:29:13PM +0100, Carsten Otte wrote:
> Jes Sorensen wrote:
> > Well then the question is, would it simplify the code using no_pfn in
> > this case? Hacking up fake struct page entries seems even more of a
> > hack to me.
> I second that. That's were we are with our dcss xip thing today.
> It _is_ a hack to have a struct page that you don't need.

The same is true for the SPU support.  The way it's done currently works
which is great, but the way it's done is everything but nice.

