Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270694AbRHKAEX>; Fri, 10 Aug 2001 20:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270696AbRHKAEN>; Fri, 10 Aug 2001 20:04:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33264
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S270695AbRHKAEC>; Fri, 10 Aug 2001 20:04:02 -0400
Date: Fri, 10 Aug 2001 17:04:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010810170407.G28914@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108101557180.1048-100000@penguin.transmeta.com> <20010811095051.A28624@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010811095051.A28624@gondor.apana.org.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 09:50:51AM +1000, Herbert Xu wrote:
> On Fri, Aug 10, 2001 at 03:58:02PM -0700, Linus Torvalds wrote:
> > 
> > Besides, does the reboot system call actually get the BKL? I don't think
> > it should need it..
> 
> Actually, the machine in question turned out to be UP :)
> 
> However, it does have RAID 1 and the notifier call chain stuff looks like
> a killer to me since it leads to do_md_stop.
> 
> Perhaps we need a RESTART3 that restarts without notifying?

Interesting...

I have an oldworld ppc mac with RAID1 compiled on 2.2.19, and a bad floppy
made badblocks unkillable.

Is there another way to kill that will work when kill -9 won't?
