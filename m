Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267927AbUHUV4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267927AbUHUV4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUHUV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:56:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64223 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267927AbUHUV4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:56:30 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040821140501.GA4189@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu>  <20040821140501.GA4189@elte.hu>
Content-Type: text/plain
Message-Id: <1093125390.817.22.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 17:56:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 10:05, Ingo Molnar wrote:
> i've uploaded the -P7 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P7
> 
> Changes since -P6:
> 
> - fixed the XFree86/X.org context-switch latency. (let me know if you
>   see any weirdness like X not starting up while it did before.)
> 
> - halved the pagevec size, to reduce the radix gang-lookup costs.
> 

Great, this is a significant improvement.  Most of the worst case
latencies (~150 usec) seem related to the TCP stack now, and a minor one
(51 usec) in the ext3 journaling:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P7

Lee

