Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310842AbSCHNFP>; Fri, 8 Mar 2002 08:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310850AbSCHNFF>; Fri, 8 Mar 2002 08:05:05 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:63619 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310842AbSCHNE6>; Fri, 8 Mar 2002 08:04:58 -0500
Date: Fri, 8 Mar 2002 14:50:04 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <3C88B35C.20202@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203081443360.5383-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok cool, regarding the ide-cd current problem, i still don't see how 
moving it to a BH would help in this case, the only difference i can see 
is that the ISR won't have to be so heavy and we can get more interrupt 
handling done (assuming the BH processing keeps up). The problem isn't 
that the read_intr is preempting other code and injecting already active 
requests into the queue, but that ide-cd is allowing running requests to 
be sent multiple times.

If you can just explain marginally a  possible workaround other than the 
kludge i diffed up i can try investigating further.

Thanks,
	Zwane

