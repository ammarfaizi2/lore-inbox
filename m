Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWB1MJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWB1MJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWB1MJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:09:55 -0500
Received: from colin.muc.de ([193.149.48.1]:17937 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932506AbWB1MJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:09:54 -0500
Date: 28 Feb 2006 13:09:47 +0100
Date: Tue, 28 Feb 2006 13:09:47 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, largret@gmail.com, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060228120947.GA19275@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com> <20060226102152.69728696.akpm@osdl.org> <1140988015.5178.15.camel@shogun.daga.dyndns.org> <20060226133140.4cf05ea5.akpm@osdl.org> <20060226235142.GB91959@muc.de> <Pine.LNX.4.64.0602271429270.12204@schroedinger.engr.sgi.com> <20060228004115.GA37362@muc.de> <20060227165921.242f6810.akpm@osdl.org> <20060228012553.GA52585@muc.de> <20060227173830.5fee084f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227173830.5fee084f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 05:38:30PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > > I was thinking that your __GFP_NOOOM was a thinko.  How would it differ
> > > from __GFP_NORETRY?
> > 
> > __GFP_NORETRY seems to skip at least one retry pass as far as I can see.
> > __GFP_NOOOM wouldn't. But perhaps the additional pass only makes sense
> > with oom killing? I'm not sure - that is why i was asking.
> > 
> 
> Oh, OK.  That final get_page_from_freelist() is allegedly to see if a
> parallel oom-killing freed some pages - we already know that
> try_to_free_pages() didn't work.
> 
> I rather doubt that it'll make any difference.

I switched over the x86-64 IOMMU code and floppy code to use
__GFP_NORETRY now.

But perhaps it would be better to rename it to __GFP_NOOOM
because I think that would express its meaning better.

-Andi

