Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbTAFQD0>; Mon, 6 Jan 2003 11:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTAFQD0>; Mon, 6 Jan 2003 11:03:26 -0500
Received: from algx-tower-com-4173.z188-2-66.customer.algx.net ([66.2.188.62]:7582
	"EHLO neon.limebrokerage.com") by vger.kernel.org with ESMTP
	id <S267007AbTAFQDZ>; Mon, 6 Jan 2003 11:03:25 -0500
Date: Mon, 6 Jan 2003 11:11:57 -0500 (EST)
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
X-X-Sender: ion@guppy.limebrokerage.com
To: Andrew Morton <akpm@digeo.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: bogus change in cset 1.902
Message-ID: <Pine.LNX.4.44.0301061106110.22375-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From cset-1.902.txt:

> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/01/05      akpm@digeo.com  1.902
> # [PATCH] misc fixes
> # 
> #  - fix starfire.c printk compile warning (dma_addr_t can be 64 bit) (Martin
> #    Bligh)

That may fix the compile warning, but it doesn't make the driver work with 
a 64-bit dma_addr_t. It just shoves the warning under the carpet.

I sent Jeff Garzik a newer version of the driver which adds proper support
for 64-bit dma_addr_t, it's probably sitting in his to-merge queue. This 
change should be backed out, however.

Thanks,
Ion
[starfire driver maintainer]

