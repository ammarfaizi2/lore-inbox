Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWG2VOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWG2VOn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWG2VOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:14:42 -0400
Received: from pat.uio.no ([129.240.10.4]:36337 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932178AbWG2VOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:14:42 -0400
Subject: Re: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
References: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
Content-Type: text/plain
Date: Sat, 29 Jul 2006 17:14:28 -0400
Message-Id: <1154207668.5784.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.5, required 12,
	autolearn=disabled, AWL 1.50, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 21:42 +0200, Andi Kleen wrote:
> For some reason it triggers always with NFS root and spams the kernel
> logs of my nfs root boxes a lot.
> 
> Cc: trond.myklebust@fys.uio.no
> Signed-off-by: Andi Kleen <ak@suse.de>

Big ACK! I never really understood why we needed this printk, and yes,
it does spam the syslog heavily on all NFS clients...

Cheers,
  Trond

> ---
>  mm/filemap.c |    2 --
>  1 files changed, 2 deletions(-)
> 
> Index: linux-2.6.18-rc2-git7/mm/filemap.c
> ===================================================================
> --- linux-2.6.18-rc2-git7.orig/mm/filemap.c
> +++ linux-2.6.18-rc2-git7/mm/filemap.c
> @@ -849,8 +849,6 @@ static void shrink_readahead_size_eio(st
>  		return;
>  
>  	ra->ra_pages /= 4;
> -	printk(KERN_WARNING "Reducing readahead size to %luK\n",
> -			ra->ra_pages << (PAGE_CACHE_SHIFT - 10));
>  }
>  
>  /**

