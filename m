Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271849AbRH0TAR>; Mon, 27 Aug 2001 15:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRH0S75>; Mon, 27 Aug 2001 14:59:57 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:20125 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S271846AbRH0S7m>; Mon, 27 Aug 2001 14:59:42 -0400
Message-Id: <200108271859.f7RIxsY20134@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Subject: Re: Journal FS Comparison on IOzone (was Netbench)
Date: Mon, 27 Aug 2001 14:59:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8A9070.AD43D0E7@osdlab.org>
In-Reply-To: <3B8A9070.AD43D0E7@osdlab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 August 2001 02:24 pm, Randy.Dunlap wrote:
> I am using a Linux 2.4.7 on a 4-way VA Linux system.
> It has 4 GB of RAM, but I have limited it to 256 MB in
> accordance with IOzone run rules.

I might have gone with a dual-proc, simply because they seem to be the 
server config of choice around here, but that may not hold true for your 
own needs.

> However, I suspect that this causes IOzone to measure disk
> subsystem or PCI bus performance more than it does FS performance.
> Any comments on this?

It gives you a mix of in-memory and on-disk operations.  The on-disk work 
is worth noting -- it tells you how well the FS handles/causes 
fragmentation.  FAT, WAFL, and Tux2, for instance, would probably do very 
poorly on random reads, since they tend to have a lot of fragmentation.  
WAFL and Tux2, on the other hand, should slaughter everyone on random 
writes.

	-- Brian
