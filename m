Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVJQRaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVJQRaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVJQRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:30:39 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:27538 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751178AbVJQRai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:30:38 -0400
Date: Mon, 17 Oct 2005 19:30:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: WU Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Adaptive read-ahead v4
Message-ID: <20051017173034.GA6558@wohnheim.fh-wedel.de>
References: <20051015174731.GA5851@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051015174731.GA5851@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 October 2005 01:47:31 +0800, WU Fengguang wrote:
>
> @@ -131,6 +133,63 @@ struct page_state {
>  
>  	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
>  	unsigned long nr_bounce;	/* pages for bounce buffers */
> +
> +	unsigned long cache_miss;	/* read cache misses */
> +	unsigned long readrandom;	/* random reads */
> +	unsigned long pgreadrandom;	/* random read pages */
> +	unsigned long readahead_rescue; /* read-aheads rescued*/
> +	unsigned long pgreadahead_rescue;
> +	unsigned long readahead_end;	/* read-aheads passed EOF */
> +
> +	unsigned long readahead;	/* read-aheads issued */
> +	unsigned long readahead_return;	/* look-ahead marks returned */
> +	unsigned long readahead_eof;	/* read-aheads stop at EOF */
> +	unsigned long pgreadahead;	/* read-ahead pages issued */
> +	unsigned long pgreadahead_hit;	/* read-ahead pages accessed */
> +	unsigned long pgreadahead_eof;
> +
> +	unsigned long ra_newfile;	/* read-ahead on start of file */
> +	unsigned long ra_newfile_return;
> +	unsigned long ra_newfile_eof;
> +	unsigned long pgra_newfile;
> +	unsigned long pgra_newfile_hit;
> +	unsigned long pgra_newfile_eof;
> +
> +	unsigned long ra_state;		/* state based read-ahead */
> +	unsigned long ra_state_return;
> +	unsigned long ra_state_eof;
> +	unsigned long pgra_state;
> +	unsigned long pgra_state_hit;
> +	unsigned long pgra_state_eof;
> +
> +	unsigned long ra_context;	/* context based read-ahead */
> +	unsigned long ra_context_return;
> +	unsigned long ra_context_eof;
> +	unsigned long pgra_context;
> +	unsigned long pgra_context_hit;
> +	unsigned long pgra_context_eof;
> +
> +	unsigned long ra_contexta;	/* accelerated context based read-ahead */
> +	unsigned long ra_contexta_return;
> +	unsigned long ra_contexta_eof;
> +	unsigned long pgra_contexta;
> +	unsigned long pgra_contexta_hit;
> +	unsigned long pgra_contexta_eof;
> +
> +	unsigned long ra_backward;	/* prefetch pages for backward reading */
> +	unsigned long ra_backward_return;
> +	unsigned long ra_backward_eof;
> +	unsigned long pgra_backward;
> +	unsigned long pgra_backward_hit;
> +	unsigned long pgra_backward_eof;
> +
> +	unsigned long ra_random;	/* read-ahead on seek-and-read-pages */
> +	unsigned long ra_random_return;
> +	unsigned long ra_random_eof;
> +	unsigned long pgra_random;
> +	unsigned long pgra_random_hit;
> +	unsigned long pgra_random_eof;
> +
>  };

Without actually understanding what you're doing, wouldn't a struct
for all those groups make sense?  I bet it can simplify the actual
code as well.

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
