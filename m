Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318858AbSICRZy>; Tue, 3 Sep 2002 13:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318860AbSICRZy>; Tue, 3 Sep 2002 13:25:54 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:49170 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318858AbSICRZv>;
	Tue, 3 Sep 2002 13:25:51 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031730.g83HUIb15556@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.LNX.4.44.0209031003370.1889-100000@dlang.diginsite.com> from
 David Lang at "Sep 3, 2002 10:07:48 am"
To: David Lang <david.lang@digitalinsight.com>
Date: Tue, 3 Sep 2002 19:30:18 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago David Lang wrote:"
> Peter, the thing that you seem to be missing is that direct mode only
> works for writes, it doesn't force a filesystem to go to the hardware for
> reads.

Yes it does. I've checked! Well, at least I've checked that writing
then reading causes the reads to get to the device driver. I haven't
checked what reading twice does.

If it doesn't cause the data to be read twice, then it ought to, and
I'll fix it (given half a clue as extra pay ..:-)

> for many filesystems you cannot turn off their internal caching of data
> (metadata for some, all data for others)

Well, let's take things one at a time. Put in a VFS mechanism and then
convert some FSs to use it.

> so to implement what you are after you will have to modify the filesystem
> to not cache anything, since you aren't going to do this for every

Yes.

> filesystem you end up only haivng this option on the one(s) that you
> modify.

I intend to make the generic mechanism attractive.

> if you have a single (or even just a few) filesystems that have this
> option you may as well include the locking/syncing software in them rather
> then modifying the VFS layer.

Why? Are you advocating a particular approach? Yes, I agree that that
is a possible way to go - but I will want the extra VFS ops anyway, 
and will want to modify the particular fs to use them, no?

Peter
