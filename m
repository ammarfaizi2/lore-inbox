Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbTAPUVx>; Thu, 16 Jan 2003 15:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267259AbTAPUVx>; Thu, 16 Jan 2003 15:21:53 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33175 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267257AbTAPUVw>;
	Thu, 16 Jan 2003 15:21:52 -0500
Message-Id: <200301162029.h0GKTmt14173@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH 2.5.58] new NUMA scheduler: fix 
In-reply-to: Your message of "Thu, 16 Jan 2003 21:19:22 +0100."
             <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain> 
Date: Thu, 16 Jan 2003 12:29:48 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    [whether it's high
    frequency or not depends on the actual workload, but it can be potentially
    _very_ high frequency, easily on the order of 1 million times a second -
    then you'll call the inter-node balancer 100K times a second.]

If this is due to thread creation/death, though, you might want this level
of inter-node balancing (or at least checking).  It could represent a lot
of fork/execs that are now overloading one or more nodes. Is it reasonable
to expect this sort of load on a relatively proc/thread-stable machine?

Rick
