Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUCOF5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUCOF5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:57:20 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:9989 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262273AbUCOF5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:57:17 -0500
Date: Mon, 15 Mar 2004 05:57:13 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export fb_find_mode
In-Reply-To: <1079305357.3093.60.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.44.0403150556200.15125-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A patch already exist which also removes __fb_try_mode. We don't need to 
export that anymore.



On Sun, 14 Mar 2004, Trond Myklebust wrote:

> The latest BK tree is missing an export in order to satisfy radeonfb
> etc. module dependencies.
> 
> Cheers,
>   Trond
> 
> --- linux-2.6.4/drivers/video/modedb.c.orig	2004-03-14 17:21:03.000000000 -0500
> +++ linux-2.6.4/drivers/video/modedb.c	2004-03-14 17:59:33.000000000 -0500
> @@ -554,5 +554,6 @@
>      return 0;
>  }
>  
> +EXPORT_SYMBOL(fb_find_mode);
>  EXPORT_SYMBOL(__fb_try_mode);
>  EXPORT_SYMBOL(vesa_modes);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

