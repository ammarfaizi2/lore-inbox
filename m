Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWCDXSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWCDXSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 18:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCDXSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 18:18:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:24213
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751771AbWCDXSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 18:18:47 -0500
Date: Sat, 4 Mar 2006 15:18:42 -0800
From: Greg KH <greg@kroah.com>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Message-ID: <20060304231842.GA3103@kroah.com>
References: <20060303214036.11908.10499.stgit@gitlost.site> <20060303214236.11908.98881.stgit@gitlost.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303214236.11908.98881.stgit@gitlost.site>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 01:42:36PM -0800, Chris Leech wrote:
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 13abfa2..b792048 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -262,6 +262,9 @@
>  #include <net/tcp.h>
>  #include <net/xfrm.h>
>  #include <net/ip.h>
> +#ifdef CONFIG_NET_DMA
> +#include <net/netdma.h>
> +#endif

#ifdef is not needed here (try not to put #ifdef in .c files.)  I think
a few of your other usages of #ifdef in this file can also be removed
with judicious use of inline functions in a .h file.

thanks,

greg k-h
