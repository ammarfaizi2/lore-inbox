Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVEPHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVEPHHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVEPHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 03:07:04 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32331
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261408AbVEPHG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:06:58 -0400
Date: Mon, 16 May 2005 09:06:50 +0200
From: andrea@cpushare.com
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050516070650.GA26073@g5.random>
References: <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain> <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <1116084186.20545.47.camel@localhost.localdomain> <20050514154538.GB6695@g5.random> <Pine.LNX.4.58.0505151533180.8633@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505151533180.8633@artax.karlin.mff.cuni.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 03:38:22PM +0200, Mikulas Patocka wrote:
> Another possibility to get timing is from direct-io --- i.e. initiate
> direct io read, wait until one cache line contains new data and you can be
> sure that the next will contain new data in certain time. IDE controller
> bus master operation acts here as a timer.

There's no way to do direct-io through seccomp, all the fds are pipes
with twisted userland listening the other side of the pipe. So disabling
the tsc is more than enough to give to CPUShare users a peace of mind
with HT enabled and without having to flush the l2 cache either.
CPUShare is the only case I can imagine where an untrusted and random
bytecode running at 100% system load is the normal behaviour.
