Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267950AbRHATLN>; Wed, 1 Aug 2001 15:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267974AbRHATLC>; Wed, 1 Aug 2001 15:11:02 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:22241 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S267950AbRHATKt>; Wed, 1 Aug 2001 15:10:49 -0400
Date: Wed, 1 Aug 2001 15:25:29 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disk quotas not staying in sync?
In-Reply-To: <200108011806.f71I6Ht1006946@webber.adilger.int>
Message-ID: <Pine.LNX.4.31.0108011514410.4569-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Andreas Dilger wrote:

> Maybe the problem is caused by root/admin deleting another users files?

I thought of that first.  But the techs that were deleting mail were
actually `su`ing to the user and using pine to delete the messages.  So I
was wondering if pine was doing something strange.  But since we use
Maildirs when I was cleaning up an account I just `rm`ed their e-mails and
still ended up seeing the same problem.

> Do you run quotacheck at boot time?  It is possible with ext2 that the
> on-disk quotas are not in sync with the actual files if there is a crash.
> If you use ext3 then the quota updates and other filesystem updates are
> kept atomic.

I have run quotacheck once at boot to see if it would help.  It got the
stuff in sync for a little while, but soon I started to see the same
problem again.  quotacheck on a cold cache takes a LONG time to run.

So when is ext3 going in the kernel?  (ducks)  But really that is
something I will look at.

> > Any ideas?  This machine is pretty much standard.  ext2 file systems on
> > all partitions.  /home is the only one with user disk quotas.  Running
> > 2.4.7 kernel (but I've seen it in all 2.4 kernels, I was running
> > 2.4.0-prerelease on the machine when I first put it up, so I don't know
> > how 2.2 works).

One thing I forgot to mention about the machine, it is an SMP PIII box.  I
was really meaning to say it was SMP cause that might be something to look
at.

> You should also try the -ac kernels.  I'm pretty sure that they have
> some fixes to the quota code.  However, I _think_ the changes are not
> compatible with the non-ac kernel quota on-disk data, so you will have
> to re-build the quota files (a small price to pay if it actually works).

Yeah, when I was first putting this machine together I recall seeing there
was a new version of the quota utils and patches for the kernel to go with
them.  And yes, the on disk data is different, that is if those are the
patches Alan has in his kernel.

Do you know if the ext3 patches play well with the -ac kernels?  Might as
well try shooting myself in both feet while I'm at it.

> Cheers, Andreas

Thanks again,
Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

