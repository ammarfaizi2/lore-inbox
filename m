Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135666AbREAXoC>; Tue, 1 May 2001 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136773AbREAXnw>; Tue, 1 May 2001 19:43:52 -0400
Received: from pa147.bialystok.sdi.tpnet.pl ([213.25.59.147]:1284 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135666AbREAXnm>; Tue, 1 May 2001 19:43:42 -0400
Date: Wed, 2 May 2001 01:42:16 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@ulgo.koti.com.pl>
To: linux-kernel@vger.kernel.org
Subject: reason for VIA performance drop since 2.4.2-ac21
Message-ID: <20010502014216.A604@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have motherboard with VIA MVP3 chipset. 

I noticed big video slowdown since 2.4.2-ac21. Watching "divx" by avifile with
new kernels is impossible, becouse very bad performance. Now, after few hours -
I found the reason, and I don't understand it.

It has nothing to do with mtrr or K6.  In file arch/i386/kernel/pci-pc.c there
is a pci_fixup_via691_2 function.  It appeared in 2.4.2-ac21. And it works for
my chipset - VIA_82C598. When I put "return" in body of this function,
recompile and start kernel 2.4.4 - "x11perf -putimage100" shows that video
works fast again.

I see two possibilities:

1) this is just a debug code, and kernels >2.4.2-ac20 shouldn't be used by VIA
MVP3 owners
2) this code fix crash possibility, and all kernels without it (including
2.2.19) are buggy with VIA MVP3

What is true, and is it safe to skip that function if I need 2.4 and fast video?

