Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130094AbRBZAzf>; Sun, 25 Feb 2001 19:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130091AbRBZAzZ>; Sun, 25 Feb 2001 19:55:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26382 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130089AbRBZAzK>;
	Sun, 25 Feb 2001 19:55:10 -0500
Date: Mon, 26 Feb 2001 01:54:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
Message-ID: <20010226015456.A7830@suse.de>
In-Reply-To: <20010226014827.Z7830@suse.de> <Pine.GSO.4.21.0102251949390.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0102251949390.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 07:53:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Alexander Viro wrote:
> > What's the worst that can happen? We do an extra up, but loop_thread
> > will still quit once we hit zero lo_pending. And loop_clr_fd
> > is still protected by lo_ctl_mutex.
> 
> Well, for one thing you'll get some surprises next time you losetup
> the same device ;-) There are more subtle scenarios, but that one
> is pretty unpleasant in itself.

Ah ok, but that could be solved by just reiniting the sems on
each losetup (which probably would be a good idea anyway). But
ok, I'll shut up now :-)

-- 
Jens Axboe

