Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273047AbRIOUvX>; Sat, 15 Sep 2001 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273040AbRIOUvE>; Sat, 15 Sep 2001 16:51:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19450
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273046AbRIOUvA>; Sat, 15 Sep 2001 16:51:00 -0400
Date: Sat, 15 Sep 2001 13:51:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
Message-ID: <20010915135118.A24067@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu> <20010915083236.A9271@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010915083236.A9271@bessie.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2001 at 08:32:36AM -0400, jlnance@intrex.net wrote:
> On Fri, Sep 14, 2001 at 03:01:26PM -0400, Alexander Viro wrote:
> 
> > convenient when you are doing fs hacking ;-)  Actually I've got into
> > a habit of using that instead of normal umount in all cases except
> > the shutdown scripts - works just fine (for obvious reasons in case
> > of shutdown non-lazy behaviour is precisely what we want).
> 
> Why not shutdown?  This is the place I think it would help me the most.
> 
> Thanks,
> 
> Jim

If you have a FS with a process stuck in D state, and you shutdown with an
umount that *always* does lazy unmounting you get the same affect, because
you'd want the kernel to pause the shutdown until the FS was properly
unmounted.

Either way, you'd have a system you can't reboot without hardware reset if
you have a process stuck in D state on a rw FS.

I have a system with badblocks and shutdown stuck in D state.  Kernel is
2.2.19 on PPC with the freeswan1.9 patch.

It has been stuck for about two weeks, but operating normally otherwise.
I'm going to have to sync; sync; and power off, as I need to update the
kernel anyway.

I too would like to see a way to force umount, but I don't see a safe way.
OTOH, I'm also not a kernel hacker.  Does anyone see a solution?

Mike
