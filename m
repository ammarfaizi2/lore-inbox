Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSKJPCC>; Sun, 10 Nov 2002 10:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264904AbSKJPCC>; Sun, 10 Nov 2002 10:02:02 -0500
Received: from holomorphy.com ([66.224.33.161]:17074 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264903AbSKJPCC>;
	Sun, 10 Nov 2002 10:02:02 -0500
Date: Sun, 10 Nov 2002 07:06:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021110150626.GI23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
	lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021110145757.GK31134@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 03:32:08PM +0100, Jens Axboe wrote:
>>> I've attached a small document describing the deadline io scheduler
>>> tunables. stream_unit is not in Andrew's version, yet, it uses a hard
>>> defined 128KiB. Also, Andrew didn't apply the rbtree patch only the
>>> tunable patch. So it uses the same insertion algorithm as the default
>>> kernel, two linked lists.

On Sun, Nov 10 2002, William Lee Irwin III wrote:
>> Okay, then I'll want the rbtree code for benchmarking.

On Sun, Nov 10, 2002 at 03:57:57PM +0100, Jens Axboe wrote:
> Sure, I want to talk akpm into merging the rbtree code for real. Or I
> can just drop you my current version, if you want.

Go for it, I'm just trying to get tiobench to actually run (seems to
have new/different "die from too many threads" behavior wrt. --threads).
Dropping me a fresh kernel shouldn't slow anything down.


Bill

P.S.:	elvtune gets hung for a long time, it says:
	ioctl get: Inappropriate ioctl for device
	did it schedule with something held and get out of deadlock free?

P.P.S:	kgdb broke wchan reporting... investigating
