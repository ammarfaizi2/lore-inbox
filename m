Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWERHVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWERHVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWERHVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:21:53 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:228 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750839AbWERHVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:21:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: limit lowmem_reserve
Date: Thu, 18 May 2006 17:21:38 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200605180011.43216.kernel@kolivas.org> <446C1E25.4080408@yahoo.com.au>
In-Reply-To: <446C1E25.4080408@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181721.38735.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 17:11, Nick Piggin wrote:
> If we're under memory pressure, kswapd will try to free up any candidate
> zone, yes.
>
> > On my test case this indeed happens and my ZONE_DMA never goes below 3000
> > pages free. If I lower the reserve even further my pages free gets stuck
> > at 3208 and can't free any more, and doesn't ever drop below that either.
> >
> > Here is the patch I was proposing
>
> What problem does that fix though?

It's a generic concern and I honestly don't know how significant it is which 
is why I'm asking if it needs attention. That concern being that any time 
we're under any sort of memory pressure, ZONE_DMA will undergo intense 
reclaim even though there may not really be anything specifically going on in 
ZONE_DMA. It just seems a waste of cycles doing that.

-- 
-ck
