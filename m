Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317325AbSFCJLC>; Mon, 3 Jun 2002 05:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSFCJLB>; Mon, 3 Jun 2002 05:11:01 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:57350 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S317325AbSFCJLA>; Mon, 3 Jun 2002 05:11:00 -0400
Message-ID: <3CFB3383.44A6CC96@zip.com.au>
Date: Mon, 03 Jun 2002 02:14:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au> <20020602081204.GD820@suse.de> <20020603083937.GA23527@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> Does this work? I can't poke holes in it, but then again...

It survives a 30-minute test.  It would not have done that
before...

Are you sure blk_stop_queue() and blk_run_queues() can't
race against each other?  Seems there's a window where
they could both do a list_del().

-
