Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318642AbSHUSmc>; Wed, 21 Aug 2002 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318635AbSHUSmc>; Wed, 21 Aug 2002 14:42:32 -0400
Received: from zok.SGI.COM ([204.94.215.101]:50635 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318642AbSHUSma>;
	Wed, 21 Aug 2002 14:42:30 -0400
Date: Wed, 21 Aug 2002 11:46:33 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.31
Message-ID: <20020821184633.GA62396@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>, phillips@arcor.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020808172335.GA29509@sgi.com> <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva> <20020808173933.GA29474@sgi.com> <E17czxG-0000e8-00@starship> <20020812210336.GA40112@sgi.com> <3D5829B9.D281B855@zip.com.au> <20020812223645.GB40343@sgi.com> <3D5840E9.89C8680C@zip.com.au> <20020821182627.GA62297@sgi.com> <3D63DE8A.9F139B42@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 11:40:10AM -0700, Andrew Morton wrote:
> Well I added checks just to kmalloc, kmem_cache_alloc, __alloc_pages
> and saw a shower of bloopers during bootup.  Such as drivers/ide/probe.c:init_irq()
> calling request_irq() inside ide_lock.

Wow.  Sounds like some good code to have around.

> > Anyway, here's an updated version of the lock assertion patch.
> 
> Well I like it.  It's unintrusive, imparts useful info to the reader
> and checks stuff at runtime.

Great!

> These things are self-evident and even self-checking.  They don't need
> supporting documentation.   I'll put out a test tree RSN, include this
> in it.

Excellent.  Thanks a lot for your feedback.

Jesse
