Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWAQUUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWAQUUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWAQUUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:20:18 -0500
Received: from mailgw4.ericsson.se ([193.180.251.62]:38618 "EHLO
	mailgw4.ericsson.se") by vger.kernel.org with ESMTP id S964802AbWAQUUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:20:16 -0500
Date: Tue, 17 Jan 2006 21:15:54 +0100 (CET)
From: Per Liden <per.liden@ericsson.com>
X-X-Sender: eperlid@ulinpc219.uab.ericsson.se
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Maloy <jon.maloy@ericsson.com>,
       Allan Stephens <allan.stephens@windriver.com>,
       tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH] TIPC: add Kconfig help text
In-Reply-To: <200601172058.31503.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0601172105180.17253@ulinpc219.uab.ericsson.se>
References: <200601172058.31503.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Jan 2006 20:20:14.0464 (UTC) FILETIME=[6CBDE000:01C61BA3]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've already committed a patch similar to this in our GIT repo 
(http://tipc.cslab.ericsson.net), just haven't asked for it to be pulled 
yet since we have another fix for some namespace pullution in the 
pipeline. Thanks though!

/Per

On Tue, 17 Jan 2006, Jesper Juhl wrote:

> 
> A new option such as TIPC should have a clear help text (as should any 
> option for that matter) so users have a chance of determining if they 
> want the option enabled or not without having to do extensive online 
> searches.
> Since this is likely to puzzle a lot of people doing "make oldconfig" 
> with 2.6.16 using their old 2.6.15 .config I think the patch below (or 
> a similar one) should go in before 2.6.16 is released.
> 
> Please consider merging.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  net/tipc/Kconfig |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.16-rc1-orig/net/tipc/Kconfig	2006-01-17 19:14:24.000000000 +0100
> +++ linux-2.6.16-rc1/net/tipc/Kconfig	2006-01-17 19:30:13.000000000 +0100
> @@ -8,7 +8,10 @@
>  config TIPC
>  	tristate "The TIPC Protocol (EXPERIMENTAL)"
>  	---help---
> -	  TBD.
> +	  The Transparent Inter Process Communication (TIPC) protocol is a
> +	  protocol for intra cluster communication.
> +	  Unless you are building a cluster using TIPC you probably have no
> +	  use for this.
>  
>  	  This protocol support is also available as a module ( = code which
>  	  can be inserted in and removed from the running kernel whenever you
> @@ -23,8 +26,8 @@
>  	default n
>  	help
>  	  Saying Y here will open some advanced configuration
> -          for TIPC. Most users do not need to bother, so if
> -          unsure, just say N.
> +          for TIPC. Most users do not need to bother, so if unsure,
> +	  just say N.
>  
>  config TIPC_ZONES
>  	int "Maximum number of zones in network"
> 
> 
> 
