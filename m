Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRDIH4d>; Mon, 9 Apr 2001 03:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRDIH4Y>; Mon, 9 Apr 2001 03:56:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10765 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132701AbRDIH4N>;
	Mon, 9 Apr 2001 03:56:13 -0400
Date: Mon, 9 Apr 2001 09:56:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Eure <ieure@insynq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010409095607.A432@suse.de>
In-Reply-To: <15055.36597.353681.125824@pyramid.insynq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15055.36597.353681.125824@pyramid.insynq.com>; from ieure@insynq.com on Sat, Apr 07, 2001 at 03:04:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07 2001, Ian Eure wrote:
> i'm still having loopback problems with linux 2.4.3, even though they
> were supposed to be fixed. it doesn't deadlock my maching right away
> anymore, but instead causes a kernel panic after 4-6 uses of the loop
> device.
> 
> the message i get is: "Kernel panic: Invalid blocksize passed to
> set_blocksize"
> 
> 100% reproducable. has anyone else seen this?
> 
> i did compile with gcc 2.92.3, and i have hedrick's ide patches
> applied.
> 
> anyone else see this?

Nope, please add a printk like before set_blocksize in
drivers/block/loop.c and print the bs info, like so

        printk("loop: setting %d bs for %s\n", bs, kdevname(inode->i_rdev));
        set_blocksize(dev, bs);

-- 
Jens Axboe

