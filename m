Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278118AbRJRUPx>; Thu, 18 Oct 2001 16:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278120AbRJRUPd>; Thu, 18 Oct 2001 16:15:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11027 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278118AbRJRUPX>;
	Thu, 18 Oct 2001 16:15:23 -0400
Date: Thu, 18 Oct 2001 18:15:47 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fork() failing
In-Reply-To: <Pine.LNX.4.21.0110181647000.12429-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0110181813030.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Marcelo Tosatti wrote:
> On Thu, 18 Oct 2001, Rik van Riel wrote:

> > Actually, I guess we could define this to be the same point
> > where we'd end up freeing memory in order to satisfy our
> > allocation.
>
> Just remember that if we give __GFP_FAIL a "give me memory if its
> available" meaning we simply can't use it for stuff like pagecache
> prefetching --- its _too_ fragile.

IMHO it makes perfect sense, since at this point, one more
allocation _will_ push us over the limit and let kswapd go
to work to free up more memory.

We just need to make sure that the "wake up kswapd and maybe
help free memory" point is EXACTLY the same as the __GFP_FAIL
failure point.

Unless off course I'm overlooking something ... in that case
I'd appreciate it if you could point it out to me ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

