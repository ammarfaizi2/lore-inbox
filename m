Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSIBUiZ>; Mon, 2 Sep 2002 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSIBUiZ>; Mon, 2 Sep 2002 16:38:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38661 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317334AbSIBUiY>; Mon, 2 Sep 2002 16:38:24 -0400
Date: Mon, 2 Sep 2002 13:50:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andries.Brouwer@cwi.nl, <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <20020902203525.GB9328@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209021347270.1385-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2 Sep 2002, Andries Brouwer wrote:
> 
> Now it seems Al is doing all the work, so I can just sit back and watch.
> But I hope he makes precisely this: a kernel that does not do any
> partition reading of its own.

I disagree, if only because of backwards competibility issues.

On a conceptual level I think you're right. However, it will break too 
many standard installations as is.

If/when we have a reasonable initrd setup that is usable, we could do some 
automatic partitioning of devices that are available at bootup to minimize 
the impact, but I don't think it is realistic otherwise.

		Linus

