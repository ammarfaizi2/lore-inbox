Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWGVR1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWGVR1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWGVR1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:27:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60382 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750927AbWGVR1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:27:36 -0400
Date: Sat, 22 Jul 2006 10:27:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>, Andrew Morton <akpm@osdl.org>
Cc: rpurdie@rpsys.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ppc32 zImage inflate
Message-ID: <20060722172734.GK24522@smtp.west.cox.net>
References: <87u05dhquk.fsf@slug.be.48ers.dk> <87lkqoj564.fsf@slug.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lkqoj564.fsf@slug.be.48ers.dk>
Organization: Embedded Alley Solutions, Inc
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 06:01:23AM +0200, Peter Korsgaard wrote:
> >>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
> 
>  Peter> Hi,
>  Peter> The recent zlib update (commit
>  Peter> 4f3865fb57a04db7cca068fed1c15badc064a302) broke ppc32 zImage
>  Peter> decompression as it tries to decompress to address zero and the
>  Peter> updated zlib_inflate checks that strm->next_out isn't a null pointer.
> 
>  Peter> This little patch fixes it.
> 
> Crap - forgot to sign off :/
> 

Acked-by: Tom Rini <trini@kernel.crashing.org>

> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> diff -Naur linux-2.6.18-rc2.orig/lib/zlib_inflate/inflate.c linux-2.6.18-rc2/lib/zlib_inflate/inflate.c
> --- linux-2.6.18-rc2.orig/lib/zlib_inflate/inflate.c	2006-07-20 10:26:21.000000000 +0200
> +++ linux-2.6.18-rc2/lib/zlib_inflate/inflate.c	2006-07-20 17:02:27.000000000 +0200
> @@ -347,7 +347,7 @@
>      static const unsigned short order[19] = /* permutation of code lengths */
>          {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
>  
> -    if (strm == NULL || strm->state == NULL || strm->next_out == NULL ||
> +    if (strm == NULL || strm->state == NULL ||
>          (strm->next_in == NULL && strm->avail_in != 0))
>          return Z_STREAM_ERROR;
> 
> -- 
> Bye, Peter Korsgaard
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tom Rini
