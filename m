Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267801AbUHPRBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267801AbUHPRBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHPRBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:01:37 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50578 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S267801AbUHPRBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:01:23 -0400
Date: Mon, 16 Aug 2004 10:01:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Cc: akpm@osdl.org
Subject: Re: [PATCH][PPC32] export __dma_sync & __dma_sync_page
Message-ID: <20040816100121.B11412@home.com>
References: <20040815030717.GA23796@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040815030717.GA23796@gate.ebshome.net>; from ebs@ebshome.net on Sat, Aug 14, 2004 at 08:07:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 08:07:17PM -0700, Eugene Surovegin wrote:
> This patch adds missing exports for __dma_sync and __dma_sync_page (DMA API 
> helpers for non-coherent cache PPCs).
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> 
> ===== dma-mapping.c 1.2 vs edited =====
> --- 1.2/arch/ppc/kernel/dma-mapping.c	2004-07-28 21:58:35 -07:00
> +++ edited/dma-mapping.c	2004-08-14 19:15:56 -07:00
> @@ -381,6 +381,7 @@
>  		break;
>  	}
>  }
> +EXPORT_SYMBOL(__dma_sync);
>  
>  #ifdef CONFIG_HIGHMEM
>  /*
> @@ -438,3 +439,4 @@
>  	__dma_sync((void *)start, size, direction);
>  #endif
>  }
> +EXPORT_SYMBOL(__dma_sync_page);

Looks good to me. Andrew, please apply.

-Matt
