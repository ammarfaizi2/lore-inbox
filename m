Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTFHVhH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 17:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTFHVhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 17:37:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:49424 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263930AbTFHVhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 17:37:05 -0400
Date: Sun, 8 Jun 2003 23:47:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Clayton Weaver <cgweav@email.com>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7
Message-ID: <20030608214711.GA4584@alpha.home.local>
References: <20030608201700.3850.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608201700.3850.qmail@email.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Note that "nodma" is unnecessary on this
> same box running kernel 2.4.19-rc2. Why would
> 2.4.21-rcX need it? To pin down whether the
> problem is in the ide dma code or some other
> part of the ide code?

exactly, because DMA needs more conditions than PIO to run at all
and even more to run reliably. There are lots of cases where DMA
doesn't work while PIO does.
 
> It does not die more easily with 2.4.19-rc2
> (in my opinion). It dies in a threads context
> but not in a forks context, where the threads
> and the forks are doing the same i/o to/from
> the same controller/disk (different versions
> of same program).
>
> I have also seen it freeze with an unlucky
> mouse click in XFree86 4.0 under 2.4.19-rc2,
> so I did not assume that the threads hang
> was necessarily ide-relevant. Something
> disk i/o intensive was merely what it
> happened to be doing with those threads,
> but that problem seemed to me more thread
> related than ide related. (Guess I'll have
> to spawn a bunch of threads doing some other
> kind of i/o to test that assumption.)

OK, but a freeze isn't acceptable anyway, whatever you were doing,
because it always means a bug somewhere.

Cheers,
Willy

PS: your lines were shorter this way :-)

