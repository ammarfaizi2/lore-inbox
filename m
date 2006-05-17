Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWEQWrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWEQWrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWEQWrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:47:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18119
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750910AbWEQWrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:47:31 -0400
Date: Wed, 17 May 2006 15:46:33 -0700 (PDT)
Message-Id: <20060517.154633.131645340.davem@davemloft.net>
To: oleg@tv-sign.ru
Cc: akpm@osdl.org, hch@infradead.org, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] list: use list_replace_init() instead of
 list_splice_init()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060518014042.GA891@oleg>
References: <20060518014042.GA891@oleg>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@tv-sign.ru>
Date: Thu, 18 May 2006 05:40:42 +0400

> list_splice_init(list, head) does unneeded job if it is known that
> list_empty(head) == 1. We can use list_replace_init() instead.
> 
> [ I did list_replace() for use in kernel/timer.c. I am not sure it
>   is ok to patch random files at once, but it looks so simple ... ].
> 
>  arch/i386/mm/pageattr.c |    8 ++++----
>  block/ll_rw_blk.c       |    5 ++---
>  fs/aio.c                |    4 ++--
>  kernel/timer.c          |    8 ++++----
>  kernel/workqueue.c      |    4 ++--
>  net/core/dev.c          |    6 +++---
>  net/core/link_watch.c   |    5 ++---
>  7 files changed, 19 insertions(+), 21 deletions(-)
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Signed-off-by: David S. Miller <davem@davemloft.net>
