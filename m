Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUHMEi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUHMEi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268969AbUHMEi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:38:58 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:38347 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268968AbUHMEi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:38:57 -0400
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
From: Roland Dreier <roland@topspin.com>
Date: Thu, 12 Aug 2004 21:35:40 -0700
In-Reply-To: <1092370997.2769.5.camel@mindpipe> (Lee Revell's message of
 "Fri, 13 Aug 2004 00:23:18 -0400")
Message-ID: <527js31wpv.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Aug 2004 04:35:40.0942 (UTC) FILETIME=[FD0F32E0:01C480EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Lee> I believe this is the correct patch, based on
    Lee> arch/sparc64/kernel/sparc64_ksyms.c.  Ingo, are you using a
    Lee> sparc64 for your testing?

He's probably just not using modules.  There's no way LATENCY_TRACE
can work on anything except i386, since that's the only definition of
mcount that's provided (and if one were being anal, it would probably
make more sense to add the config stuff to arch/i386/Kconfig rather
than init/Kconfig).

 - R.

