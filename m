Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268672AbRGZUFR>; Thu, 26 Jul 2001 16:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268675AbRGZUFH>; Thu, 26 Jul 2001 16:05:07 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:30910 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268672AbRGZUE7>; Thu, 26 Jul 2001 16:04:59 -0400
Date: Thu, 26 Jul 2001 16:04:13 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <Pine.LNX.4.33.0107261233000.1062-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107261554020.19887-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Linus Torvalds wrote:

> > 	1) Does fsync() of a directory work on most/all current FS?
>
> Modulo bugs, yes.

Great, that was a big concern

> Now, there's another issue, of course: if you have an important mail-spool
> on some of the less tested filesystems, I would consider you crazy
> regardless of fsync() working ;). I don't think anybody has ever verified
> that fsync() (or much anything else wrt writing) does the right thing on
> NTFS, for example.

Caveat Emptor ;-)

> > 	2) Does it work on 2.2.x as well as 2.4.x?
>
> Yes. However, there may be performance issues. As with just about
> anything, we didn't start optimizing things until it became a real issue,
> and in some cases at least historically the filesystems fell back on just
> doing a whole "fsync_dev()" if they had nothing better to do.
>
> I think later 2.2.x kernels (ie the ones past the point where Alan took
> over) probably have the fsync() optimizations at least for ext2.

That should be recent enough - I push 2.2.19 for shm support and security
reasons anyway - though I see alot of folk on 2.2.16/17.

Are the optimizations more than writing out only changed blocks?
Has anyone any information on the performance differences between
optimized vs non-optimized?

Thanks, I'm feeling much better about getting this support added
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

