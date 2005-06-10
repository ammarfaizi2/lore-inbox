Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVFJHWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVFJHWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVFJHWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:22:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17574 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262505AbVFJHUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:20:39 -0400
Date: Fri, 10 Jun 2005 09:21:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Real-time problem due to IO congestion.
Message-ID: <20050610072130.GC29591@suse.de>
References: <42A91D36.8090506@lab.ntt.co.jp> <20050609234231.42a10763.akpm@osdl.org> <42A93D85.4060005@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A93D85.4060005@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please don't top post)

On Fri, Jun 10 2005, Takashi Ikebe wrote:
> 
> I see.
> The program which I tested is just sample, and I wanted to know the 
> phenomena is spec or bug.
> I also understand that this problem is spec, and need to apply some 
> buffering to such applications.

Additionally, following up on Andrew, even with prioritized request
allocations you could get equally long stuck if you just had lots of
high prio allocaters queueing io. So rethinking the setup is definitely
good advice.

-- 
Jens Axboe

