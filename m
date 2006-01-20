Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWATCiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWATCiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161408AbWATCiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:38:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57989 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161204AbWATCiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:38:16 -0500
Date: Thu, 19 Jan 2006 18:38:02 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink_list: Use of && instead || leads to unintended
 writing of pages
In-Reply-To: <20060119182718.575bd08a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601191836490.14139@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0601191602260.13428@schroedinger.engr.sgi.com>
 <20060119164341.0fb9c7e3.akpm@osdl.org> <Pine.LNX.4.62.0601191648440.13602@schroedinger.engr.sgi.com>
 <20060119172032.04bad017.akpm@osdl.org> <Pine.LNX.4.62.0601191744390.13937@schroedinger.engr.sgi.com>
 <20060119182718.575bd08a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Andrew Morton wrote:

> >  @@ -1512,7 +1512,7 @@ loop_again:
> >   	total_scanned = 0;
> >   	total_reclaimed = 0;
> >   	sc.gfp_mask = GFP_KERNEL;
> >  -	sc.may_writepage = 0;
> >  +	sc.may_writepage = 1;
> >   	sc.may_swap = 1;
> >   	sc.nr_mapped = read_page_state(nr_mapped);
> 
> The balance_pgdat() change is wrong, surely?  We want !laptop_mode.

I did not see any special processing there like in the other place. But 
you could be right.

