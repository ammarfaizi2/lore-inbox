Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265853AbSKBB3p>; Fri, 1 Nov 2002 20:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSKBB3p>; Fri, 1 Nov 2002 20:29:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:2211 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265853AbSKBB3o>;
	Fri, 1 Nov 2002 20:29:44 -0500
Message-ID: <3DC32C03.C3910128@digeo.com>
Date: Fri, 01 Nov 2002 17:36:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Maneesh Soni <maneesh@in.ibm.com>, Al Viro <viro@math.psu.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@au1.ibm.com>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: dcache_rcu [performance results]
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 01:36:07.0032 (UTC) FILETIME=[36CD7F80:01C28210]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> [ dcache-rcu ]
> 
> Anton (Blanchard) did some benchmarking with this
> in a 24-way ppc64 box and the results showed why we need this patch.
> Here are some performace comparisons based on a multi-user benchmark
> that Anton ran with vanilla 2.5.40 and 2.5.40-mm.
> 
> http://lse.sourceforge.net/locking/dcache/summary.png
> 
> base = 2.5.40
> base-nops = 2.5.40 but ps command in benchmark scripts commented out
> mm = 2.5.40-mm
> mm-nops = 2.5.40-mm but ps command in benchmark scripts commented out
> 

I'm going to need some help understanding what's going on in
there.  I assume the test is SDET (there, I said it), which
simulates lots of developers doing developer things on a multiuser
machine.  Lots of compiling, groffing, etc.

Why does the removal of `ps' from the test script make such a huge
difference?  That's silly, and we should fix it.

And it appears that dcache-rcu made a ~10% difference on a 24-way PPC64,
yes?  That is nice, and perhaps we should take that, but it is not a
tremendous speedup.

Thanks.
