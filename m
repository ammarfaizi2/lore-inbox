Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUIEMvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUIEMvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUIEMvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:51:15 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:39696 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266619AbUIEMvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:51:05 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: rewrite the cache for file allocation table lookup
 (2/4)
References: <878ybpvtpz.fsf@devron.myhome.or.jp>
	<20040905123959.A29612@infradead.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 05 Sep 2004 21:50:38 +0900
In-Reply-To: <20040905123959.A29612@infradead.org> (Christoph Hellwig's
 message of "Sun, 5 Sep 2004 12:39:59 +0100")
Message-ID: <87pt50vq01.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +#if 0
>> +#define debug_pr(fmt, args...)	printk(fmt, ##args)
>> +#else
>> +#define debug_pr(fmt, args...)
>> +#endif
>
> We have a pr_debug() in <linux/kernel.h> that you could use.

I hated KERN_DEBUG. But, well, maybe pr_debug() was enough...

I'll replace it for now, and will delete it after public test in
Andrew's tree.

>> +static inline int fat_max_cache(struct inode *inode)
>> +{
>> +	return FAT_MAX_CACHE;
>> +}
>
> Do you plan to have per-inode caches later?  This seems rather useless
> otherwise.

This cache is already per-inode.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
