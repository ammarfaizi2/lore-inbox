Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbRCUOEB>; Wed, 21 Mar 2001 09:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131449AbRCUODv>; Wed, 21 Mar 2001 09:03:51 -0500
Received: from chiara.elte.hu ([157.181.150.200]:9747 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131448AbRCUODn>;
	Wed, 21 Mar 2001 09:03:43 -0500
Date: Wed, 21 Mar 2001 15:01:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Anton Blanchard <anton@linuxcare.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pagecache SMP-scalability patch [was: spinlock usage]
In-Reply-To: <Pine.GSO.4.21.0103210847500.739-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0103211500470.6864-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Mar 2001, Alexander Viro wrote:

> ???
> <checking 2.2.0>
> Nope, no calls into ext2/*. do_revalidate() seeing NULL ->i_revalidate
> and doing nothing, lnamei() doing usual lookup, cp_old_stat() not touching
> fs code at all...

the problem was that it was calling lock_kernel(), not the lowlevel fs i
believe - this caused contention.

	Ingo

