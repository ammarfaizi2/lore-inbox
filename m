Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284164AbRLROoH>; Tue, 18 Dec 2001 09:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284187AbRLROn5>; Tue, 18 Dec 2001 09:43:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50705 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284164AbRLROnw>;
	Tue, 18 Dec 2001 09:43:52 -0500
Date: Tue, 18 Dec 2001 15:43:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Krahn <jkrahn@nc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Common removable media interface?
Message-ID: <20011218154338.D32511@suse.de>
In-Reply-To: <3C1F41D6.43A16F80@nc.rr.com> <20011218142002.C32511@suse.de> <3C1F47D4.8964A190@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1F47D4.8964A190@nc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18 2001, Joe Krahn wrote:
> Jens Axboe wrote:
> > 
> > On Tue, Dec 18 2001, Joe Krahn wrote:
> > > I think Linux could use a common removable
> > > media interface, sort of like cdrom.c adds
> ...
> > 
> > Stuff like this belongs in user space, no need to bloat the kernel with
> > it.
> > 
> > --
> > Jens Axboe
> OK, you are right. Bloat is bad. So,
> would you say that new drivers should keep ioctls
> to a bare minimum, much less than cdrom.c, and just
> provide generic access, like SG_IO/HDIO_DRIVE_CMD,
> as a general rule from now on?
> (Sounds OK to me...)

That's exactly what I'm saying, in fact that's the direction that 2.5 is
heading currently (rq->cmd[]). _One_ packet ioctl for your atapi or scsi
removables, done.

-- 
Jens Axboe

