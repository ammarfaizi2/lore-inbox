Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHVQJd>; Thu, 22 Aug 2002 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHVQJd>; Thu, 22 Aug 2002 12:09:33 -0400
Received: from [195.223.140.120] ([195.223.140.120]:7014 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313113AbSHVQJc>; Thu, 22 Aug 2002 12:09:32 -0400
Date: Thu, 22 Aug 2002 18:15:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020822161505.GR1117@dualathlon.random>
References: <2159880183.1029535922@[10.10.2.3]> <Pine.LNX.4.44.0208170953190.3062-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208170953190.3062-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 10:02:23AM -0700, Linus Torvalds wrote:
> So to make this work, you'd have to have:
>  - architecture-specific hacks
>  - realize that not all architectures can do it at all, so the places that 
>    depend on this would have to have some abstraction that makes it go 
>    away when not needed.
>  - fix up lazy TLB switching (conditionally on the hack).
> 
> It just sounds really messy to me.

Indeed. Assuming this is an hack under a CONFIG_X86_NUMA_HACK hardwired
for certain config options and certain architecture, the tlb flushing
across threads sounds the worst part in particular because it's an x86.

Andrea
