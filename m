Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRKVRm5>; Thu, 22 Nov 2001 12:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRKVRms>; Thu, 22 Nov 2001 12:42:48 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:40831 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S280126AbRKVRmm>; Thu, 22 Nov 2001 12:42:42 -0500
Date: Thu, 22 Nov 2001 17:33:21 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: war <war@starband.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFD2997.95F2B9EE@starband.net>
Message-ID: <Pine.LNX.3.96.1011122172658.24026B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, war wrote:
> There is no need for swap if you have enough ram.
> Using swap with more than enough ram does absolutley nothing for the system,
> except by degrading the performance of it.

You're too fast with drawing conclusions. You say you have "enough" ram -
tell me, how big is your harddisk ? Is it less than 1 GB ? Do you use more
than 1 GB of data on your harddisk regularly ? 

RAM is not just used to keep your programs in, but also to hold a working
copy of your dataset on the hard-disk. If the programs you use
concurrently use 500 MB RAM and never more, and you have 1 GB RAM, you
have 500 MB over for caching your hard disk content. As long as you only
access a footprint of 500 MB on your disk, you're fine. 

But as soon as you start accessing more data which in total will add up to
more than that 1 GB RAM, there is the _potential_ for a swap to speed up
access. There's absolutely nothing which say it _has_ to speed it up in a
_particular_ case, but generally it can.

Also remember that a "swap" only swaps dirty pages. Your programs are run
directly from the page-cache and can be flushed from that even if you have
"disabled swap". The only thing that differs by adding swap is another
freedom for the VM system to prioritize memory. Sometimes it does this
badly, and you get upset, and sometimes it does it well.

/Bjorn

