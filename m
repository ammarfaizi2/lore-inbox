Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272267AbTHIGeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 02:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272268AbTHIGeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 02:34:31 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:64264 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id S272267AbTHIGea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 02:34:30 -0400
Date: Sat, 9 Aug 2003 07:12:07 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Jamie Lokier <jamie@shareable.org>
cc: Andrew Morton <akpm@osdl.org>, Grant Miner <mine0057@mrs.umn.edu>,
       <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: Filesystem Tests
In-Reply-To: <20030809010950.GD26375@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.30.0308090609370.19108-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Aug 2003, Jamie Lokier wrote:
> Szakacsits Szabolcs wrote:
> > I run the results through some scripts to make it more readable.
>
> I think that instead of giving the CPU percentage, you should give the
> CPU time used:
>
> 	CPU time used = CPU percentage * total time

In that case, the next time one could complain similarly, "instead of
giving the CPU time used, you should give the CPU percentage". Probably
that's the reason usually both is given, CPU time used in user and system
space as well.

> This would give a more accurate measure of how much CPU is used by the
> different filesystems.

The CPU percentages were given as integers in Grant's original numbers and
in same cases as 0. Doing mindless math with those would have given (even
more) bogus and misleading results.

> As someone said, if certain operations are faster with reiser4, you
> expect a greater percentage of CPU time to be spent in the disk driver
> etc. - if the amount of I/O is the same, that is.

I just can't believe reiser4 is so fast on an unloaded system (from the
numbers one could also expect it's the slowest on loaded systems and JFS
seems to be the winner on those). Disks have a speed/seek limits. To be
faster, one must ignore 'sync', do less IO (file/tail packing, compression,
etc) and/or optimise seek times.

> Another interesting statistic would be the number of blocks read and
> written during the test.

Yes, but I would collect those stats after these short term tests for an
additional X seconds to make sure no additional "optimization" is involved
(aka data is indeed on the disk).

	Szaka

