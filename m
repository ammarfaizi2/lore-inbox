Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132939AbRDEPxc>; Thu, 5 Apr 2001 11:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132940AbRDEPxV>; Thu, 5 Apr 2001 11:53:21 -0400
Received: from hermes.sistina.com ([208.210.145.141]:8202 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S132939AbRDEPxK>;
	Thu, 5 Apr 2001 11:53:10 -0400
Date: Thu, 5 Apr 2001 16:52:11 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>,
        Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-lvm-patch@EZ-Darmstadt.Telekom.de
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405165211.H6981@sistina.com>
Reply-To: Mauelshagen@Sistina.com
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org> <20010405071313.A418@suse.de> <20010405163818.M418@suse.de> <20010405164942.N418@suse.de> <20010405163239.F6981@sistina.com> <20010405173731.C5187@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010405173731.C5187@suse.de>; from axboe@suse.de on Thu, Apr 05, 2001 at 05:37:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 05:37:31PM +0200, Jens Axboe wrote:
> On Thu, Apr 05 2001, Heinz J. Mauelshagen wrote:
> > > Irks, another one. lvm_make_request_fn also needs to call b_end_io
> > > if a map fails.
> > 
> > This is wrong.
> > 
> > In case of an io error we do already call buffer_IO_error() on 2.4 in
> > lvm_map().
> 
> Where? Calling buffer_IO_error would be ok, but there are no such calls
> in 2.4.3. I just stated elsewhere that submit_bh should probably be
> clearing the dirty bit, not ll_rw_block, in which case the b_end_io
> is fine. But buffer_IO_error is probably more clear. I trust you'll
> take care of that part then.

Sorry, didn't mention that you need to patch the driver with the recent
LVM software in order to get it.

I've send the patch a while ago to Linus to get it into 2.4.3
but he obviously didn't include it (likely because he thought it was too
large ;-)

He didn't comment back to me at all though :-(
Maybe this will help.

Linus?

> 
> -- 
> Jens Axboe
> 

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
