Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSKRHnR>; Mon, 18 Nov 2002 02:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSKRHnR>; Mon, 18 Nov 2002 02:43:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:61663 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261596AbSKRHnQ>; Mon, 18 Nov 2002 02:43:16 -0500
Date: Sun, 17 Nov 2002 23:47:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <673851077.1037576831@[10.10.2.3]>
In-Reply-To: <20021118065705.GG11776@holomorphy.com>
References: <20021118065705.GG11776@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This oopses on NUMA-Q sometime prior to TSC synch and then hangs in TSC
> synch because not all cpus are responding where 2.5.47-mm3 (which
> included some intermediate bk stuff) did not. This is because AP's are
> taking timer interrupts before they are prepared to do so. Please apply
> the following patch from Martin Bligh which resolves this issue:

It seems to come and go randomly (timing issue), it's not new with 48. 
Has been happening since 44-mm3 or so. Just as a point of interest,
doesn't seem to be the timer int itself that kill her, it's the 
softirq processing that happens in irq_exit on the way back.

M.

