Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268630AbUHMExt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268630AbUHMExt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268631AbUHMExt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:53:49 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:7374 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268630AbUHMExq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:53:46 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
X-Message-Flag: Warning: May contain useful information
References: <20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	<1092360317.1304.72.camel@mindpipe>
	<1092360704.1304.76.camel@mindpipe> <1092364786.877.1.camel@mindpipe>
	<1092369242.2769.1.camel@mindpipe> <1092370997.2769.5.camel@mindpipe>
	<527js31wpv.fsf@topspin.com> <1092372092.3450.0.camel@mindpipe>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 12 Aug 2004 21:46:28 -0700
In-Reply-To: <1092372092.3450.0.camel@mindpipe> (Lee Revell's message of
 "Fri, 13 Aug 2004 00:41:32 -0400")
Message-ID: <523c2r1w7v.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Aug 2004 04:46:29.0286 (UTC) FILETIME=[7F80A460:01C480F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Lee> It also exists on sparc64, it's just called _mcount.

That's something completely different (used for stack overflow
debugging, I think).  (and ".globl mcount, _mcount" means it's also
called mcount)

Look at Ingo's patch; it only adds mcount() to arch/i386 (although
__mcount is defined in kernel/latency.c, there's no way for any other
arch to call it).

 - Roland

