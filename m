Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUDWXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUDWXug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUDWXug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:50:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7677 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261779AbUDWXub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:50:31 -0400
Date: Fri, 23 Apr 2004 16:50:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Arthur Othieno <a.othieno@bluewin.ch>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] include/asm-ppc/dma-mapping.h: dma_unmap_page()
Message-ID: <20040423235028.GM13455@smtp.west.cox.net>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org> <20040114161306.GA16950@stop.crashing.org> <20040423191429.GA14356@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423191429.GA14356@mars>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Playing catchup ]

On Fri, Apr 23, 2004 at 09:14:29PM +0200, Arthur Othieno wrote:

> Hi,
> 
> Duplicate definition of dma_unmap_single() should actually be
> dma_unmap_page().
> 
> Against 2.6.6-rc2. Thanks.
> 
> 
>  dma-mapping.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> --- a/include/asm-ppc/dma-mapping.h	2004-04-11 14:05:45.000000000 +0200
> +++ b/include/asm-ppc/dma-mapping.h	2004-04-22 18:06:53.000000000 +0200
> @@ -77,7 +77,7 @@ dma_map_page(struct device *dev, struct 
>  }
>  
>  /* We do nothing. */
> -#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
> +#define dma_unmap_page(dev, addr, size, dir)	do { } while (0)
>  
>  static inline int
>  dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,

If this hasn't made it in already, it would appear to be correct and
should go in.

-- 
Tom Rini
http://gate.crashing.org/~trini/
