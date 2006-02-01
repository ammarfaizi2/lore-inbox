Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWBAAYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWBAAYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWBAAYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:24:49 -0500
Received: from gatekeeper.jupiter.com ([192.77.175.1]:59922 "EHLO
	gatekeeper.jupiter.com") by vger.kernel.org with ESMTP
	id S932279AbWBAAYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:24:49 -0500
Message-ID: <43DFFFBA.1030404@jupiter.com>
Date: Tue, 31 Jan 2006 16:24:26 -0800
From: John Klingler <john@jupiter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "L. A. Walsh" <lkml@tlinx.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-Xfs <linux-xfs@oss.sgi.com>
Subject: Re: Compile warnings in XFS, kernel 2.6.15.1
References: <43DED73B.7060902@tlinx.org>
In-Reply-To: <43DED73B.7060902@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.11.1 source doesn't line up with your line numbers so I can't 
say. You'll have to see whether it's stuffing a 64 bit number into a 32 
bit number or vice versa and see if that will cause problems. I don't 
get those error messages when I compile the kernel so maybe someone put 
a cast in or fixed something. There are still plenty of warnings about 
uninitialized variable and so on which I would feel more comfortable not 
seeing. 111 the last time.

John

L. A. Walsh wrote:

> Are these warnings anything to worry about?
>
>  CC      fs/xfs/xfs_bmap.o
>  LD      fs/udf/udf.o
>  LD      fs/udf/built-in.o
>  CC      fs/dnotify.o
>  CC      fs/xfs/xfs_bmap_btree.o
> fs/xfs/xfs_bmap.c: In function `xfs_bmap_search_extents':
> fs/xfs/xfs_bmap.c:3590: warning: long long unsigned int format, 
> different type arg (arg 5)
>  CC      fs/xfs/xfs_btree.o
>  CC      fs/xfs/xfs_buf_item.o
>  CC      fs/xfs/xfs_iget.o
>  CC      fs/xfs/xfs_inode.o
>  CC      fs/xfs/xfs_inode_item.o
>  CC      fs/xfs/xfs_iocore.o
>  CC      fs/xfs/xfs_iomap.o
>  CC      fs/xfs/xfs_itable.o
> fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_direct':
> fs/xfs/xfs_iomap.c:488: warning: long long unsigned int format, 
> different type arg (arg 5)
> fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_delay':
> fs/xfs/xfs_iomap.c:591: warning: long long unsigned int format, 
> different type arg (arg 5)
> fs/xfs/xfs_iomap.c:697: warning: long long unsigned int format, 
> different type arg (arg 5)
> fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_allocate':
> fs/xfs/xfs_iomap.c:834: warning: long long unsigned int format, 
> different type arg (arg 5)
> fs/xfs/xfs_iomap.c: In function `xfs_iomap_write_unwritten':
> fs/xfs/xfs_iomap.c:941: warning: long long unsigned int format, 
> different type arg (arg 5)
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
