Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129701AbRCCTmT>; Sat, 3 Mar 2001 14:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCCTmJ>; Sat, 3 Mar 2001 14:42:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53241 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129701AbRCCTl7>;
	Sat, 3 Mar 2001 14:41:59 -0500
Date: Sat, 3 Mar 2001 14:41:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: agrawal@ais.org, linux-kernel@vger.kernel.org
Subject: Re: lingering loopback bugs?
In-Reply-To: <20010303202458.L2528@suse.de>
Message-ID: <Pine.GSO.4.21.0103031438520.19484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Mar 2001, Jens Axboe wrote:

> On Sat, Mar 03 2001, agrawal@ais.org wrote:
> > 
> > I have an encrypted filesystem mounted over loopback that I created under
> > a 2.2.16 kernel. (Using AES, 128 bit key.) Works fine in 2.2.16. Sort of
> > works under the unpatched 2.4 series. (Mounts okay, but hangs the system
> > on random blocks.)
> > 
> > Under various 2.4 kernels with Jens' patched, the filesystem fails to
> > mount. I've tried 2.4.2-loop6, 2.4.2-ac6, and 2.4.2-ac8. All give the same
> > result. 
> 
> Look for the patch I posted yesterday (hint: just remove these two
> lines from loop_end_io_transfer)
> 
>                if (atomic_dec_and_test(&lo->lo_pending))
>                        up(&lo->lo_bh_mutex);

Uhh... And what will compensate for atomic_inc() in loop_make_request() in
case of loop over block device?
							Cheers,
								Al

