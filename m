Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSEZIQA>; Sun, 26 May 2002 04:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315814AbSEZIP7>; Sun, 26 May 2002 04:15:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49733 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315806AbSEZIP6>; Sun, 26 May 2002 04:15:58 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524163942.GB15703@dualathlon.random>
	<Pine.GSO.4.21.0205241300480.9792-100000@weyl.math.psu.edu>
	<20020524175522.GD15703@dualathlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 May 2002 02:06:55 -0600
Message-ID: <m14rgvz61s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:
> 
> Anyways in 2.5 we could still take advantage of the negative dentries as
> much as possible (also after unlink) by moving the negative dentries
> into a separate list and by putting the shrinkage of this list in front
> of kmem_cache_reap, so we are as efficient as possible, but we don't
> risk throwing away very useful cache, for more dubious caching effects
> after an unlink/create-failure that currently have the side effect of
> throwing away tons of worthwhile positive pagecache (and even triggering
> swap false positives) in some workloads.

Right treat the new never referenced negative dentries as second class
citizens until someone comes along and uses them, instead of aged useful
cache entries.  This sounds like a very good solution to this.

Eric
