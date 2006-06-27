Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030698AbWF0HNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030698AbWF0HNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWF0HNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:13:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29622 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932549AbWF0HNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:13:07 -0400
Date: Tue, 27 Jun 2006 09:08:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627070817.GA30312@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org> <20060626200300.GA15424@elte.hu> <1151352749.3185.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151352749.3185.78.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Mon, 2006-06-26 at 22:03 +0200, Ingo Molnar wrote:
> > * Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > The code uses GFP_NOFAIL for slab allocator calls.  It's been pointed 
> > > out here numerous times that this can't work.  Andrew, what about 
> > > adding a check to slab.c to bail out if someone passes it?
> > 
> > reiserfs, jbd and NTFS are all using GFP_NOFAIL ...
> > 
> 
> they use it for slab or for get_free_pages() ?

for jbd and NTFS it's SLAB.

	Ingo
