Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285497AbRLNUk2>; Fri, 14 Dec 2001 15:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbRLNUkT>; Fri, 14 Dec 2001 15:40:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34576 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285497AbRLNUkJ>;
	Fri, 14 Dec 2001 15:40:09 -0500
Date: Fri, 14 Dec 2001 21:34:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Kirk Alexander <kirkalx@yahoo.co.nz>
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20011214203435.GV1180@suse.de>
In-Reply-To: <20011214041151.91557.qmail@web14904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011214041151.91557.qmail@web14904.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Kirk Alexander wrote:
> [cc'ed to lkml and Gerard Roudier]
> 
> Hi Jens,
> 
> You asked people to send in reports of which drivers
> were broken by the removal of io_request_lock.
> 
> My system is a clunky old Digital Pentium Pro with a
> NCR53c810 rev 2 scsi controller, so it can't use the
> sym driver. I fixed the problem by seeing what the sym
> driver did i.e. the patch below 
> This may not be right at all, and I haven't had a
> chance to boot the kernel - but it did build OK.

Missed your original post, it had no subject line. At first view, your
patch looks correct. However, check the ->detect() routing and verify
it's not assuming the lock is held there. That should be the only
pitfall.

Minor nit pick -- since this driver is _in_ the 2.5 tree, there's no way
the #ifdef would not hit. So the way I've been fixing these is to just
always assume latest kernel.

I think this was already fixed though, but at least know you now you did
it right :-)

-- 
Jens Axboe

