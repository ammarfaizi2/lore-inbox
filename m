Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271865AbRIYWB5>; Tue, 25 Sep 2001 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIYWBs>; Tue, 25 Sep 2001 18:01:48 -0400
Received: from [195.223.140.107] ([195.223.140.107]:18416 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S271857AbRIYWBc>;
	Tue, 25 Sep 2001 18:01:32 -0400
Date: Wed, 26 Sep 2001 00:01:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926000102.G8350@athlon.random>
In-Reply-To: <20010925.125758.94556009.davem@redhat.com> <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva> <20010925.131528.78383994.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925.131528.78383994.davem@redhat.com>; from davem@redhat.com on Tue, Sep 25, 2001 at 01:15:28PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 01:15:28PM -0700, David S. Miller wrote:
> I do think it's silly to hold the pagecache_lock during pure scanning
> activities of shrink_caches().

Indeed again.

> It is known that pagecache_lock is the biggest scalability issue on
> large SMP systems, and thus the page cache locking patches Ingo and
> myself did.

yes.

IMHO if we would hold the pagecache lock all the time while shrinking
the cache, then we could kill the lru lock in first place.

Andrea
