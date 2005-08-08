Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVHHUaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVHHUaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVHHUaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:30:30 -0400
Received: from imladris.surriel.com ([66.92.77.98]:16308 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S932215AbVHHUa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:30:29 -0400
Date: Mon, 8 Aug 2005 16:30:17 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] non-resident page tracking
In-Reply-To: <20050808.132603.93023622.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61L.0508081628580.15038@imladris.surriel.com>
References: <20050808201416.450491000@jumble.boston.redhat.com>
 <20050808202110.744344000@jumble.boston.redhat.com>
 <20050808.132603.93023622.davem@davemloft.net>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, David S. Miller wrote:

> > @@ -359,7 +362,10 @@ struct page *read_swap_cache_async(swp_e

> > -			lru_cache_add_active(new_page);
> > +			if (activate >= 0)
> > +				lru_cache_add_active(new_page);
> > +			else
> > +				lru_cache_add(new_page);
> 
> This change is totally unrelated to the rest of the
> patch, and is not mentioned in the changelog.  Could
> you explain it?

Oops, you're right.  This is part of the replacement policy in
CLOCK-Pro, ARC, CART, etc. and should have been in a separate
patch.

This is what I get for pulling an all-nighter. ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
