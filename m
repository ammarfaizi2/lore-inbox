Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSHMRTU>; Tue, 13 Aug 2002 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSHMRTU>; Tue, 13 Aug 2002 13:19:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18954 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318968AbSHMRSs>; Tue, 13 Aug 2002 13:18:48 -0400
Date: Tue, 13 Aug 2002 10:24:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <1995160000.1029258898@flay>
Message-ID: <Pine.LNX.4.44.0208131023360.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> 
> Was there some reason you really need this on P4s? I seem to recall something
> to do with timer interrupts, but don't remember exactly.

Without the explicit balancing, _every_single_ external interrupt comes in 
on CPU0 on a P4.

The P4 local APIC doesn't do irq scheduling in hardware (never mind that
Intel documented it as architecture behaviour in earlier local APICs)

		Linus

