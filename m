Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSHNId0>; Wed, 14 Aug 2002 04:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSHNId0>; Wed, 14 Aug 2002 04:33:26 -0400
Received: from holomorphy.com ([66.224.33.161]:6068 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315413AbSHNIdZ>;
	Wed, 14 Aug 2002 04:33:25 -0400
Date: Wed, 14 Aug 2002 01:35:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020814083515.GM15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D56146B.C3CAB5E1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D56146B.C3CAB5E1@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:38:19AM -0700, Andrew Morton wrote:
> Sorry, but there's a ton of stuff here.  It ends up as a 4600 line
> diff.  Some code dating back to 2.5.24.  It's almost all performance
> work and it has been very painful getting its effectiveness tested
> on the big machines; the main problem has been getting them booting
> 2.5 at all.  The results still are not as conclusive as I'd like,
> but the signs are good, and there are no other proposals around to
> fix these problems.

dbench 256 on a 16x/16G numaq:

Throughput 50.7526 MB/sec (NB=63.4408 MB/sec  507.526 MBit/sec)  256 procs


c013bf74 13251607 72.928      .text.lock.highmem
c013b7d0 1606972  8.84371     kunmap_high
c013b5dc 1211097  6.66507     kmap_high
c012f260 459420   2.52834     generic_file_write
c0114820 166854   0.918253    scheduler_tick
c012e53c 166773   0.917808    file_read_actor
c0105394 125561   0.691004    default_idle
c013bcbc 75623    0.416179    blk_queue_bounce
c013564c 72289    0.397831    rmqueue
c01113b8 69062    0.380071    smp_apic_timer_interrupt
c0143cec 64782    0.356517    block_prepare_write
c014330c 53426    0.294021    __block_prepare_write
c0142ee8 39892    0.219539    create_empty_buffers
c012dec0 39161    0.215516    unlock_page
c01143d8 38648    0.212693    load_balance
c013b558 34840    0.191736    flush_all_zero_pkmaps
c0135d28 33414    0.183888    page_cache_release
c013429c 22753    0.125217    lru_cache_add
c0135b10 20326    0.111861    __alloc_pages
c0143d98 19833    0.109148    generic_commit_write
c012dcb4 18150    0.0998855   add_to_page_cache
c0140044 17758    0.0977282   vfs_write
