Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSFYXU1>; Tue, 25 Jun 2002 19:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSFYXU0>; Tue, 25 Jun 2002 19:20:26 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:41860
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S316127AbSFYXU0>; Tue, 25 Jun 2002 19:20:26 -0400
Date: Tue, 25 Jun 2002 16:20:35 -0700
From: Phil Oester <kernel@theoesters.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-rc1 Fix NFS attribute caching bug
Message-ID: <20020625162035.A8504@ns1.theoesters.com>
References: <15640.49514.475470.751124@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15640.49514.475470.751124@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jun 25, 2002 at 09:15:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!!!  

Ever since moving to 2.4.19-pre9 we've noticed an incredible jump in GETATTR calls on our NFS server.  Will look forward to this making it into 2.4.19 release.

-Phil

On Tue, Jun 25, 2002 at 09:15:54PM +0200, Trond Myklebust wrote:
> 
>   Fixes an obvious bug in __nfs_refresh_inode(): after updating the
> attribute cache, if we discover that the data cache is invalid don't
> call nfs_zap_caches() as that will also reinvalidate the attribute
> cache.
>   This bug plays havoc with the new lookup/revalidation code in 2.4.19
> since it forces a lot of unnecessary extra GETATTR RPC calls.
> 
> Cheers,
>    Trond
