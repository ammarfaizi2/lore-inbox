Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSKJQvu>; Sun, 10 Nov 2002 11:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSKJQvu>; Sun, 10 Nov 2002 11:51:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:28865 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264944AbSKJQvt>;
	Sun, 10 Nov 2002 11:51:49 -0500
Message-ID: <3DCE9034.6F833C31@digeo.com>
Date: Sun, 10 Nov 2002 08:58:28 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de> <20021110150626.GI23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2002 16:58:28.0952 (UTC) FILETIME=[64765580:01C288DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Sun, Nov 10, 2002 at 03:32:08PM +0100, Jens Axboe wrote:
> >>> I've attached a small document describing the deadline io scheduler
> >>> tunables. stream_unit is not in Andrew's version, yet, it uses a hard
> >>> defined 128KiB. Also, Andrew didn't apply the rbtree patch only the
> >>> tunable patch. So it uses the same insertion algorithm as the default
> >>> kernel, two linked lists.
> 
> On Sun, Nov 10 2002, William Lee Irwin III wrote:
> >> Okay, then I'll want the rbtree code for benchmarking.
> 
> On Sun, Nov 10, 2002 at 03:57:57PM +0100, Jens Axboe wrote:
> > Sure, I want to talk akpm into merging the rbtree code for real. Or I
> > can just drop you my current version, if you want.
> 
> Go for it, I'm just trying to get tiobench to actually run (seems to
> have new/different "die from too many threads" behavior wrt. --threads).
> Dropping me a fresh kernel shouldn't slow anything down.

It could be the procps thing?  `tiobench --threads 256' shows up as a
single process in top and ps due to the new thread consolidation feature.
If you run `ps auxm' or hit 'H' in top, all is revealed.  Not my fave
feature that.

> Bill
> 
> P.S.:   elvtune gets hung for a long time, it says:
>         ioctl get: Inappropriate ioctl for device
>         did it schedule with something held and get out of deadlock free?

BLKELVGET/SET was removed
 
> P.P.S:  kgdb broke wchan reporting... investigating

?
