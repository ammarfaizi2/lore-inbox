Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319060AbSIDF0s>; Wed, 4 Sep 2002 01:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319061AbSIDF0s>; Wed, 4 Sep 2002 01:26:48 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:16021 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S319060AbSIDF0r>; Wed, 4 Sep 2002 01:26:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Anton Altaparmakov <aia21@cantab.net>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       Lars Marowsky-Bree <lmb@suse.de>, root@chaos.analogic.com,
       Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 3 Sep 2002 22:23:35 -0700 (PDT)
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <E17mMwu-0005mj-00@starship>
Message-ID: <Pine.LNX.4.44.0209032218430.30080-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, Daniel Phillips wrote:

>
> You're well wide of the mark here, in that you're relying on the assumption
> that caching is important to the application he has in mind.  The raw transfer
> bandwidth may well be sufficient, especially if it is unimpeded by being
> funneled through a bottleneck like our vfs cache.
>

the fact that he is saying that this needs to run normal filesystems tells
us that.

if you need a filesystem to max out transfer rate and don't want to have
it cache things that is a VERY specialized thing and not something that
will match what NTFS/XFS/JFS/ReiserFS/ext2 etc are going to be used for.

either he has a very specialized need (in which case a specialized
filesystem is probably the best bet anyway) or he is trying to support
normal uses (in which case caching is important)

however the point is that the read-modify-write cycle is a form of cache,
it is only safe if you aquire a lock at the beginning of it and release it
at the end. A standard filesystem won't do this, this is what makes a DFS.

David Lang

