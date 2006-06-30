Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWF3SI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWF3SI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWF3SI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:08:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35750 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932984AbWF3SI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:08:28 -0400
Date: Fri, 30 Jun 2006 19:08:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/namei.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630180823.GA321@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060630113309.GU19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630113309.GU19712@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 01:33:09PM +0200, Adrian Bunk wrote:
> This patch marks an unused export as EXPORT_UNUSED_SYMBOL.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-mm4-full/fs/namei.c.old	2006-06-30 04:01:55.000000000 +0200
> +++ linux-2.6.17-mm4-full/fs/namei.c	2006-06-30 04:02:47.000000000 +0200
> @@ -2785,7 +2785,7 @@
>  	.put_link	= page_put_link,
>  };
>  
> -EXPORT_SYMBOL(__user_walk);
> +EXPORT_UNUSED_SYMBOL(__user_walk);  /*  June 2006  */

This can just go away ASAP.  People who need it can just __user_walk_fd
with AT_FDCWD as dfd argument.  While you're at it please kill the whole
function, not just the export.

