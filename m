Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUFPQ6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUFPQ6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUFPQyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:54:20 -0400
Received: from [213.146.154.40] ([213.146.154.40]:37532 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264192AbUFPQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:53:06 -0400
Date: Wed, 16 Jun 2004 17:53:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lori Gilbertson <loriann@sgi.com>
Cc: Dimitri Sivanich <sivanich@sgi.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, lm@bitmover.com
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-ID: <20040616165300.GA15411@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lori Gilbertson <loriann@sgi.com>,
	Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>, lm@bitmover.com
References: <20040616142413.GA5588@sgi.com> <200406161646.i5GGkO5e194114@theriver.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406161646.i5GGkO5e194114@theriver.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 11:46:24AM -0500, Lori Gilbertson wrote:
> hch wrote:
> 
> > Given you're @sgi.com address you probably know what
> > a freaking mess and maintaince nightmare IRIX has become because 
> > of that.
> 
> Hi Chris,
> 
> I'm very curious about this comment - wondering what you base it
> on?  I'm the engineering manager for IRIX real-time - we have
> no open bugs against it and have many customers depending on it.
> At least for the last 5 years had very low maintenance cost,
> mostly adding features, fixing a couple of bugs and producing new 
> releases.  
> 
> Perhaps you would be so kind to let me know what led you to
> your statement?

Looks at the overhead of the normal IRIX sleeping locks vs linux spinlock
(and the priority inversion and sleeping locks arguments are the next one
I'll get from you I bet :)), talk to Jeremy how the HBA performance went
down when he had to switch the drivers to the sleeping locks, look at the
complexity of the irix scheduler with it's gazillions of special cases
(and yes, I think the current Linux scheduler is already to complex), or
the big mess with interrupt thread.  

I've added Larry to the Cc list because he knows the IRIX internals much
better than I do (or at least did once) and has been warning of this move
that adds complexity to no end for all the special cases for at least five
years.  He also had some nice IRIX vs Linux benchmarks when Linux on Indys
was new.
