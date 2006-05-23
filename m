Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWEWQ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWEWQ3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWEWQ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:29:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26534 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750713AbWEWQ3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:29:53 -0400
Date: Tue, 23 May 2006 09:29:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Chris Wright <chrisw@sous-sol.org>
cc: akpm@osdl.org, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: remove extra cpuset_zone_allowed check in
 __alloc_pages
In-Reply-To: <20060523063500.GB18769@moss.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0605230929070.9765@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
 <20060522182356.fbea4aec.pj@sgi.com> <Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
 <20060522192248.b114fea3.pj@sgi.com> <Pine.LNX.4.64.0605221925350.7272@schroedinger.engr.sgi.com>
 <20060523063500.GB18769@moss.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply removing my patch from mm will do the same.

Ack-by: Christoph Lameter <clameter@sgi.com>.



On Mon, 22 May 2006, Chris Wright wrote:

> This is redundant with check in wakeup_kswapd.
> 
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  mm/page_alloc.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -951,8 +951,7 @@ restart:
>  		goto got_pg;
>  
>  	do {
> -		if (cpuset_zone_allowed(*z, gfp_mask|__GFP_HARDWALL))
> -			wakeup_kswapd(*z, order);
> +		wakeup_kswapd(*z, order);
>  	} while (*(++z));
>  
>  	/*
> 
