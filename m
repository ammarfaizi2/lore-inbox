Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUFYDT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUFYDT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 23:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266190AbUFYDT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 23:19:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17574
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266189AbUFYDTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 23:19:52 -0400
Date: Fri, 25 Jun 2004 05:19:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040625031957.GI30687@dualathlon.random>
References: <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624220823.GO21066@holomorphy.com> <20040624224529.GA30687@dualathlon.random> <20040624225121.GS21066@holomorphy.com> <20040624160945.69185c46.akpm@osdl.org> <20040625023936.GG30687@dualathlon.random> <20040624194750.167a452d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624194750.167a452d.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you want to leave it disabled that's still fine with me as far as it
can be enabled in a optimal way (the one I like as usual is the 256/32
ratios of 2.4 ;), but I'm quite convinced that it will provide benefit
even if enabled, possibly with bigger ratios if you want less
"guaranteed" waste.

as usual if one doesn't want any ram and performance waste, x86-64 is
out there in production, and it'll avoid all the waste (unless you care
about wasting 16M of ram on a 4G box without the risk of failing
order 0 dma allocations on the intel implementation). If one want to go
cheap and buy x86 still then he must be prepared to potentially lose
900M of ram on a 32G box, it's a relative cost, so the more ram the more
memory will be potentially wasted, the less ram the less ram will be
potentially wasted.

the most frequent x86 highmem complains I ever got were related to
runing _out_ of lowmem zone with the lowmem zone _empty_. The day I will
get a complain for the lowmem being completely _free_ has yet to come ;).

thanks a lot for all the help.
