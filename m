Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284711AbSACItc>; Thu, 3 Jan 2002 03:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284240AbSACItW>; Thu, 3 Jan 2002 03:49:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16652 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284239AbSACItM>;
	Thu, 3 Jan 2002 03:49:12 -0500
Date: Thu, 3 Jan 2002 09:48:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix loop BIO breakage (memory corruption)
Message-ID: <20020103094832.E482@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201030803570.20656-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201030803570.20656-100000@netfinity.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03 2002, Zwane Mwaikambo wrote:
> Hi Jens,
> 	I've tracked down what seems to be a case of array out of bounds.
> Doing the following command "mount /dev/cdrom /cdrom -o loop" hard locks

[snip]

Thanks, good debugging. This bug has been there in 2.4 before, blush.
I've applied your patch.

> Patch tested with read/write losetup type mounts, plain file backed mounts
> and block backed mounts (these fail in ll_rw_blk:1365 BUG check now)

Oh? Care to look into this?

-- 
Jens Axboe

