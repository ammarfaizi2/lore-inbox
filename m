Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933003AbWFZUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbWFZUHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933008AbWFZUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:07:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:62917 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933003AbWFZUHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:07:51 -0400
Date: Mon, 26 Jun 2006 22:03:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060626200300.GA15424@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623144928.GA32694@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623144928.GA32694@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> The code uses GFP_NOFAIL for slab allocator calls.  It's been pointed 
> out here numerous times that this can't work.  Andrew, what about 
> adding a check to slab.c to bail out if someone passes it?

reiserfs, jbd and NTFS are all using GFP_NOFAIL ...

i dont think this is a huge issue that should block merging.

	Ingo
