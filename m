Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVHHU0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVHHU0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVHHU0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:26:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48013
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932212AbVHHU0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:26:13 -0400
Date: Mon, 08 Aug 2005 13:26:03 -0700 (PDT)
Message-Id: <20050808.132603.93023622.davem@davemloft.net>
To: riel@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] non-resident page tracking
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050808202110.744344000@jumble.boston.redhat.com>
References: <20050808201416.450491000@jumble.boston.redhat.com>
	<20050808202110.744344000@jumble.boston.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@redhat.com>
Date: Mon, 08 Aug 2005 16:14:17 -0400

> @@ -359,7 +362,10 @@ struct page *read_swap_cache_async(swp_e
>  			/*
>  			 * Initiate read into locked page and return.
>  			 */
> -			lru_cache_add_active(new_page);
> +			if (activate >= 0)
> +				lru_cache_add_active(new_page);
> +			else
> +				lru_cache_add(new_page);
>  			swap_readpage(NULL, new_page);
>  			return new_page;

This change is totally unrelated to the rest of the
patch, and is not mentioned in the changelog.  Could
you explain it?
