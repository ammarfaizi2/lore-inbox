Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbTK0Smm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 13:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbTK0Smm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 13:42:42 -0500
Received: from relay-6v.club-internet.fr ([194.158.96.111]:24748 "EHLO
	relay-6v.club-internet.fr") by vger.kernel.org with ESMTP
	id S264574AbTK0Sml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 13:42:41 -0500
From: pinotj@club-internet.fr
To: manfred@colorfullife.com, torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Thu, 27 Nov 2003 19:42:39 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069958559.15912.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first, some news

2.6.0-test11 makes same oops during second compilation of kernel. The vanilla kernel with PREEMPT always oops the same way. No matter, it's always reproductible.

2.6.0-test11 + Manfred's patch doesn't hang but I found a slab error in the logs that occured during a compilation. (I didn't find this for -test10, I was lucky ?)

So, there is no more way for my system to run a kernel > -test9 without problem.

>De: Manfred Spraul <manfred@colorfullife.com>
[...]
>There are several sources for the "-1": My initial guess was either a bug in slab, or a bad memory cell (only one bit difference). 
>Thus I sent him a patch that changes multiple bits. Result: It remained a single bit change, i.e it's proven that slab doesn't write BUFCTL_END into the wrong slot.

Thanks for your explanation.
Should I try with L1 and/or L2 cache disable on my computer (I don't know if it's safe) ?
I trust my hardware but it's better to get some facts.

Jerome Pinot

(between LFS/BLFS, kernel compilation and tests compilation, I will surely break kind of record about load average :-)

