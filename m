Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261551AbSJAKLL>; Tue, 1 Oct 2002 06:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbSJAKLL>; Tue, 1 Oct 2002 06:11:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261551AbSJAKLK>;
	Tue, 1 Oct 2002 06:11:10 -0400
Date: Tue, 1 Oct 2002 12:16:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39-mm1
Message-ID: <20021001101625.GC20878@suse.de>
References: <200209301941.41627.conman@kolivas.net> <3D98A7D0.8F07193F@digeo.com> <1033418211.3d98b5e347574@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033418211.3d98b5e347574@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Con Kolivas wrote:
> > > io_load:
> > > Kernel                  Time            CPU             Ratio
> > > 2.4.19                  216.05          33%             3.19
> > > 2.5.38                  887.76          8%              13.11
> > > 2.5.38-mm3              105.17          70%             1.55
> > > 2.5.39                  229.4           34%             3.4
> > > 2.5.39-mm1              239.5           33%             3.4
> > 
> > I think I'll set fifo_batch to 16 again...
> > 
> 
> And I'll happily benchmark it when you do.

Just take 2.5.39-mm1 sources, edit drivers/block/deadline-iosched.c and
set

static int fifo_batch = 16;

instead of the 32. -mm has them in sysctl too, iirc.

-- 
Jens Axboe

