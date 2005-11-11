Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVKKKqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVKKKqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVKKKqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:46:10 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24762 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932233AbVKKKqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:46:09 -0500
Date: Fri, 11 Nov 2005 11:46:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051111104616.GA24238@elte.hu>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu> <20051110042613.7a585dec.akpm@osdl.org> <Pine.LNX.4.62.0511101335140.16283@schroedinger.engr.sgi.com> <20051110215255.GA25712@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110215255.GA25712@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Nov 10, 2005 at 01:37:19PM -0800, Christoph Lameter wrote:
> > On Thu, 10 Nov 2005, Andrew Morton wrote:
> > 
> > > spinlock in struct page, and the size of the spinlock varies a lot according
> > > to config.  The only >wordsize version we really care about is
> > > CONFIG_PREEMPT, NR_CPUS >= 4.  (which distros don't ship...)
> > 
> > Suse, Debian and Redhat ship such kernels.
> 
> No.  SuSE and Redhat have always been smart enough to avoid 
> CONFIG_PREEMPT like the plague, and even Debian finally noticed this a 
> few month ago.

while you are right about CONFIG_PREEMPT, there is some movement in this 
area: CONFIG_PREEMPT_VOLUNTARY is now turned on in Fedora kernels, and 
PREEMPT_BKL is turned on for SMP kernels.

	Ingo
