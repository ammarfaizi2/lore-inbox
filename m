Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSE3TY5>; Thu, 30 May 2002 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316843AbSE3TY4>; Thu, 30 May 2002 15:24:56 -0400
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:26116 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S316842AbSE3TYz>; Thu, 30 May 2002 15:24:55 -0400
Message-Id: <5.1.0.14.2.20020530212421.02cb50e8@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 30 May 2002 21:25:41 +0200
To: Jens Axboe <axboe@suse.de>
From: system_lists@nullzone.org
Subject: Re: 2.5.19 - raid1 erros on compile
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020530062248.GP17674@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well its not on raid1.c file.
It must be invoqued just from any funtion_structure_reference.

I'll wait a patch.

Thanks anyway

At 08:22 30/05/2002 +0200, Jens Axboe wrote:
>On Thu, May 30 2002, system_lists@nullzone.org wrote:
> >
> > I have problems compiling kernel with raid1 support.
> >
> > Any idea?
> >
> > thanks
> >
> > make[2]: Entering directory `/usr/src/linux-2.5.19/drivers/md'
> > gcc -D__KERNEL__ -I/usr/src/linux-2.5.19/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2
> > -march=i686    -DKBUILD_BASENAME=raid1  -c -o raid1.o raid1.c
> > raid1.c: In function `device_barrier':
> > raid1.c:412: `tq_disk' undeclared (first use in this function)
> > raid1.c:412: (Each undeclared identifier is reported only once
> > raid1.c:412: for each function it appears in.)
> > raid1.c: In function `make_request':
> > raid1.c:449: `tq_disk' undeclared (first use in this function)
> > raid1.c: In function `close_sync':
> > raid1.c:651: `tq_disk' undeclared (first use in this function)
>
>run_task_queue(&tq_disk) -> blk_run_queues()
>
>--
>Jens Axboe




