Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTKFNNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTKFNNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:13:32 -0500
Received: from ns.suse.de ([195.135.220.2]:6333 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263561AbTKFNNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:13:30 -0500
Date: Thu, 6 Nov 2003 14:11:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031106131141.GE1145@suse.de>
References: <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de> <3FA945DD.8030105@gmx.de> <20031106091746.GA1379@suse.de> <3FAA41C3.9060601@gmx.de> <3FAA45A9.20707@cyberone.com.au> <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAA4880.8090600@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
> >On Fri, Nov 07 2003, Nick Piggin wrote:
> >
> >>
> >>Jens Axboe wrote:
> >>
> >>
> >>>sys time is usually pretty high if that is the case, and it's hovering
> >>>around 5% here... Prakash, are you sure that dma is enabled on the
> >>>drive? When you see the problem, do a vmstat 1 for 10 seconds so you are
> >>>absolutely sure you are sending the info from when the problem occurs.
> >>>
> >>>
> >>Although have a look at the interrupts field in vmstat 1255, 725, 736 ...
> >>
> >
> >Yeah that is pretty high for just doing a burn, maybe something else is
> >
> 
> ;) you are forgetting 2.6 should give 1000 timer interrupts per second!

Heh indeed, maybe because the archs I use are still at 100. Looks
suspiciously like it's loosing timer interrupts, which would indeed
point to PIO.

-- 
Jens Axboe

