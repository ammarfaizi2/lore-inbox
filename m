Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136720AbRASCK7>; Thu, 18 Jan 2001 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136779AbRASCKj>; Thu, 18 Jan 2001 21:10:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15887 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136720AbRASCKS>;
	Thu, 18 Jan 2001 21:10:18 -0500
Date: Fri, 19 Jan 2001 03:10:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119031004.B18452@suse.de>
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva> <20010119011629.C32087@athlon.random> <20010119024023.B18209@suse.de> <20010119024610.A7573@gruyere.muc.suse.de> <20010119024745.G18209@suse.de> <20010119030825.A8011@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010119030825.A8011@gruyere.muc.suse.de>; from ak@suse.de on Fri, Jan 19, 2001 at 03:08:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19 2001, Andi Kleen wrote:
> Shouldn't it more depend on the bandwidth/latency of the IO device? 

Not really they should just make sure that we don't lock down
all buffers. The low water mark is just to make sure we don't
wake up readers/writers right after having blocked them.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
