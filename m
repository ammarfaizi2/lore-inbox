Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132940AbRDEPzl>; Thu, 5 Apr 2001 11:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132941AbRDEPzc>; Thu, 5 Apr 2001 11:55:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50700 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132940AbRDEPzV>;
	Thu, 5 Apr 2001 11:55:21 -0400
Date: Thu, 5 Apr 2001 17:54:30 +0200
From: Jens Axboe <axboe@suse.de>
To: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
Cc: Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-lvm-patch@EZ-Darmstadt.Telekom.de
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405175430.E5187@suse.de>
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org> <20010405071313.A418@suse.de> <20010405163818.M418@suse.de> <20010405164942.N418@suse.de> <20010405163239.F6981@sistina.com> <20010405173731.C5187@suse.de> <20010405165211.H6981@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010405165211.H6981@sistina.com>; from Mauelshagen@Sistina.com on Thu, Apr 05, 2001 at 04:52:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05 2001, Heinz J. Mauelshagen wrote:
> > Where? Calling buffer_IO_error would be ok, but there are no such calls
> > in 2.4.3. I just stated elsewhere that submit_bh should probably be
> > clearing the dirty bit, not ll_rw_block, in which case the b_end_io
> > is fine. But buffer_IO_error is probably more clear. I trust you'll
> > take care of that part then.
> 
> Sorry, didn't mention that you need to patch the driver with the recent
> LVM software in order to get it.

Ah ok, so the b_dev/b_blocknr is all then. Good.

> I've send the patch a while ago to Linus to get it into 2.4.3
> but he obviously didn't include it (likely because he thought it was too
> large ;-)

Maybe you're hanging on to fixes and submitting huge chunks of them?

> He didn't comment back to me at all though :-(
> Maybe this will help.

Two things that usually help -- submit small and often, then resubmit,
resubmit, resubmit until he takes it or complains loudly :-)

-- 
Jens Axboe

