Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRIYVtR>; Tue, 25 Sep 2001 17:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271032AbRIYVtJ>; Tue, 25 Sep 2001 17:49:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18324 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270825AbRIYVsu>;
	Tue, 25 Sep 2001 17:48:50 -0400
Date: Tue, 25 Sep 2001 14:48:43 -0700 (PDT)
Message-Id: <20010925.144843.56057220.davem@redhat.com>
To: akpm@zip.com.au
Cc: riel@conectiva.com.br, marcelo@conectiva.com.br, andrea@suse.de,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BB0F180.4787752C@zip.com.au>
In-Reply-To: <Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva>
	<20010925.132816.52117370.davem@redhat.com>
	<3BB0F180.4787752C@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Tue, 25 Sep 2001 14:05:04 -0700

   "David S. Miller" wrote:
   > When Kanoj Sarcar was back at SGI testing 32 processor Origin
   > MIPS systems, pagecache_lock was at the top.
   
   But when I asked kumon to test it on his 8-way Xeon,
   page_cache_lock contention proved to be insignificant.
   
   Seems to only be a NUMA thing.
   
I doubt it is only a NUMA thing.  I say this for TUX web benchmarks
that tended to hold most of the resident set in memory, the page cache
locking changes were measured to improve performance significantly on
SMP x86 systems.

Ingo would be able to comment further.

Franks a lot,
David S. Miller
davem@redhat.com
