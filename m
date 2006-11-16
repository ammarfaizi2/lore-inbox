Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161927AbWKPGjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161927AbWKPGjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161922AbWKPGjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:39:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161905AbWKPGjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:39:47 -0500
Date: Wed, 15 Nov 2006 22:39:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>
Subject: Re: Boot failure with ext2 and initrds
Message-Id: <20061115223937.fa7c1bad.akpm@osdl.org>
In-Reply-To: <20061115214534.72e6f2e8.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114184919.GA16020@skynet.ie>
	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	<20061114113120.d4c22b02.akpm@osdl.org>
	<Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	<20061115214534.72e6f2e8.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 21:45:34 -0800
Andrew Morton <akpm@osdl.org> wrote:

> --- a/fs/ext2/balloc.c~a
> +++ a/fs/ext2/balloc.c
> @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
>  	ext2_grpblk_t next;
>  
>  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
> -	if (next >= maxblocks)
> +	if (next >= start + maxblocks)
>  		return -1;
>  	return next;
>  }
> _
> 
> Anyway, I think that's the bug.

Changed my mind.  Drat.
