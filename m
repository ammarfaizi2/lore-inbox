Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTE0TaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTE0TaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:30:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18309 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264095AbTE0TaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:30:07 -0400
Date: Tue, 27 May 2003 21:43:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527194322.GV845@suse.de>
References: <20030527065436.GX845@suse.de> <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, Linus Torvalds wrote:
> 
> On Tue, 27 May 2003, Jens Axboe wrote:
> > 
> > Here's something ridicolously simple, that just wont start a new tag if
> > the oldest tag is older than 100ms. Clearly nothing for submission, but
> > it gets the point across.
> 
> Yes, I think something like this should work very well.

Agree, it should take the edge of crappy hardware at least.

> In fact, it might fit in very well indeed with AS - and in general it
> might be a good idea to have some nice interface for the IO scheduler to
> give this kind of ordering hints down to the hardware.

And deadline, they share the same request expire mechanism. But I read
your hint, I'll add the hint and fix this for real. Was waiting for the
other tcq patch to be comitted as they overlap, but I see that is in
so...

-- 
Jens Axboe

