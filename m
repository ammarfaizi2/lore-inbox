Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129815AbQLATGM>; Fri, 1 Dec 2000 14:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbQLATGC>; Fri, 1 Dec 2000 14:06:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40323 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129465AbQLATFt>;
	Fri, 1 Dec 2000 14:05:49 -0500
Date: Fri, 1 Dec 2000 10:19:44 -0800
Message-Id: <200012011819.KAA02951@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andrea@suse.de
CC: ink@jurassic.park.msu.ru, ezolt@perf.zko.dec.com, axp-list@redhat.com,
        rth@twiddle.net, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com, linux-alpha@vger.kernel.org
In-Reply-To: <20001201151842.C30653@athlon.random> (message from Andrea
	Arcangeli on Fri, 1 Dec 2000 15:18:42 +0100)
Subject: Re: mm->context[NR_CPUS] and pci fix check [was Re: Alpha SCSI error on 2.4.0-test11]
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru> <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com> <20001130233742.A21823@athlon.random> <20001201145619.A553@jurassic.park.msu.ru> <20001201151842.C30653@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 1 Dec 2000 15:18:42 +0100
   From: Andrea Arcangeli <andrea@suse.de>

   I'm still left the #ifdef __alpha__ around the context[NR_CPUS] to
   avoid breakage of other archs but that should be probably removed:
   any CPU with per-CPU ASNs like alpha needs per-CPU per-MM context
   information to avoid wasting ASNs when the task migrate CPU or with
   threads.

I would instead suggest to declare 'context' to be of an arch-specific
defined type, much like "thread_struct" is.

For example, I don't need NR_CPUS contexts in the mm_struct on
sparc64, my allocation just works differently, so I shouldn't eat
all the space.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
