Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUCIQeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUCIQeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:34:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63244
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262051AbUCIQeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:34:44 -0500
Date: Tue, 9 Mar 2004 17:35:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309163526.GL8193@dualathlon.random>
References: <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040309083103.GB8021@elte.hu> <20040309090326.GA10039@elte.hu> <20040309145130.GC8193@dualathlon.random> <20040309150942.GA8224@elte.hu> <20040309152438.GE8193@dualathlon.random> <20040309161051.GA11046@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309161051.GA11046@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 05:10:51PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > > could you just try test-mmap2.c on such a box, and hit swap?
> 
> > Unless it crashes the machine I don't care, it's totally wrong in my
> > opinion to hurt everything useful to save cpu while running an
> > exploit. there are easier ways to waste cpu (rewrite the exploit with
> > truncate please!!!)
> 
> i'm not sure i follow. "truncate being slow" is not the same order of
> magnitude of a problem as "the VM being incapable of getting work done".

vm has limits, no matter if with rmap or not, if you ask to map 1
million of vmas on a 64bit arch in the same task the rbtree will
slowdown like a crawl too. The vm is a trade-off, we've to optimize for
good apps.
