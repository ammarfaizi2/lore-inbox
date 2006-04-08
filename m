Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWDHBBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWDHBBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWDHBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:01:19 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:5540 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751381AbWDHBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:01:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: limit lowmem_reserve
Date: Sat, 8 Apr 2006 11:01:04 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200604081015.44771.kernel@kolivas.org> <443709F1.90906@yahoo.com.au>
In-Reply-To: <443709F1.90906@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604081101.06066.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 April 2006 10:55, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Friday 07 April 2006 22:40, Nick Piggin wrote:
> >>How would zone_watermark_ok always fail though?
> >
> > Withdrew this patch a while back; ignore
>
> Well, whether or not that particular patch isa good idea, it
> is definitely a bug if zone_watermark_ok could ever always
> fail due to lowmem reserve and we should fix it.

Ok. I think I presented enough information for why I thought zone_watermark_ok 
would fail (for ZONE_DMA). With 16MB ZONE_DMA and a vmsplit of 3GB we have a 
lowmem_reserve of 12MB. It's pretty hard to keep that much ZONE_DMA free, I 
don't think I've ever seen that much free on my ZONE_DMA on an ordinary 
desktop without any particular ZONE_DMA users. Changing the tunable can make 
the lowmem_reserve larger than ZONE_DMA is on any vmsplit too as far as I 
understand the ratio.

-- 
-ck
