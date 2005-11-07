Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVKGDT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVKGDT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVKGDT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:19:56 -0500
Received: from mxsf38.cluster1.charter.net ([209.225.28.165]:26330 "EHLO
	mxsf38.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932431AbVKGDTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:19:52 -0500
X-IronPort-AV: i="3.97,298,1125892800"; 
   d="scan'208"; a="1759683353:sNHT22747488"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.51158.263211.148554@smtp.charter.net>
Date: Sun, 6 Nov 2005 22:19:50 -0500
From: "John Stoffel" <john@stoffel.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: Best CPU chipset for Linux? (was: [Lhms-devel] [PATCH 0/7]
 Fragmentation Avoidance V19)
In-Reply-To: <Pine.LNX.4.64.0511061750360.3316@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	<Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	<20051103221037.33ae0f53.pj@sgi.com>
	<20051104063820.GA19505@elte.hu>
	<Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
	<796B585C-CB1C-4EBA-9EF4-C11996BC9C8B@mac.com>
	<Pine.LNX.4.64.0511060756010.3316@g5.osdl.org>
	<Pine.LNX.4.64.0511060848010.3316@g5.osdl.org>
	<17262.44501.595440.472947@smtp.charter.net>
	<Pine.LNX.4.64.0511061750360.3316@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus> On Sun, 6 Nov 2005, John Stoffel wrote:
>> 
>> Has any vendor come close to the ideal CPU architecture for an OS?  I
>> would assume that you'd want:

Linus> Well, in the end, the #1 requirement ends up being "wide
Linus> availability of development boxes".

Heh!  Take my thoughts and turn them on my head.  Bravo!  


Linus> We do want a "big enough" virtual address space, that's pretty
Linus> much required. It doesn't necessarily have to be the full 64
Linus> bits, and it's fine if the IO space is just a part of that.

So 40 bits is fine for now, but 64 would be great just because it
solves the problem for a long long time?  

Linus> As to ISA and registers - nobody much cares. The compiler takes
Linus> care of it, and I'd personally _much_ rather see a common ISA
Linus> than a "clean" one.  The x86 architecture may be odd, but it
Linus> works well.

But aren't there areas where the ISA would expose useful parts of the
underlying microarchitecture that could be more efficiently used in
OSes?  

Linus>  - fast large first-level caches help a lot. And I'd rather
Linus>  take a bigger L1 that has a two- or even three-cycle latency
Linus>  than a small one. That's assuming the uarch is out-of-order,
Linus>  of course.

Linus>  - good fast L2, and I'll take low-latency memory access over
Linus>  an L3 any day.

Linus>  - low-latency serialization (locking and memory barriers). In
Linus>  fact, pretty much low-latency everything (branch mispredict
Linus>  latency etc).

Linus>  - cheap and powerful.

Linus> but the fact is, we'll work with pretty much any crap we're
Linus> given. If it's bad, it won't make it in the marketplace.

The corollary of course is that if it's excellent but the marketplace
doesn't like it for some reason, we'll still let it go.  I keep
wishing for the Alpha to come back sometimes...  Oh well.

Thanks for your thoughts Linus.

John
