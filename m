Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271605AbRHPS02>; Thu, 16 Aug 2001 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271606AbRHPS0T>; Thu, 16 Aug 2001 14:26:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20488 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271605AbRHPSZ7>; Thu, 16 Aug 2001 14:25:59 -0400
Date: Thu, 16 Aug 2001 20:26:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mark Hemment <markhe@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Align VM locks
Message-ID: <20010816202606.B8726@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>; from markhe@veritas.com on Thu, Aug 16, 2001 at 06:41:08PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 06:41:08PM +0100, Mark Hemment wrote:
> Hi,
> 
>   The patch below ensures the pagecache_lock and pagemap_lru_lock aren't
> sharing an L1 cacheline with anyone else - espically each other!

This is the right one:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.8aa1/00_cachelinealigned-in-smp-1

Alan also merged it in -ac IIRC.

BTW, for your other patch you sent a few hours ago you forgot to drop
the KMAP entry that is wasting NR_CPUS*PAGE_SIZE of virtual address
space:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.8aa1/00_create_bounces-sleeps-1

Andrea
