Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUCKRdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUCKRdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:33:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18696
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261442AbUCKRdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:33:11 -0500
Date: Thu, 11 Mar 2004 18:33:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
Message-ID: <20040311173352.GJ30940@dualathlon.random>
References: <20040311065254.GT30940@dualathlon.random> <Pine.LNX.4.44.0403111248450.1402-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403111248450.1402-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, it links and boots ;)

at the previous try, with slab debugging enabled, it was spawning tons
of errors but I suspect it's a bug in the slab debugging, it was
complaining with red zone memory corruption, could be due the tiny size
of this object (only 8 bytes).

andrea@xeon:~> grep anon_vma /proc/slabinfo
anon_vma            1230   1500     12  250    1 : tunables  120   60 8 : slabdata      6      6      0
andrea@xeon:~> 

now I need to try swapping... (I guess it won't work at the first try,
I'd be surprised if I didn't miss any s/index/private/)
