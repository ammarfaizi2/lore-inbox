Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRBZAtF>; Sun, 25 Feb 2001 19:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130081AbRBZAs4>; Sun, 25 Feb 2001 19:48:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23822 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130072AbRBZAsp>;
	Sun, 25 Feb 2001 19:48:45 -0500
Date: Mon, 26 Feb 2001 01:48:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
Message-ID: <20010226014827.Z7830@suse.de>
In-Reply-To: <Pine.GSO.4.21.0102251935120.26808-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0102251939230.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0102251939230.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 07:40:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Alexander Viro wrote:
> Let me elaborate: the race is very narrow and takes deliberate efforts to
> hit. It _can_ be triggered, unfortunately. This extra up() will mess your
> life later on.

What's the worst that can happen? We do an extra up, but loop_thread
will still quit once we hit zero lo_pending. And loop_clr_fd
is still protected by lo_ctl_mutex.

-- 
Jens Axboe

