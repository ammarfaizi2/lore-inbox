Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUIELkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUIELkm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUIELki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:40:38 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:44294 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266485AbUIELkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:40:09 -0400
Date: Sun, 5 Sep 2004 12:39:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: rewrite the cache for file allocation table lookup (2/4)
Message-ID: <20040905123959.A29612@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <878ybpvtpz.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <878ybpvtpz.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Sun, Sep 05, 2004 at 08:30:16PM +0900
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#if 0
> +#define debug_pr(fmt, args...)	printk(fmt, ##args)
> +#else
> +#define debug_pr(fmt, args...)
> +#endif

We have a pr_debug() in <linux/kernel.h> that you could use.

> +static inline int fat_max_cache(struct inode *inode)
> +{
> +	return FAT_MAX_CACHE;
> +}

Do you plan to have per-inode caches later?  This seems rather useless
otherwise.

