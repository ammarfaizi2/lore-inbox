Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVBFSEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVBFSEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVBFSEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:04:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:19882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261260AbVBFSEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:04:21 -0500
Date: Sun, 6 Feb 2005 10:04:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
In-Reply-To: <1107711569.22680.146.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0502061002090.2165@ppc970.osdl.org>
References: <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu>
  <20050206125002.GF30109@wotan.suse.de>  <1107694800.22680.90.camel@laptopd505.fenrus.org>
  <20050206130152.GH30109@wotan.suse.de>  <20050206130650.GA32015@infradead.org>
  <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu> 
 <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu> 
 <20050206142936.GC30476@wotan.suse.de>  <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
  <1107710023.22680.138.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0502060920050.2165@ppc970.osdl.org>
 <1107711569.22680.146.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Feb 2005, Arjan van de Ven wrote:
> > 
> > And if you want to split things up, there's at least three flags there:  
> > "stack" vs "file mapping" vs "anonymous mapping". For example, it might
> 
> lets add "brk" as 4th I guess.

I thought about that, but no normal user program uses brk() natively. They 
all just use "malloc()" and friends, and pretty much every implementation 
of those in turn just mixes brk/anon-mmap freely.

> Ok so what to do for 2.6.11... the setarch workaround is there; that
> works. My patch patches the worst issues and is quite minimal. What you
> propose will be more invasive and more suitable for 2.6.11-bk1... 
> I can do such a patch no problem (although the next two days I won't
> have time).

Hmm.. I can take your initial patch now. Can somebody explain why this 
hassn't come up before, though?

		Linus
