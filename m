Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWABNno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWABNno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWABNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:43:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24070 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750726AbWABNno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:43:44 -0500
Date: Mon, 2 Jan 2006 14:43:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102134345.GD17398@stusta.de>
References: <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136198902.2936.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 11:48:22AM +0100, Arjan van de Ven wrote:
> 
> > > Your uninline patch might be simple, but the safe way would be Arjan's 
> > > approach to start removing all the buggy inline's from .c files.
> > 
> > sure, that's another thing to do, but it's also clear that there's no 
> > reason to force inlines in the -Os case.
> > 
> > There are 22,000+ inline functions in the kernel right now (inlined 
> > about a 100,000 times), and we'd have to change _thousands_ of them. 
> > They are causing an unjustified code bloat of somewhere around 20-30%. 
> > (some of them are very much justified, especially in core kernel code)
> 
> my patch attacks the top bloaters, and gains about 30k to 40k (depending
> on compiler). Gaining the other 300k is going to be a LOT of churn, not
> just in amount of work... so to some degree my patch shows that it's a
> bit of a hopeless battle.

A quick grep shows at about 10.000 inline's in .c files, and nearly all 
of them should be removed.

Yes this is a serious amount of work, but it's an ideal janitorial task.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

