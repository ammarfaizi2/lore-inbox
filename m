Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVILT5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVILT5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVILT5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:57:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932182AbVILT5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:57:21 -0400
Date: Mon, 12 Sep 2005 12:56:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
Message-Id: <20050912125641.4b53553d.akpm@osdl.org>
In-Reply-To: <20050912145435.GA4722@kevlar.burdell.org>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	<20050912145435.GA4722@kevlar.burdell.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao <sonny@burdell.org> wrote:
>
> On Mon, Sep 12, 2005 at 02:43:50AM -0700, Andrew Morton wrote:
> <snip>
> > - There are several performance tuning patches here which need careful
> >   attention and testing.  (Does anyone do performance testing any more?)
> <snip>
> > 
> >   - The size of the page allocator per-cpu magazines has been increased
> > 
> >   - The page allocator has been changed to use higher-order allocations
> >     when batch-loading the per-cpu magazines.  This is intended to give
> >     improved cache colouring effects however it might have the downside of
> >     causing extra page allocator fragmentation.
> > 
> >   - The page allocator's per-cpu magazines have had their lower threshold
> >     set to zero.  And we can't remember why it ever had a lower threshold.
> > 
> 
> What would you like? The usual suspects:  SDET, dbench, kernbench ?
> 

That would be a good start, thanks.  The higher-order-allocations thing is
mainly targeted at big-iron numerical computing I believe.

I've already had one report of fragmentation-derived page allocator
failures (http://bugzilla.kernel.org/show_bug.cgi?id=5229).

