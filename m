Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUHVAGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUHVAGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 20:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUHVAGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 20:06:33 -0400
Received: from relay.pair.com ([209.68.1.20]:8208 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261711AbUHVAGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 20:06:31 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <4127E386.5000701@cybsft.com>
Date: Sat, 21 Aug 2004 19:06:30 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
References: <1092628493.810.3.camel@krustophenia.net>	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>	 <20040820195540.GA31798@elte.hu>  <20040821140501.GA4189@elte.hu> <1093125390.817.22.camel@krustophenia.net>
In-Reply-To: <1093125390.817.22.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
 > On Sat, 2004-08-21 at 10:05, Ingo Molnar wrote:
 >
 >>i've uploaded the -P7 patch:
 >>
 >>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P7
 >>
 >>Changes since -P6:
 >>
 >>- fixed the XFree86/X.org context-switch latency. (let me know if you
 >>  see any weirdness like X not starting up while it did before.)
 >>
 >>- halved the pagevec size, to reduce the radix gang-lookup costs.
 >>
 >
 >
 > Great, this is a significant improvement.  Most of the worst case
 > latencies (~150 usec) seem related to the TCP stack now, and a minor one
 > (51 usec) in the ext3 journaling:
 >
 > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P7
 >
 > Lee
 >

I just posted a similar trace of ~4141 usec from P6 here:

http://www.cybsft.com/testresults/2.6.8.1-P6/latency-trace1.txt

This was part of a run from yesterday evening. After just rebooting, I
too am seeing several of these. With the system not being hammered by
the stress tests though, the max is only up to ~103 usec. I will be
updating to P7 shortly.

kr

