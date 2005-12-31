Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWAAC6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWAAC6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 21:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWAAC6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 21:58:40 -0500
Received: from hera.kernel.org ([140.211.167.34]:1697 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932177AbWAAC6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 21:58:40 -0500
Date: Sat, 31 Dec 2005 20:20:17 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>
Subject: Re: [PATCH 1/9] clockpro-nonresident.patch
Message-ID: <20051231222017.GC4024@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> <20051230224222.765.32499.sendpatchset@twins.localnet> <20051231011324.GB4913@dmt.cnet> <1136022886.17853.18.camel@twins> <Pine.LNX.4.63.0512310951210.27198@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512310951210.27198@cuia.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 09:53:11AM -0500, Rik van Riel wrote:
> On Sat, 31 Dec 2005, Peter Zijlstra wrote:
> 
> > > > +/*
> > > > + * For interactive workloads, we remember about as many non-resident pages
> > > > + * as we have actual memory pages.  For server workloads with large inter-
> > > > + * reference distances we could benefit from remembering more. 
> > > > + */
> > > 
> > > This comment is bogus. Interactive or server loads have nothing to do
> > > with the inter reference distance. To the contrary, interactive loads
> > > have a higher chance to contain large inter reference distances, and
> > > many common server loads have strong locality.
> > > 
> > > <snip>
> > 
> > Happy to drop it, Rik?
> 
> Sorry, but the comment is accurate.
> 
> For interactive workloads you want to forget interreference
> distances between two updatedbs, even if mozilla didn't get
> used all weekend.
> 
> OTOH, on NFS servers, or other systems with large interreference
> distances, you may _need_ to remember a larger set of non-resident
> pages in order to find the pages that are the hottest.
> 
> In those workloads, the shortest inter-reference distance might
> still be larger than the size of memory...

Sure, for the few cases you describe here the comment is valid.

Happy new year! 

