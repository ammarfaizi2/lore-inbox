Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRHSEC5>; Sun, 19 Aug 2001 00:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269970AbRHSECq>; Sun, 19 Aug 2001 00:02:46 -0400
Received: from altus.drgw.net ([209.234.73.40]:26123 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S269967AbRHSECi>;
	Sun, 19 Aug 2001 00:02:38 -0400
Date: Sat, 18 Aug 2001 23:02:49 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010818230249.O22585@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.33.0108101557180.1048-100000@penguin.transmeta.com> <20010811095051.A28624@gondor.apana.org.au> <20010810170407.G28914@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010810170407.G28914@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Fri, Aug 10, 2001 at 05:04:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 05:04:07PM -0700, Mike Fedyk wrote:
> On Sat, Aug 11, 2001 at 09:50:51AM +1000, Herbert Xu wrote:
> > On Fri, Aug 10, 2001 at 03:58:02PM -0700, Linus Torvalds wrote:
> > > 
> > > Besides, does the reboot system call actually get the BKL? I don't think
> > > it should need it..
> > 
> > Actually, the machine in question turned out to be UP :)
> > 
> > However, it does have RAID 1 and the notifier call chain stuff looks like
> > a killer to me since it leads to do_md_stop.
> > 
> > Perhaps we need a RESTART3 that restarts without notifying?
> 
> Interesting...
> 
> I have an oldworld ppc mac with RAID1 compiled on 2.2.19, and a bad floppy
> made badblocks unkillable.

I think that was probably because the pmac floppy driver has some issues..


-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
