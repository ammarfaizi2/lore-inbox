Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUHTKeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUHTKeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHTKeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:34:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3223 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266204AbUHTKdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:33:50 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040820102732.GA14622@elte.hu>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092972918.10063.11.camel@krustophenia.net>
	 <20040820081319.GA4321@elte.hu>
	 <1092993242.10063.66.camel@krustophenia.net>
	 <20040820102732.GA14622@elte.hu>
Content-Type: text/plain
Message-Id: <1092998028.10063.103.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 06:33:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 06:27, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > This is an extreme load situation, so I don't think it will be a
> > real-world problem.  I have not seen it under any normal workload.
> 
> well, 9 msecs is still not nice. I've been able to trigger larger than
> 10msec latencies too on a 2 GHz box.
> 

If this is the case then should a make -j12 have ground the machine 
to a halt the way it did?

> hm, tcp_collapse() in net/ipv4/tcp_input.c. Could you try to just return
> from that function?  Collapsing skbs of a given socket is not a
> necessary functionality (it is only a 'nice' thing to have in OOM
> situations) and it indeed can introduce quite high latencies.
> 

OK, will test this.

Lee

