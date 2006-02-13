Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWBMU7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWBMU7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWBMU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:59:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58030 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030187AbWBMU7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:59:07 -0500
Date: Mon, 13 Feb 2006 12:58:58 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v25
In-Reply-To: <200602120141.46084.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0602131256000.3026@schroedinger.engr.sgi.com>
References: <200602120141.46084.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Feb 2006, Con Kolivas wrote:

> Once pages have been added to the swapped list, a timer is started, testing
> for conditions suitable to prefetch swap pages every 5 seconds. Suitable
> conditions are defined as lack of swapping out or in any pages, and no
> watermark tests failing. Significant amounts of dirtied ram and changes in
> free ram representing disk writes or reads also prevent prefetching.
> 
> It then checks that we have spare ram looking for at least 3* pages_high free
> per zone and if it succeeds that will prefetch pages from swap into the swap
> cache. The pages are added to the tail of the inactive list to preserve LRU
> ordering.

spare ram when swapping??? We are already under memory pressure. Why make 
it worse by getting rid of the few bits of available memory? If a system 
swaps then we are per definition in the bad performance range. Add more
memory.
