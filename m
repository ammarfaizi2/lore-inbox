Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRIYVFY>; Tue, 25 Sep 2001 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273586AbRIYVFO>; Tue, 25 Sep 2001 17:05:14 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:9739 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273589AbRIYVFI>; Tue, 25 Sep 2001 17:05:08 -0400
Message-ID: <3BB0F180.4787752C@zip.com.au>
Date: Tue, 25 Sep 2001 14:05:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: riel@conectiva.com.br, marcelo@conectiva.com.br, andrea@suse.de,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva>,
		<20010925.131528.78383994.davem@redhat.com>
		<Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva> <20010925.132816.52117370.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Tue, 25 Sep 2001 17:24:21 -0300 (BRST)
> 
>    Or were you measuring loads which are mostly read-only ?
> 
> When Kanoj Sarcar was back at SGI testing 32 processor Origin
> MIPS systems, pagecache_lock was at the top.

But when I asked kumon to test it on his 8-way Xeon,
page_cache_lock contention proved to be insignificant.

Seems to only be a NUMA thing.
