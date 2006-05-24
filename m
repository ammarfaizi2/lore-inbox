Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWEXM1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWEXM1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWEXM1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:27:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:44745 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932679AbWEXM1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:27:52 -0400
Subject: Re: [PATCH 04/33] readahead: page flag PG_readahead
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060524111858.869793445@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
	 <20060524111858.869793445@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 14:27:36 +0200
Message-Id: <1148473656.10561.46.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 19:12 +0800, Wu Fengguang wrote:
> plain text document attachment
> (readahead-page-flag-PG_readahead.patch)
> An new page flag PG_readahead is introduced as a look-ahead mark, which
> reminds the caller to give the adaptive read-ahead logic a chance to do
> read-ahead ahead of time for I/O pipelining.
> 
> It roughly corresponds to `ahead_start' of the stock read-ahead logic.
> 
> Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> ---
> 
>  include/linux/page-flags.h |    5 +++++
>  mm/page_alloc.c            |    2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.17-rc4-mm3.orig/include/linux/page-flags.h
> +++ linux-2.6.17-rc4-mm3/include/linux/page-flags.h
> @@ -89,6 +89,7 @@
>  #define PG_reclaim		17	/* To be reclaimed asap */
>  #define PG_nosave_free		18	/* Free, should not be written */
>  #define PG_buddy		19	/* Page is free, on buddy lists */
> +#define PG_readahead		20	/* Reminder to do readahead */
>  

Page flags are gouped by four, 20 would start a new set.
Also in my tree (git from a few days ago), 20 is taken by PG_unchached.
What code is this patch-set against?



