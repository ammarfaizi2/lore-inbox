Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbUCTM3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbUCTM3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:29:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40130
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263390AbUCTM3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:29:18 -0500
Date: Sat, 20 Mar 2004 13:30:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040320123009.GC9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2663710000.1079716282@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 09:11:23AM -0800, Martin J. Bligh wrote:
> Well, I'm pleased to say not only is your code stable in my tests, it's
> also faster than partial objrmap (not by that much, but definitely 
> measurable). And of course, the code's cleaner. Kernbench & SDET are both 
> heavy on fork/exec/exit, so this should give these paths a heavy workout.
> (this was on 16-way NUMA-Q).
> 
> Andrea, are you still working on your code at the moment, or is it ready
> for others to play with? I'll make a run at that as well if you say it's
> ready, though I think I might have lost track of the latest version ;-)

I'm working on my code yes, I think my code is finished, I prefer my
design for the various reasons explained in the other emails (you don't
swap so you can't appreciate the benefits, you only have to check that
performs as well as Hugh's code).

Hugh's and your code is unstable in objrmap, you can find the details in
the email I sent to Hugh, mine is stable (running such simulation for a
few days just fine on 4-way xeon, without my objrmap fixes it live locks
as soon as it hits swap).

You find my anon_vma in 2.6.5-rc1aa2, it's rock solid, just apply the
whole patch and compare it with your other below results. thanks.
