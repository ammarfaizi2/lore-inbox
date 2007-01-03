Return-Path: <linux-kernel-owner+w=401wt.eu-S1751699AbXACBOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbXACBOS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbXACBOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:14:18 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:56173 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbXACBOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:14:17 -0500
In-Reply-To: <000501c72bc0$d286bff0$d634030a@amr.corp.intel.com>
References: <000501c72bc0$d286bff0$d634030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F7E6E752-C6CE-4A89-A716-3C7367EF1FF8@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: make aio_ring_info->nr_pages an unsigned int
Date: Tue, 2 Jan 2007 17:14:16 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- ./include/linux/aio.h.orig	2006-12-24 22:31:55.000000000 -0800
> +++ ./include/linux/aio.h	2006-12-24 22:41:28.000000000 -0800
> @@ -165,7 +165,7 @@ struct aio_ring_info {
>
>  	struct page		**ring_pages;
>  	spinlock_t		ring_lock;
> -	long			nr_pages;
> +	unsigned		nr_pages;
>
>  	unsigned		nr, tail;
>
>

Hmm.

This seems so trivial as to not be worth it.  It'd be more compelling  
if it was more thorough -- doing things like updating the 'long i'  
iterators that a feww have over ->nr_pages.  That kind of thing.   
Giving some confidence that the references of ->nr_pages were audited.

- z
