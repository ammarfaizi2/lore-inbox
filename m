Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUDFQkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbUDFQka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:40:30 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40584
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263904AbUDFQjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:39:53 -0400
Date: Tue, 6 Apr 2004 18:39:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406163950.GA2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <1081268018.4680.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081268018.4680.6.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:13:39PM +0200, Arjan van de Ven wrote:
> On Tue, 2004-04-06 at 17:59, Andrea Arcangeli wrote:
> 
> > You should also use a bleeding edge cpu for you measurements with large
> > tlb caches, which cpu did you use for your measurements?
> 
> afaics all Intel and AMD cpus with more than say 32 or 64 TLB's are
> actually 64 bit capable.... so obviously you run a 64 bit kernel there. 
> (and amd64 even has that sweet CAM filter on the tlbs to mitigate the
> effect even if you run a 32 bit kernel)

I simply heard the effect was less visible on PIII than on more recent
cpus, but maybe that was wrong. Do you have any result comparing
different cpus (I mean with realistic tests not stuff like loop_print.c
doing nothing but rdtsc)? It'd be most interesting to see the effect on
hugetlbfs, to get past a certain amount of ram hugetlbfs is needed for
performance reasons (plus it avoids the costs of the pte saving ram, but
that's a secondary benefit, ptes are in highmem anyways).
