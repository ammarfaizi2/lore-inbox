Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbTCTINp>; Thu, 20 Mar 2003 03:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbTCTINo>; Thu, 20 Mar 2003 03:13:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:63126 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261312AbTCTINo>;
	Thu, 20 Mar 2003 03:13:44 -0500
Date: Thu, 20 Mar 2003 00:20:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.65-mm2
Message-Id: <20030320002050.44f13857.akpm@digeo.com>
In-Reply-To: <20030320080449.GL4990@suse.de>
References: <20030319232812.GJ2835@ca-server1.us.oracle.com>
	<20030319175726.59d08fba.akpm@digeo.com>
	<20030320003858.GM2835@ca-server1.us.oracle.com>
	<20030320080449.GL4990@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 08:20:41.0974 (UTC) FILETIME=[98CD3160:01C2EEB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Besides, deadline is still the most solid choice.

Deadline will always be the best choice for OLTP workloads.  Or CFQ - it
should perform the same.

All this workload does is seeks all over the disk doing teeny synchronous
I/O's.  It is the worst-case for AS.

What we are trying to do at present is to make AS not _too_ bad for these
workloads so that people with mixed workloads or who are not familiar with
kernel arcanery don't accidentally end up with something which is
significantly slower than it should be.

It is an interesting test case.

