Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVILUN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVILUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVILUN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:13:27 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:63636
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932197AbVILUN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:13:26 -0400
Date: Mon, 12 Sep 2005 16:09:14 -0400
From: Sonny Rao <sonny@burdell.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
Message-ID: <20050912200914.GA13962@kevlar.burdell.org>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912145435.GA4722@kevlar.burdell.org> <20050912125641.4b53553d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912125641.4b53553d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 12:56:41PM -0700, Andrew Morton wrote:
> Sonny Rao <sonny@burdell.org> wrote:
> >
> > On Mon, Sep 12, 2005 at 02:43:50AM -0700, Andrew Morton wrote:
> > <snip>
> > > - There are several performance tuning patches here which need careful
> > >   attention and testing.  (Does anyone do performance testing any more?)
> > <snip>
> > > 
> > >   - The size of the page allocator per-cpu magazines has been increased
> > > 
> > >   - The page allocator has been changed to use higher-order allocations
> > >     when batch-loading the per-cpu magazines.  This is intended to give
> > >     improved cache colouring effects however it might have the downside of
> > >     causing extra page allocator fragmentation.
> > > 
> > >   - The page allocator's per-cpu magazines have had their lower threshold
> > >     set to zero.  And we can't remember why it ever had a lower threshold.
> > > 
> > 
> > What would you like? The usual suspects:  SDET, dbench, kernbench ?
> > 
> 
> That would be a good start, thanks.  The higher-order-allocations thing is
> mainly targeted at big-iron numerical computing I believe.

I assume you're referring to allocating huge pages?  I'm not sure how
one would test this other than allocating N huge pages, releasing,
runing something intensive (like SDET), and then trying to allocate
N huge pages again?  Or am I off base here?

Sonny
