Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWBWQkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWBWQkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWBWQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:40:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:51087 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751452AbWBWQkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:40:10 -0500
Subject: Re: [PATCH] change b_size to size_t
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       christoph <hch@lst.de>, mcao@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
	 <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222165942.GA25167@lst.de> <20060223014004.GA900@frodo>
	 <20060222175923.784ce5de.akpm@osdl.org>
	 <1140712093.22756.106.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 10:40:07 -0600
Message-Id: <1140712807.9975.24.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 08:28 -0800, Badari Pulavarty wrote:
> Index: linux-2.6.16-rc4/fs/buffer.c
> ===================================================================
> --- linux-2.6.16-rc4.orig/fs/buffer.c   2006-02-17 14:23:45.000000000 -0800
> +++ linux-2.6.16-rc4/fs/buffer.c        2006-02-23 08:19:15.000000000 -0800
> @@ -432,7 +432,7 @@ __find_get_block_slow(struct block_devic
>                 printk("__find_get_block_slow() failed. "
>                         "block=%llu, b_blocknr=%llu\n",
>                         (unsigned long long)block, (unsigned long long)bh->b_blocknr);
> -               printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
> +               printk("b_state=0x%08lx, b_size=%llu\n", bh->b_state,                                   (unsigned long long)bh->b_size);

Wrapping at 80 columns, it looks right, but you've got a long line in
here.

>                 printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
>         }
> 
-- 
David Kleikamp
IBM Linux Technology Center

