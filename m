Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUDNQmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUDNQmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:42:37 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:52705 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261440AbUDNQme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:42:34 -0400
Date: Wed, 14 Apr 2004 09:42:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <25670000.1081960943@[10.10.2.4]>
In-Reply-To: <20040414162700.GS2150@dualathlon.random>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org> <120240000.1081903082@flay> <20040414162700.GS2150@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As expected the 6 second difference was nothing compared the the noise,
> though I'd be curious to see an average number.

Yeah, I don't think either is worse or better - I really want a more stable
test though, if I can find one.

> the degradation of runtimes is interesting, runtimes should go downs not
> up after more unused stuff is pushed into swap and so more ram is free
> at every new start of the workload.

Yeah, that's odd.

> BTW, I've no idea idea why you used an UP machine for this, (plus if you

Because it's frigging hard to make a 16GB machine swap ;-) 'twas just my
desktop.

> critical app is using mremap on anonymous COW memory to save ram). You
> definitely should use your 32-way booted with mem=512m to run this test
> or there's no way you'll ever botice the additional boost in scalability
> that anon-vma provides compared to anonmm, and that anonmm will never be
> able to reach.

Yeah, it's hard to do mem= on NUMA, but I have a patch from someone 
somehwere. Those machines don't tend to swap heavily anyway, but I suppose
page reclaim in general will happen.

M.

