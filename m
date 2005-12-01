Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLAQUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLAQUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVLAQUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:20:42 -0500
Received: from kanga.kvack.org ([66.96.29.28]:12695 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932310AbVLAQUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:20:41 -0500
Date: Thu, 1 Dec 2005 11:17:50 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] linux-2.6-block: deactivating pagecache for benchmarks
Message-ID: <20051201161750.GF985@kvack.org>
References: <1133443547.6110.43.camel@noti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133443547.6110.43.camel@noti>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sort of patch split up is pointless.  The config option and Makefile 
changes belong with the code that implments them, as they are not meaningful 
standalone patches.

		-ben

On Thu, Dec 01, 2005 at 02:25:47PM +0100, Dirk Henning Gerdes wrote:
> the Makefile in linux/block
> 
> --- linux-2.6-block_clean/block/Makefile	2005-11-30 16:12:30.000000000
> +0100
> +++ linux-2.6-block-pagecache-clean/block/Makefile	2005-11-30 17:14:40.000000000 +0100
> @@ -8,3 +8,4 @@ obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosch
>  obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
>  obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
>  obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
> +obj-$(CONFIG_PAGECACHE_TOGGLE)        += pagecache.o
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
