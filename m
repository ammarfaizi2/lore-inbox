Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSKLBow>; Mon, 11 Nov 2002 20:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266092AbSKLBow>; Mon, 11 Nov 2002 20:44:52 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:64919 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266091AbSKLBos>;
	Mon, 11 Nov 2002 20:44:48 -0500
Message-ID: <1037065894.3dd05ea6f1d84@kolivas.net>
Date: Tue, 12 Nov 2002 12:51:34 +1100
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <1037057498.3dd03dda5a8b9@kolivas.net> <3DD046BD.799F36D4@digeo.com>
In-Reply-To: <3DD046BD.799F36D4@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > 
> > io_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.18 [3]              474.1   15      36      10      6.64
> > 2.4.19 [3]              492.6   14      38      10      6.90
> > 2.5.46 [1]              600.5   13      48      12      8.41
> > 2.5.46-mm1 [5]          134.3   58      6       8       1.88
> > 2.5.47 [3]              165.9   46      9       9       2.32
> > 2.5.47-mm1 [5]          126.3   61      5       8       1.77
> > 
> > Very nice. Further improvement in 2.5.47-mm1 (note the big change in
> 2.5.46-47
> > is consistent with the preempt addition as mentioned in a previous thread)
> > 
> 
> Actually, 2.5.47 changed fifo_batch from 32 to 16.  That's what caused
> this big shift.

There I go again, inappropriately commenting on the kernel ;-P Anyway preempt
does help here too (I never said that).

> We've increased the kernel build speed by 3.6x while decreasing the
> speed at which writes are retired by 5.3x.
> 
> It could be argued that this is a net decrease in throughput.  Although
> there's clearly a big increase in total CPU utilisation.
> 
> It's a tradeoff.  I think this is a better tradeoff than the old one
> though.

I agree. Fortunately I don't think it's as bad a tradeoff as these numbers make
out. The load accounting in contest (johntest?) is still relatively bogus. Apart
from saying it's more or less loads I dont think the scale of the numbers are
accurate.

Con
