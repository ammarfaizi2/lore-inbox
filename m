Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWBIWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWBIWst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWBIWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:48:49 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:12492 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750741AbWBIWss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:48:48 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
Date: Fri, 10 Feb 2006 09:48:26 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Paul Jackson <pj@sgi.com>
References: <200602092339.49719.kernel@kolivas.org> <200602100047.09722.kernel@kolivas.org> <43EB4FD5.20107@yahoo.com.au>
In-Reply-To: <43EB4FD5.20107@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100948.27601.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 01:21, Nick Piggin wrote:
> Con Kolivas wrote:
> > I really don't want to go throwing out pagecache without some smart
> > semantics and then swap in random stuff that could be crap I agree. The
> > answer to this is for the vm itself to have an ageing algorithm like the
> > clockpro stuff which does this in a smart way. It could certainly age
> > away the updatedb wrinkles and leave some free ram - which would help/be
> > helped by prefetching.
>
> AFAIK clockpro will not leave free ram, will it?
>
> Getting a little hand-wavy; I don't think the updatedb problem needs to
> be fixed by a really fancy page reclaim algorithm (IMO, and that's not to
> say that a fancy reclaim algorithm wouldn't be nice for other reasons).
> Just small improvements here and there, and there will always be a tradeoff
> between throughput and interactive pagein latency so in the end it might
> need a tunable (hey there is one - maybe it needs to be improved)

Well I have a handful of patches for just that issue... However they all fall 
into the "it's too hard to prove to Andrew and Nick that they help" so I've 
never bothered trying to push them to mainline.

Cheers,
Con
