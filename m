Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291541AbSBHM3M>; Fri, 8 Feb 2002 07:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291555AbSBHM3E>; Fri, 8 Feb 2002 07:29:04 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46194 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291541AbSBHM2t>; Fri, 8 Feb 2002 07:28:49 -0500
Date: Fri, 8 Feb 2002 12:31:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix i810_dma.c freeing mem inside mem_map
In-Reply-To: <E16Z3Kb-0003cm-00@holomorphy>
Message-ID: <Pine.LNX.4.21.0202081229490.964-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, William Lee Irwin III wrote:
> --- linux/drivers/char/drm/i810_dma.c.bak	Thu Feb  7 21:09:49 2002
> +++ linux/drivers/char/drm/i810_dma.c	Thu Feb  7 21:09:59 2002
> @@ -301,7 +301,7 @@
>  		atomic_dec(&p->count);
>  		clear_bit(PG_locked, &p->flags);
>  		wake_up_page(p);
> -		free_page(p);
> +		free_page(page);
>  	}
>  }

What tree does this patch apply to?

Hugh

