Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266041AbTLIQcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbTLIQcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:32:55 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:38307 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S266041AbTLIQcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:32:53 -0500
Date: Tue, 9 Dec 2003 17:31:49 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031209163149.GA7735@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
References: <20031209151103.GA4837@k3.hellgate.ch> <Pine.LNX.4.44.0312091103100.8917-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312091103100.8917-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 11:04:49 -0500, Rik van Riel wrote:
> > The classic strategies based on these criteria work for transaction and
> > batch systems. They are all but useless, though, for a workstation and
> > even most modern servers, due to assumptions that are incorrect today
> > (remember all the degrees of freedom a scheduler had 30 years ago)
> > and additional factors that only became crucial in the past few decades
> > (latency again).
> 
> Don't forget that computers have gotten a lot slower
> over the years ;)
> 
> Swapping out a 64kB process to a disk that does 180kB/s
> is a lot faster than swapping out a 100MB process to a
> disk that does 50MB/s ...
> 
> Once you figure in seek times, the picture looks even
> worse.

Exactly -- I did mention the growing access time gap between RAM and
disks in an earlier message. Yes, there are quite a few developments in
hardware and in the way we use computers (interactive, Client/Server,
dedicated machines, etc.) that made thrashing pretty much unsolvable
at an OS level. Fortunately, fixing it in hardware by adding RAM works
for most.

What we _can_ do in software, though, is prevent thrashing as long as
possible. Comparing 2.4 and 2.6 shows that a kernel can still make a
significant difference with smart pageout algorithms, I/O scheduling etc.
But you won't get much help with that from ancient papers.

Roger
