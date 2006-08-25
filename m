Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWHYONu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWHYONu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHYONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:13:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14794 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751434AbWHYONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:13:48 -0400
Date: Fri, 25 Aug 2006 15:13:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] BLOCK: Move bdev_cache_init() declaration to headerfile [try #2]
Message-ID: <20060825141347.GG10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213305.21323.66404.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213305.21323.66404.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:33:06PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Move the bdev_cache_init() extern declaration from fs/dcache.c to
> linux/blkdev.h.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/dcache.c            |    2 +-
>  include/linux/blkdev.h |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1b4a3a3..886ca6f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -32,6 +32,7 @@ #include <linux/security.h>
>  #include <linux/seqlock.h>
>  #include <linux/swap.h>
>  #include <linux/bootmem.h>
> +#include <linux/blkdev.h>
>  
>  
>  int sysctl_vfs_cache_pressure __read_mostly = 100;
> @@ -1742,7 +1743,6 @@ kmem_cache_t *filp_cachep __read_mostly;
>  
>  EXPORT_SYMBOL(d_genocide);
>  
> -extern void bdev_cache_init(void);
>  extern void chrdev_init(void);

please move chrdev_init aswell while you're at it.  Otherwise ok.

