Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVHVWT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVHVWT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVHVWTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:19:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:3976 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751358AbVHVWTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:19:16 -0400
Date: Mon, 22 Aug 2005 11:50:40 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6 patch] include/linux/quotaops.h: "extern inline" doesn't make sense
Message-ID: <20050822095040.GU12076@atrey.karlin.mff.cuni.cz>
References: <20050820192551.GE3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820192551.GE3615@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "extern inline" doesn't make sense.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Looks good.

  Signed-off-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
>  include/linux/quotaops.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.13-rc6-mm1/include/linux/quotaops.h.old	2005-08-20 14:40:53.000000000 +0200
> +++ linux-2.6.13-rc6-mm1/include/linux/quotaops.h	2005-08-20 14:41:30.000000000 +0200
> @@ -198,38 +198,38 @@
>  #define DQUOT_SYNC(sb)				do { } while(0)
>  #define DQUOT_OFF(sb)				do { } while(0)
>  #define DQUOT_TRANSFER(inode, iattr)		(0)
> -extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
> +static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
>  {
>  	inode_add_bytes(inode, nr);
>  	return 0;
>  }
>  
> -extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
> +static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
>  {
>  	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
>  	mark_inode_dirty(inode);
>  	return 0;
>  }
>  
> -extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
> +static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
>  {
>  	inode_add_bytes(inode, nr);
>  	return 0;
>  }
>  
> -extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
> +static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
>  {
>  	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
>  	mark_inode_dirty(inode);
>  	return 0;
>  }
>  
> -extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
> +static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
>  {
>  	inode_sub_bytes(inode, nr);
>  }
>  
> -extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
> +static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
>  {
>  	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
>  	mark_inode_dirty(inode);
> 
