Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312391AbSDCTkE>; Wed, 3 Apr 2002 14:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSDCTjy>; Wed, 3 Apr 2002 14:39:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36363 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312380AbSDCTjm>; Wed, 3 Apr 2002 14:39:42 -0500
Date: Wed, 3 Apr 2002 11:39:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16sqgd-0004Nv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204031128530.3004-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002, Alan Cox wrote:
> 
> If its a rewrite of the old stuff then yes. But in that case the right
> people -were- consulted.

What is "rewrite"? 

The thing has it's roots in mm/memory.c (and even more so just
<asm/pgtable.h> which really forces the whole structure of the function)  
so long ago that it isn't even funny. Coupled with the fact that the
15-line functionality has been changed by various VM/kmap changes (and by
the preempt changes) so many times that it bears little resemblance to
whatever it was before.

It's a question akin to the one whether BSD was based on the original AT&T
UNIX sources and thus under AT&T copyright.

Copyrights simply aren't that black-and-white. 

There's also the issue of reasonableness - those fifteen lines can only be
written so many ways, and sure, we could ask NVIDIA & co to write their
own version, but if it bore a surprising similarity to the one in the
kernel, I can't really blame them. Except they'd probably get it wrong,
and they'd _certainly_ be blamed when we introduce something new like the
highmem page tables or preemption stuff.

			Linus

