Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313962AbSDKBoS>; Wed, 10 Apr 2002 21:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313963AbSDKBoR>; Wed, 10 Apr 2002 21:44:17 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:21243
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313962AbSDKBoQ>; Wed, 10 Apr 2002 21:44:16 -0400
Date: Wed, 10 Apr 2002 18:46:30 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.5.8-pre] swapinfo accounting
Message-ID: <20020411014630.GK23513@matchmail.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0204101755170.25409-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 06:20:55PM -0700, Randy.Dunlap wrote:
> Anyway, here is the patch that makes it better.
> Not perfect, due to possibility of bad blocks, but better
> than it was.   Comments?
> 
> 
> --- linux-258-pre2/mm/swapfile.c.SI	Wed Apr 10 17:50:34 2002
> +++ linux-258-pre2/mm/swapfile.c	Wed Apr 10 18:09:46 2002
> @@ -1107,8 +1107,8 @@
>  			}
>  		}
>  	}
> -	val->freeswap = nr_swap_pages + nr_to_be_unused;
> -	val->totalswap = total_swap_pages + nr_to_be_unused;
> +	val->freeswap = nr_swap_pages;
> +	val->totalswap = total_swap_pages;
>  	swap_list_unlock();
>  }

Shouldn't that be s/+/-/ instead?  If this is badblocks accounting, it
should probably be subtracted instead of added.
