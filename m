Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273519AbRIYU3X>; Tue, 25 Sep 2001 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273532AbRIYU3O>; Tue, 25 Sep 2001 16:29:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31379 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273519AbRIYU3G>;
	Tue, 25 Sep 2001 16:29:06 -0400
Date: Tue, 25 Sep 2001 13:29:05 -0700 (PDT)
Message-Id: <20010925.132905.32720330.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: andrea@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva>
In-Reply-To: <20010925.131528.78383994.davem@redhat.com>
	<Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Tue, 25 Sep 2001 16:02:29 -0300 (BRT)
   
   > It is known that pagecache_lock is the biggest scalability issue on
   > large SMP systems, and thus the page cache locking patches Ingo and
   > myself did.
   
   Btw, is that one going into 2.5 for sure? (the per-address-space lock). 
   
Well, there are two things happing in that patch.  Per-hash chain
locks for the page cache itself, and the lock added to the address
space for that page list.

Linus has indicated it will go into 2.5.x, yes.

Franks a lot,
David S. Miller
davem@redhat.com
