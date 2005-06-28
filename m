Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVF1Qxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVF1Qxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVF1Qxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:53:44 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:24529 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S262141AbVF1Qw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:52:26 -0400
Message-ID: <42C18055.9040202@zabbo.net>
Date: Tue, 28 Jun 2005 09:52:37 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       wli@holomorphy.com, mason@suse.com
Subject: Re: [PATCH 2/6] Rename __lock_page to lock_page_slow
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com> <20050620162404.GB5380@in.ibm.com>
In-Reply-To: <20050620162404.GB5380@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have to whine at least once about obscure names :)

> -void fastcall __lock_page(struct page *page)
> +void fastcall lock_page_slow(struct page *page)
>  {
>  	DEFINE_WAIT_BIT(wait, &page->flags, PG_locked);
>  
>  	__wait_on_bit_lock(page_waitqueue(page), &wait, sync_page,
>  							TASK_UNINTERRUPTIBLE);
>  }
> -EXPORT_SYMBOL(__lock_page);
> +EXPORT_SYMBOL(lock_page_slow);

Can we chose a name that describes what it does?  Something like
lock_page_wait_on_locked()?

- z
