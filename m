Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSLBIoh>; Mon, 2 Dec 2002 03:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSLBIoh>; Mon, 2 Dec 2002 03:44:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:27269 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265725AbSLBIog>;
	Mon, 2 Dec 2002 03:44:36 -0500
Message-ID: <3DEB1F2C.E03517D7@digeo.com>
Date: Mon, 02 Dec 2002 00:51:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] 2.4.20-rmap15a
References: <200212012155.30534.m.c.p@wolk-project.de> <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com> <20021202081524.GQ16942@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 08:51:57.0489 (UTC) FILETIME=[12151210:01C299E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sun, Dec 01 2002, Rik van Riel wrote:
> > > So, here my patch proposal. Ontop of 2.4.20-rmap15a.
> >
> > Looks good, now lets test it.  If the patch is as needed as you
> > say we should push it to marcelo ;)
> 
> Yes lets for heavens sake not fix the problem, merge the hack.

If it fails to find a merge or insert the current 2.4 elevator
will stick a read at the far end of the request queue.  That's
quite arbitrary, and is the worst possible thing to do with it.

read-latency2 will put the read a tunable distance from the head.
Add a few embellishments to avoid permanent writer starvation,
and that's basically all it does.

So rather than just keeping on calling it a "hack" could you please
describe what is actually wrong with the idea?
