Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbSLGGHT>; Sat, 7 Dec 2002 01:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbSLGGHT>; Sat, 7 Dec 2002 01:07:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:26067 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267726AbSLGGHT>;
	Sat, 7 Dec 2002 01:07:19 -0500
Message-ID: <3DF191DA.A88E2C1A@digeo.com>
Date: Fri, 06 Dec 2002 22:14:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] max bomb segment tuning with read latency 2 patch in  
 contest
References: <200212071620.05503.conman@kolivas.net> <3DF18D38.F493636C@digeo.com> <200212071709.50023.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 06:14:51.0040 (UTC) FILETIME=[F38BDA00:01C29DB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> >If the SMP machine is using scsi then that tends to make the elevator
> >changes less effective.  Because the disk sort-of has its own internal
> >elevator which in my testing on a Fujitsu disk has the same ill-advised
> >design as the kernel's elevator: it treats reads and writes in a similar
> >manner.
> 
> These are ide disks, in the same format as those used in the UP machine, so it
> still should be showing the same effect? I think higher numbers in UP would
> increase the resolution more for these results - apart from that is there any
> disadvantage to doing it in SMP? If you think it's worth running them in UP
> mode I'll do that.

Oh, OK.  I was guessing, and guessed wrong.  No, I don't expect you'd
see much difference switching to UP for those tests which are sensitive
to the IO scheduler policy.
