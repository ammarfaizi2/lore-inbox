Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbSIXVNN>; Tue, 24 Sep 2002 17:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSIXVNN>; Tue, 24 Sep 2002 17:13:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56840 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261818AbSIXVNM>; Tue, 24 Sep 2002 17:13:12 -0400
Date: Tue, 24 Sep 2002 17:10:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm2
In-Reply-To: <20020923071633.GA15479@suse.de>
Message-ID: <Pine.LNX.3.96.1020924170725.19732C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Jens Axboe wrote:

> Ah interesting. I do still think that it is worth to investigate _why_
> both elevator_linus and deadline does not prevent the read starvation.
> The read-latency is a hack, not a solution imo.
> 
> >  tagged command queueing on scsi - it appears to be quite stupidly
> >  implemented.
> 
> Ahem I think you are being excessively harsh, or maybe passing judgement
> on something you haven't even looked at. Did you consider that you
> _drive_ may be the broken component? Excessive turn-around times for
> request when using deep tcq is not unusual, by far.

I do think that's what he meant!  I think most drives are optimized this
way, and performance would be better if the kernel used the queueing more
sparingly, so the drive couldn't just run with the writes and let the
reads take the leftovers. 

I think that's a better long run solution, although the fix addresses the
immediate problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

