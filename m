Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTKUTj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTKUTj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:39:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:14244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263014AbTKUTjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:39:25 -0500
Date: Fri, 21 Nov 2003 11:45:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: <dhruv.anand@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DIRECT IO for ext3/ext2.
Message-Id: <20031121114513.6bb2e795.akpm@osdl.org>
In-Reply-To: <1E27FF611EBEFB4580387FCB5BEF00F3013DEF08@blr-ec-msg04.wipro.com>
References: <1E27FF611EBEFB4580387FCB5BEF00F3013DEF08@blr-ec-msg04.wipro.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<dhruv.anand@wipro.com> wrote:
>
> Thanks for your reply. I looked into the boundary alignment issue. 
>  Observed something strange happening;
> 
>  I wrote my own kernel module and then;
>  1. retrieved the block size = 4096 using block_size(struct block_device
>  *bdev) 
>  2. in the user application i did a lseek by 4906 (block size seek) 
>  3. then found the address of the variable i wanted to read into, to be
>  block 
>     size aligned.

O_DIRECT works - trust me ;)

Please grab

	http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

There are a number of examples in there (odread.c is one).


