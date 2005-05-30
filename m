Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVE3Gc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVE3Gc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVE3Gc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:32:27 -0400
Received: from brick.kernel.dk ([62.242.22.158]:18409 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261523AbVE3GcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:32:21 -0400
Date: Mon, 30 May 2005 08:33:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: "Eric D. Mudama" <edmudama@gmail.com>,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050530063322.GE7054@suse.de>
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org> <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de> <20050527145821.GX1435@suse.de> <87oeatxtw4.fsf@stark.xeocode.com> <311601c905052921046692cd3e@mail.gmail.com> <87d5r9xmgr.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5r9xmgr.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30 2005, Greg Stark wrote:
> > ATA has a limitation of 32 tags, so queued write cache off won't beat
> > unqueued write cache on in any modern drive.
> 
> People earlier were quoting 30-40% gains with NCQ enabled. I assumed
> those were with the same drive in otherwise the same configuration,
> presumably with write-caching enabled.

If you are talking about the numbers I quoted, those were for random
read performance.

> Without any form of command queueing write-caching imposes a severe
> performance loss, the question is how much of that loss is erased when
> NCQ is present.

I'll try some random write tests with write caching disabled.

> People actually tend to report that IDE drives are *faster*. Until
> they're told they have to disable write-caching on their IDE drives to
> get a fair comparison, then the performance is absolutely abysmal. The
> interesting thing is that SCSI drives don't seem to take much of a
> performance hit from having write-caching disabled while IDE drives
> do.

NCQ will surely lessen the impact of disabling write caching, how much
still remains to be seen. You could test, if you have the hardware :)
Real life testing is more interesting than benchmarks.

-- 
Jens Axboe

