Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSE3GWz>; Thu, 30 May 2002 02:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSE3GWy>; Thu, 30 May 2002 02:22:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59567 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315720AbSE3GWy>;
	Thu, 30 May 2002 02:22:54 -0400
Date: Thu, 30 May 2002 08:22:48 +0200
From: Jens Axboe <axboe@suse.de>
To: system_lists@nullzone.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - raid1 erros on compile
Message-ID: <20020530062248.GP17674@suse.de>
In-Reply-To: <5.1.0.14.2.20020530073357.00cba7d8@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30 2002, system_lists@nullzone.org wrote:
> 
> I have problems compiling kernel with raid1 support.
> 
> Any idea?
> 
> thanks
> 
> make[2]: Entering directory `/usr/src/linux-2.5.19/drivers/md'
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.19/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 
> -march=i686    -DKBUILD_BASENAME=raid1  -c -o raid1.o raid1.c
> raid1.c: In function `device_barrier':
> raid1.c:412: `tq_disk' undeclared (first use in this function)
> raid1.c:412: (Each undeclared identifier is reported only once
> raid1.c:412: for each function it appears in.)
> raid1.c: In function `make_request':
> raid1.c:449: `tq_disk' undeclared (first use in this function)
> raid1.c: In function `close_sync':
> raid1.c:651: `tq_disk' undeclared (first use in this function)

run_task_queue(&tq_disk) -> blk_run_queues()

-- 
Jens Axboe

