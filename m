Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289812AbSAWLu5>; Wed, 23 Jan 2002 06:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289811AbSAWLus>; Wed, 23 Jan 2002 06:50:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17792 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289812AbSAWLu3>;
	Wed, 23 Jan 2002 06:50:29 -0500
Date: Wed, 23 Jan 2002 03:49:10 -0800 (PST)
Message-Id: <20020123.034910.78708895.davem@redhat.com>
To: dwmw2@infradead.org
Cc: manfred@colorfullife.com, drobbins@gentoo.org,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5553.1011786288@redhat.com>
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
	<5553.1011786288@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Woodhouse <dwmw2@infradead.org>
   Date: Wed, 23 Jan 2002 11:44:48 +0000
   
   masp0008@stud.uni-saarland.de said:
   >  speculative write operations always set the cache line dirty bit,
   > even if the write operations is not executed (e.g. discarded due to a
   > mispredicted jump) 
   
   How predictable is this? Dealing with non-coherent memory is perfectly
   normal - could we manage to work around this problem by flushing the caches
   when the CPU _might_ have dirtied a cache line rather than only when we know
   we've actually written to memory? Something like...
   
It isn't so simple.  You would have to catch every single store to
every page in the 4MB mapped region that happens to contain GART
mapped pages.

This isn't the way to solve this problem, trust me. :)
