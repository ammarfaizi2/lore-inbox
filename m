Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTKKOrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTKKOrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:47:12 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:30851
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263517AbTKKOrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:47:09 -0500
Date: Tue, 11 Nov 2003 09:46:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: bill davidsen <davidsen@tmr.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <bop35i$795$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.53.0311110942280.8688@montezuma.fsmlabs.com>
References: <20031106130030.GC1145@suse.de> <3FAA5CCB.5030902@gmx.de>
 <3FAB0754.2040209@cyberone.com.au> <3FAB7F94.7050504@gmx.de>
 <bop35i$795$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, bill davidsen wrote:

> Looking at the system time being used I would say that this is doing
> something odd. If that's using DMA then for some reason is it doing a
> shitload of system calls at those times? I bet you're losing interrupts,
> getting nasty mousing, and I would wonder about dropping incoming
> network packets as well.
> 
> | deadline:
> | procs -----------memory---------- ---swap-- -----io---- --system-- 
> | ----cpu----
> |   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
> | sy id wa
> |   0  0      0 455400  52760 309808    0    0   464   430 1824  1107 13 
> | 6 72  8
> |   0  0      0 455400  52760 309808    0    0     0    31 1264   617  2 
> | 0 98  0
> |   1  0      0 455384  52760 309808    0    0     0     0 1441  1267  4 
> | 2 94  0
> |   0  0      0 455376  52760 309808    0    0     0     0 1489  1957  4 
> | 3 93  0
> |   0  0      0 455616  52800 309912    0    0   144     0 1390  1519 13 
> | 5 69 13
> |   1  0      0 447016  52800 312712    0    0  2800     0 2040  1476 34 
> | 7 35 24

procs -----------memory---------- ---swap-- -----io---- --system------cpu----
r  b   swpd   free   buff  cache   si   so    bi    bo   in     cs us sy id wa
0  0      0 455400  52760 309808    0    0   464   430 1824   1107 13  6 72  8
0  0      0 455400  52760 309808    0    0     0    31 1264   617  2   0 98  0
1  0      0 455384  52760 309808    0    0     0     0 1441  1267  4   2 94  0

That looks like fairly low system time and generally idle system to me, 
and the interrupt rate isn't high at all.
