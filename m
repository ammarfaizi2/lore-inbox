Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBMXvO>; Tue, 13 Feb 2001 18:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBMXvE>; Tue, 13 Feb 2001 18:51:04 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:33945 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S129059AbRBMXup>;
	Tue, 13 Feb 2001 18:50:45 -0500
Date: Wed, 14 Feb 2001 08:50:35 +0900 (JST)
Message-Id: <200102132350.IAA07667@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (lkml)
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200102131116.f1DBGFx02086@flint.arm.linux.org.uk>
In-Reply-To: <200102131053.TAA11808@mule.m17n.org>
	<200102131116.f1DBGFx02086@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
 > Unless someone else (Rik/DaveM) says otherwise, it is my understanding
 > that any IO for page P will only ever be a write to disk.  Therefore,
 > when you get a copy of the page from the swap cache, the physical memory
 > for that page is the same as it was when the process was using it last.
[...]
 > The data from memory will still be up to date though.  However, I agree
 > that you will end up with cache aliases.  I will also end up with cache
 > aliases.  The question now is, do these aliases really matter?
 > 
 > On my caches, the answer is no because they're not marked dirty, and
 > therefore will get dropped from the cache without writeback to memory.
 > 
 > If your cache doesn't write back clean cache data to memory, then you
 > should also behave well.

Yes, that's the difference.  It's write back cache, in my case.
-- 
