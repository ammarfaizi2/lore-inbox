Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTLHU4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTLHU4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:56:37 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:21255 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262694AbTLHU4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:56:33 -0500
Date: Mon, 8 Dec 2003 15:55:56 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
In-Reply-To: <Pine.LNX.4.58.0312080109010.1758@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0312081553340.31173@devserv.devel.redhat.com>
References: <3FD3FD52.7020001@cyberone.com.au> <Pine.LNX.4.58.0312080109010.1758@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Dec 2003, Zwane Mwaikambo wrote:

> > P.S.
> > I have an alternative to Ingo's HT scheduler which basically does
> > the same thing. It is showing a 20% elapsed time improvement with a
> > make -j3 on a 2xP4 Xeon (4 logical CPUs).
> 
> -j3 is an odd number, what does -j4, -j8, -j16 look like?

let me guess: -j3 is the one that gives the highest performance boost on a 
2-way/4-logical P4 box?

for the SMT/HT scheduler to give any benefits there has to be idle time -
so that SMT decisions actually make a difference.

the higher -j values are only useful to make sure that SMT scheduling does
not introduce regressions - performance should be the same as the pure
SMP/NUMA scheduler's performance.

	Ingo
