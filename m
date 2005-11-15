Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbVKOXBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVKOXBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVKOXBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:01:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5278 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965069AbVKOXBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:01:19 -0500
Date: Tue, 15 Nov 2005 15:00:54 -0800
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/5] Light Fragmentation Avoidance V20:
 001_antidefrag_flags
Message-Id: <20051115150054.606ce0df.pj@sgi.com>
In-Reply-To: <20051115164952.21980.3852.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
	<20051115164952.21980.3852.sendpatchset@skynet.csn.ul.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
>  #define __GFP_VALID	((__force gfp_t)0x80000000u) /* valid GFP flags */
>  
> +/*
> + * Allocation type modifier
> + * __GFP_EASYRCLM: Easily reclaimed pages like userspace or buffer pages
> + */
> +#define __GFP_EASYRCLM   0x80000u  /* User and other easily reclaimed pages */
> +

How about fitting the style (casts, just one line) of the other flags,
so that these added six lines become instead just the one line:

   #define __GFP_EASYRCLM   ((__force gfp_t)0x80000u)  /* easily reclaimed pages */

(Yeah - it was probably me that asked for -more- comments sometime in
the past - consistency is not my strong suit ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
