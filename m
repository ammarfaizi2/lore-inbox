Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTICRp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbTICRp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:45:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37646 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264136AbTICRpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:45:21 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Date: 3 Sep 2003 17:36:41 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj58r9$85p$1@gatekeeper.tmr.com>
References: <20030901082911.GA1638@mail.jlokier.co.uk> <20030901020203.1779efe8.davem@redhat.com>
X-Trace: gatekeeper.tmr.com 1062610601 8377 192.168.12.62 (3 Sep 2003 17:36:41 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030901020203.1779efe8.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:

| > This is my strategy:
| > 
| > 	mmap MAP_ANON without MAP_FIXED to find a free area
| > 	mmap MAP_FIXED over the anon area at same address
| > 	mmap MAP_FIXED over the anon area at larger address
| > 
| > I don't see any strategy that lets me establish this kind of circular
| > mapping on Sparc without either (a) knowing the value of SHMLBA, or
| > (b) risking clobbering another thread's mmap.
| 
| Why do you need the same piece of data mapped to multiple places
| in the first place, and why at specific addresses?  It's purely an
| optimization of some sort, right?

I think he said he was doing DSP... there's a trick of double mapping
the same memory to save one subscript calculation in FFT (or maybe DFT)
inner loop. The only reason I know this is that a friend did a master's
thesis on DSP about 20 years ago, and I absorbed some info I hope to
never need. He also coded an FFT instruction in the LCS (programmable
firmware) of a VAX.

I am only speculating, of course.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
