Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRIYWD5>; Tue, 25 Sep 2001 18:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271787AbRIYWDt>; Tue, 25 Sep 2001 18:03:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34964 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271798AbRIYWDb>;
	Tue, 25 Sep 2001 18:03:31 -0400
Date: Tue, 25 Sep 2001 15:03:28 -0700 (PDT)
Message-Id: <20010925.150328.75780096.davem@redhat.com>
To: andrea@suse.de
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010926000102.G8350@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva>
	<20010925.131528.78383994.davem@redhat.com>
	<20010926000102.G8350@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 26 Sep 2001 00:01:02 +0200
   
   IMHO if we would hold the pagecache lock all the time while shrinking
   the cache, then we could kill the lru lock in first place.

And actually in the pagecache locking patches, doing such a thing
would be impossible :-) since each page needs to grab a different
lock (because the hash chain is potentially different).

Franks a lot,
David S. Miller
davem@redhat.com
