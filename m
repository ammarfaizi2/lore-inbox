Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVHIXwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVHIXwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbVHIXwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:52:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17830 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750973AbVHIXwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:52:32 -0400
Date: Tue, 9 Aug 2005 19:52:14 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] non-resident page tracking
In-Reply-To: <20050809182517.GA20644@dmt.cnet>
Message-ID: <Pine.LNX.4.61.0508091950430.1888@chimarrao.boston.redhat.com>
References: <20050808201416.450491000@jumble.boston.redhat.com>
 <20050808202110.744344000@jumble.boston.redhat.com> <20050809182517.GA20644@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Marcelo Tosatti wrote:

> Two hopefully useful comments:
> 
> i) ARC and its variants requires additional information about page
> replacement (namely whether the page has been reclaimed from the L1 or
> L2 lists).
> 
> How costly would it be to add this information to the hash table?

Not at all.  Simply reduce the hash to 31 bits and use the remaining
bit to store that value.

> ii) From my reading of the patch, the provided "distance" information is
> relative to each hash bucket. I'm unable to understand the distance metric
> being useful if measured per-hash-bucket instead of globally?

The idea is that the hash function spreads things around evenly
enough for the different buckets to rotate at roughly the same
speed.

-- 
All Rights Reversed
