Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSKCOyc>; Sun, 3 Nov 2002 09:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSKCOyb>; Sun, 3 Nov 2002 09:54:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31167 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261914AbSKCOya>;
	Sun, 3 Nov 2002 09:54:30 -0500
Date: Sun, 3 Nov 2002 16:00:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: vasya vasyaev <vasya197@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
Message-ID: <20021103150041.GM807@suse.de>
References: <20021103141753.50480.qmail@web20503.mail.yahoo.com> <3DC5337C.4090506@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC5337C.4090506@quark.didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03 2002, Brian Gerst wrote:
> vasya vasyaev wrote:
> >Hello,
> >
> >I have some strange kind of problem:
> >When HIGHMEM-enabled kernel is used, there is too high
> >CPU load on any task - computer get loaded high while
> >it is doing some minor, usual jobs (load average grows
> >significantly).
> 
> 2.4 can only do I/O to and from lowmem.  This means highmem pages have 

2.4.19 and below, 2.4.20-pre/rc can dma to/from highmem pages just fine.

> to use bounce buffers in lowmem, and th edata is copied to/from highmem 
> which is causing the cpu load.  This has been corrected in 2.5, which 
> can do I/O to any page the device can DMA from.

I seriously doubt this is his problem, sounds like something else. For
gzip to be disk bound (and thus bounce bound) you would need a seriously
fast cpu. And the ssh problem cannot be explained by bouncing either.

-- 
Jens Axboe

