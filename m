Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSITHA4>; Fri, 20 Sep 2002 03:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSITHA4>; Fri, 20 Sep 2002 03:00:56 -0400
Received: from holomorphy.com ([66.224.33.161]:30086 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261297AbSITHAx>;
	Fri, 20 Sep 2002 03:00:53 -0400
Date: Thu, 19 Sep 2002 23:59:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920065947.GJ3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8A5FE6.4C5DE189@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
> It would be interesting to know the context switch rate
> during this test, and to see what things look like with HZ=100.

There is no obvious time when the machine appears idle, but regardless:
HZ == 100 with idle=poll. The numbers are still down, and I'm not 100%
sure why, so I'm backing out HZ = 100 and trying something else.

c01053dc 296114302 79.5237     poll_idle
c01053a4 20974286 5.6328      default_idle
c015c586 11098020 2.98046     .text.lock.dcache
c0154b43 10046044 2.69794     .text.lock.namei
c01317e4 9712304  2.60831     generic_file_write_nolock
c0130d00 3133118  0.841423    file_read_actor
c0114a98 2300611  0.617847    load_balance
c013f7fc 1615733  0.433917    blk_queue_bounce
c019f6bb 1591350  0.427369    .text.lock.dec_and_lock
c01066a8 1554624  0.417506    .text.lock.semaphore
c019f640 1000989  0.268823    atomic_dec_and_lock
c0114f10 851084   0.228565    scheduler_tick
c0152378 639577   0.171763    path_lookup
c0144dc0 456594   0.122622    generic_file_llseek
c0114628 407284   0.109379    try_to_wake_up
c0115258 399893   0.107394    do_schedule
c015adf0 370906   0.0996096   prune_dcache
c011748d 366470   0.0984183   .text.lock.sched
c015b6d4 306140   0.0822162   d_instantiate
c013faa4 292987   0.0786839   .text.lock.highmem
c013676c 291664   0.0783286   .text.lock.slab
c01062dc 282983   0.0759972   __down
c014675c 281106   0.0754932   __fput
