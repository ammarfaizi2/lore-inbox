Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291525AbSBAEAM>; Thu, 31 Jan 2002 23:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291520AbSBAD7y>; Thu, 31 Jan 2002 22:59:54 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:11013 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291519AbSBAD7r>;
	Thu, 31 Jan 2002 22:59:47 -0500
Date: Fri, 1 Feb 2002 14:56:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020201035628.GA10749@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com> <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain> <20020131231242.GA4138@krispykreme> <20020201005543.K3396@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201005543.K3396@athlon.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> all the hashes should be allocated with the bootmem allocator, that
> doesn't have the MAX_ORDER limit. Not only the pagecache hash, that is
> the only one replaced.
> 
> In short, for an optimal comparison between hash and radix tree, we'd
> need to fixup the hash allocation with the bootmem allocator first.

All my results use vmalloc to allocate the hashes so they get sized
correctly.

Don't worry, there is no increased tlb pressure on these machines due
to vmalloc, that cpu doesnt have large page support.

Anton
