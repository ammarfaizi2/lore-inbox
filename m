Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273505AbRIYUYx>; Tue, 25 Sep 2001 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273506AbRIYUYn>; Tue, 25 Sep 2001 16:24:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14347 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273505AbRIYUY2>; Tue, 25 Sep 2001 16:24:28 -0400
Date: Tue, 25 Sep 2001 17:24:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "David S. Miller" <davem@redhat.com>
Cc: <marcelo@conectiva.com.br>, <andrea@suse.de>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <20010925.131528.78383994.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0109251723160.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, David S. Miller wrote:

> It is known that pagecache_lock is the biggest scalability issue
> on large SMP systems, and thus the page cache locking patches
> Ingo and myself did.

Interesting, most lockmeter data dumps I've seen here
indicate the locks in fs/buffer.c as the big problem
and have pagecache_lock down in the noise.

Or were you measuring loads which are mostly read-only ?

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

