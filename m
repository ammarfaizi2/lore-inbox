Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSKHH7k>; Fri, 8 Nov 2002 02:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSKHH7k>; Fri, 8 Nov 2002 02:59:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40112 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266771AbSKHH7k>;
	Fri, 8 Nov 2002 02:59:40 -0500
Date: Fri, 8 Nov 2002 09:05:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Andrew Morton <akpm@digeo.com>, MdkDev <mdkdev@starman.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
Message-ID: <20021108080558.GR32005@suse.de>
References: <32851.62.65.205.175.1036691341.squirrel@webmail.starman.ee> <20021107180709.GB18866@www.kroptech.com> <32894.62.65.205.175.1036692849.squirrel@webmail.starman.ee> <20021108015316.GA1041@www.kroptech.com> <3DCB1D09.EE25507D@digeo.com> <20021108024905.GA10246@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108024905.GA10246@www.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07 2002, Adam Kropelin wrote:
> > Try changing drivers/block/deadline-iosched.c:fifo_batch to 16.
> 
> Works! A 12x burn succeeded with a parallell dd *and* and make -j20.
> Overall disk throughput suffered by a couple MB/s but there was a solid
> 2 MB/s left for the recorder.

Ok I'm just about convinced now, I'll make 16 the default batch count.
I'm very happy to hear that the deadline scheduler gets the job done
there.

-- 
Jens Axboe

