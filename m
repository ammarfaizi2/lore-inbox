Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVG2H0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVG2H0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVG2H0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:26:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57806 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262362AbVG2HZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:25:51 -0400
Date: Fri, 29 Jul 2005 09:27:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: io scheduler silly question perhaps..
Message-ID: <20050729072749.GD22569@suse.de>
References: <Pine.LNX.4.58.0507290130000.1030@skynet> <5c49b0ed0507281752b9485@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0507281752b9485@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28 2005, Nate Diller wrote:
> Try benchmarking Anticipatory or Deadline against Noop, preferably
> with your actual workload.  Noop is probably what you want, since
> there is not much use in avoiding large "seeks".  It could be though
> that request merging, which the non-noop schedulers all perform, willl
> cause Noop to lose.  I haven't tried any I/O scheduler benchmarks with
> flash, but perhaps we need a simple "merge only" scheduler for this
> sort of thing.
> 
> Let me know what the results are.

deadline is the appropriate choice, you could still have read starvation
issues with noop. anticipatory doesn't make any sense, as the device has
no seek penalty.

and hey, don't top post! now we lost daves original mail.

-- 
Jens Axboe

