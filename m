Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVKJCeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVKJCeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 21:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVKJCeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 21:34:36 -0500
Received: from silver.veritas.com ([143.127.12.111]:25134 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751021AbVKJCeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 21:34:36 -0500
Date: Thu, 10 Nov 2005 02:33:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
In-Reply-To: <20051109181641.4b627eee.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
 <20051109181641.4b627eee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 02:34:35.0888 (UTC) FILETIME=[4A4A6F00:01C5E59F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Andrew Morton wrote:
> 
> hm.   I thought we were going to address this by
> 
> a) checking for an insane number of mappings of the same page in the
>    pagefault handler(s) and 
> 
> b) special-casing ZERO_PAGEs on the page unallocator path.
> 
> That'll generate faster and smaller code than adding an extra shift and
> possibly larger constants in lots of places.

I think we all had different ideas of how to deal with it.

When I outlined this method to you, you remarked "Hmm" or something
like that, which I agree didn't indicate great enthusiasm!

I'm quite pleased with the way it's worked out, but you were intending
that the 64-bit arches should get along with 32-bit counts?  Maybe.

Hugh
