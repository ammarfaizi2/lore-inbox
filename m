Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130082AbRBZAxf>; Sun, 25 Feb 2001 19:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRBZAx0>; Sun, 25 Feb 2001 19:53:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47016 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130082AbRBZAxF>;
	Sun, 25 Feb 2001 19:53:05 -0500
Date: Sun, 25 Feb 2001 19:53:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <20010226014827.Z7830@suse.de>
Message-ID: <Pine.GSO.4.21.0102251949390.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001, Jens Axboe wrote:

> On Sun, Feb 25 2001, Alexander Viro wrote:
> > Let me elaborate: the race is very narrow and takes deliberate efforts to
> > hit. It _can_ be triggered, unfortunately. This extra up() will mess your
> > life later on.
> 
> What's the worst that can happen? We do an extra up, but loop_thread
> will still quit once we hit zero lo_pending. And loop_clr_fd
> is still protected by lo_ctl_mutex.

Well, for one thing you'll get some surprises next time you losetup
the same device ;-) There are more subtle scenarios, but that one
is pretty unpleasant in itself.
						Cheers,
							Al

