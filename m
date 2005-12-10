Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVLJHDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVLJHDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVLJHDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:03:39 -0500
Received: from holomorphy.com ([66.93.40.71]:13747 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S964928AbVLJHDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:03:38 -0500
Date: Fri, 9 Dec 2005 23:02:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, David Gibson <david@gibson.dropbear.id.au>,
       Jens Axboe <axboe@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PageCompound avoid page[1].mapping
Message-ID: <20051210070248.GE2838@holomorphy.com>
References: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 09:56:42PM +0000, Hugh Dickins wrote:
> -	page[1].mapping = (void *)free_huge_page;
> +	page[1].index = (unsigned long)free_huge_page;	/* set dtor */
>  	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
>  		clear_highpage(&page[i]);
>  	return page;

Hmm, ->lru would be nicer. What prompted the use of ->index?


-- wli
