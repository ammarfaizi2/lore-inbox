Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVCHFxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVCHFxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCHFxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:53:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:39045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261329AbVCHFvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:51:19 -0500
Date: Mon, 7 Mar 2005 21:50:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-Id: <20050307215035.345c3f63.akpm@osdl.org>
In-Reply-To: <20050308054325.GA1262@infradead.org>
References: <20050308051818.GI3120@waste.org>
	<20050307213302.560de053.akpm@osdl.org>
	<20050308054325.GA1262@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 07, 2005 at 09:33:02PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > +	/* search for insertion point in reverse for dynamic allocation */
> > >  +	list_for_each_prev(l, list) {
> > 
> > hrmph.  Any time we do anything in O(n) time, some smarty comes along with
> > a workload which blows us out of the water.  Although it's hard to think of
> > any register_blkdev()-intensive workloads.
> > 
> > It's not possible to do this with prio-trees?
> 
> Andrew, I think in this particular case you suffer of a sporadic severe
> condition of overengineeritis.

heh.  I like to see our fancy data structures getting used.

> register_blkdev only happens at module_init time (and in fact should go
> away completely, so I'm not happy wit hthe surgey to keep it barely alive
> at all)

Is anyone working on that?
