Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262246AbSIZIWu>; Thu, 26 Sep 2002 04:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbSIZIWt>; Thu, 26 Sep 2002 04:22:49 -0400
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:20363 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S262246AbSIZIWt>;
	Thu, 26 Sep 2002 04:22:49 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com>
	<20020926064455.GC12862@suse.de>
In-Reply-To: <20020926064455.GC12862@suse.de> (Jens Axboe's message of "Thu,
 26 Sep 2002 08:44:55 +0200")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Thu, 26 Sep 2002 18:28:01 +1000
Message-ID: <87k7l95f5a.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Jens Axboe wrote:
> On Wed, Sep 25 2002, Andrew Morton wrote:

[...]

> writes_starved. This controls how many times reads get preferred over
> writes. The default is 2, which means that we can serve two batches of
> reads over one write batch. A value of 4 would mean that reads could
> skip ahead of writes 4 times. A value of 1 would give you 1:1
> read:write, ie no read preference. A silly value of 0 would give you
> write preference, always.

Actually, a value of zero doesn't sound completely silly to me, right
now, since I have been doing a lot of thinking about video capture
recently.

How much is it going to hurt a filesystem like ext[23] if that value is
set to zero while doing large streaming writes -- something like
(almost) uncompressed video at ten to twenty meg a second, for
gigabytes?

This is a situation where, for a dedicated machine, delaying reads
almost forever is actually a valuable thing. At least, valuable until it
stops the writes from being able to proceed.

      Daniel

-- 
The best way to get a bad law repealed is to enforce it strictly.
        -- Abraham Lincoln
