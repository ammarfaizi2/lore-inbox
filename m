Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVKQOTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVKQOTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVKQOTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:19:21 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:54927 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750846AbVKQOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:19:21 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] mm: is_dma_zone
Date: Fri, 18 Nov 2005 01:19:00 +1100
User-Agent: KMail/1.8.3
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200511180059.51211.kernel@kolivas.org> <1132236943.5834.70.camel@localhost>
In-Reply-To: <1132236943.5834.70.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180119.01250.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005 01:15, Dave Hansen wrote:
> On Fri, 2005-11-18 at 00:59 +1100, Con Kolivas wrote:
> > +static inline int is_dma(struct zone *zone)
> > +{
> > +       return zone == zone->zone_pgdat->node_zones + ZONE_DMA;
> > +}
>
> Any reason you can't just use 'zone_idx(z) == ZONE_DMA' here, just like
> the code you replaced?

I was just following the style of the is_highmem and is_normal immediately 
preceeding this. No strong reason otherwise.

Cheers,
Con
