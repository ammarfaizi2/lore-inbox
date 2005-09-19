Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVISUGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVISUGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVISUGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:06:17 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:45972
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932615AbVISUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:06:17 -0400
Date: Mon, 19 Sep 2005 16:01:36 -0400
From: Sonny Rao <sonny@burdell.org>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <20050919200136.GA22144@kevlar.burdell.org>
References: <20050916022319.12bf53f3.akpm@osdl.org> <20050916101700.GB14962@krispykreme> <20050916205517.GA8638@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916205517.GA8638@kevlar.burdell.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 04:55:17PM -0400, Sonny Rao wrote:
> On Fri, Sep 16, 2005 at 08:17:00PM +1000, Anton Blanchard wrote:
> > On Fri, Sep 16, 2005 at 02:23:19AM -0700, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
> > 
> > Builds and boots on ppc64 (POWER5) with the following patch, I forgot to
> > include siginfo.h when I added data breakpoint support. We must include
> > it in a round-a-bout way in mainline.
> 
> Excellent, now I'm about to start up perf testing on 2.6.14-rc1-mm1 
> 
> with and without the following patches:
> 
> mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch
>   mm: try to allocate higher order pages in rmqueue_bulk
> 
> mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk-fix.patch
>   mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk fix
> 
> mm-page_alloc-increase-size-of-per-cpu-pages.patch
>   mm: page_alloc: increase size of per-cpu-pages
> 
> mm-set-per-cpu-pages-lower-threshold-to-zero.patch
>   mm: set per-cpu-pages lower threshold to zero
> 

Here are the results:


bench		2.6.14-rc1-mm1		2.6.14-rc1-mm1-revert
--		--			--
kernbench	438.88 sec		439.49 sec	0.1 % slower
dbench3 (16)	1089.14 MB/sec		1062.89 MB/sec	2.5 % slower	

dbench3 was run on a tmpfs

To avoid certain issues, SDET is given in relative terms.

sdet (64)	100 %			100.2 % 


