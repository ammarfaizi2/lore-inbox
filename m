Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVHJIkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVHJIkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVHJIkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:40:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965052AbVHJIkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:40:51 -0400
Date: Wed, 10 Aug 2005 04:40:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC 1/3] non-resident page tracking
In-Reply-To: <20050809211305.GA23675@dmt.cnet>
Message-ID: <Pine.LNX.4.61.0508100439510.1888@chimarrao.boston.redhat.com>
References: <20050808201416.450491000@jumble.boston.redhat.com>
 <20050808202110.744344000@jumble.boston.redhat.com> <20050809182517.GA20644@dmt.cnet>
 <1123614926.17222.19.camel@twins> <20050809211305.GA23675@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Marcelo Tosatti wrote:

> Well, not really "good approximation" it sounds to me, the sensibility
> goes down to L1_CACHE_LINE/sizeof(u32), which is:
> 
> - 8 on 32-byte cacheline
> - 16 on 64-byte cacheline 
> - 32 on 128-byte cacheline
> 
> Right?
> 
> So the (nice!) refault histogram gets limited to those values?

I agree that 7 would be too small.  I guess I should limit the
minimum size of the nonresident hash bucket to 15 entries...

-- 
All Rights Reversed
