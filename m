Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVAOBMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVAOBMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVAOBM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:12:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42470 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262091AbVAOBLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:11:03 -0500
Date: Fri, 14 Jan 2005 20:16:44 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator V2
Message-ID: <20050114221644.GE3336@logos.cnet>
References: <Pine.LNX.4.58.0501131552400.31154@skynet> <20050114213619.GA3336@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114213619.GA3336@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You want to do 
> 		free_pages -= (z->free_area_lists[0][o].nr_free + z->free_area_lists[2][o].nr_free +
										   ^^^^ = 1
>                 		z->free_area_lists[2][o].nr_free) << o;

I meant the sum of the free lists. You'd better use the defines instead of course :)

> So not to interfere with the "min" decay (and remove the allocation type loop). 
