Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTFHJhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 05:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFHJhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 05:37:02 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:65292 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261280AbTFHJhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 05:37:00 -0400
Date: Sun, 8 Jun 2003 11:47:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7
Message-ID: <20030608094729.GA29484@alpha.home.local>
References: <20030608085448.31378.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608085448.31378.qmail@email.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

[ first, please fix your mailer and cut your lines, it's not easy to quote you in replies ]

On Sun, Jun 08, 2003 at 03:54:48AM -0500, Clayton Weaver wrote:
> > Now I really hope its the last one, all this
> > rc's are making me mad.
> 
> We still have ide problems, and I don't see any
> potential fixes for that in the changelog between -rc6 and -rc7.
> 
> I tried -rc6 on a whim and had hda report
> a timeout (dma, I think, but the message went by kind of quick), then the big freeze with the
> disk light stuck on,  Never happened in 6 months on the same hardware running
> 2.4.19-rc2 (with glibc-2.2.5, gcc-2.95.3, binutils-2.12.90.0.9, all ext2 filesystems).

Did you try with "ide0=nodma", or other similar options ?

> SiS530/5513, k6-II/450, udma33 Maxtor drive that 2.4.19-rc2 has no problems with.

That's not exactly what you said below. You said that you could reliably kill it with 32 threads...
Perhaps you have a broken hardware, and 2.4.21 stresses it more than 2.4.19-rc2. Perhaps it's
really an old driver bug, then having reported it since this you encountered it would have been
more constructive than telling us at 2.4.21 time that it dies even more easily than a one year old
2.4.19-rc2.

> You can release a 2.4.21 anyway, of course, but without finding out where the ide livelock (and other big freezes, thinking of the report on the all-scsi system already posted) originates, calling it "stable" would be a bit fanciful.

That's what -pre and -rc are for : bug reports. The ide code has been included in 2.4.21-pre1,
several months ago. There's always a risk of breaking someone's setup, but obviously, if people
don't try pre-releases and don't report problems in time, how could they hope to get a stable
kernel on their hardware ?

> Not what you wanted to hear, right? Oh well.
> 
> (Better to find out sooner than release
> 2.4.21-stable and watch 52 different bug reports on it arrive at the list the next day.)

Well, look through the archives, there have been two patches by Lionel Bouton and Vojtech Pavlik
posted in May for the 5513 driver, to support newer chipsets. I don't know if they have been
included, nor if they also fixed old bugs. Perhaps you'll be intersted in checking them.

BTW, someone reported yesterday that his 5513 worked flawlessly in 2.4.20, but behaved like yours
on 2.5.70. Have you tested 2.4.20, or better, have you tried to narrow the problem down to a
particular version (but I bet it will be tied to the introduction of the newer IDE code).

You may also try -ac kernels which have more recent, but less tested code.

Regards,
Willy

