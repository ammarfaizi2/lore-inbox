Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSLOSSb>; Sun, 15 Dec 2002 13:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSLOSSb>; Sun, 15 Dec 2002 13:18:31 -0500
Received: from ping.ovh.net ([213.186.33.13]:64011 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id <S262258AbSLOSSa>;
	Sun, 15 Dec 2002 13:18:30 -0500
Date: Sun, 15 Dec 2002 19:26:45 +0100
From: Octave <oles@ovh.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: problem with Andrew's patch ext3
Message-ID: <20021215182645.GS23211@ovh.net>
References: <20021215144050.GY12395@ovh.net> <3DFCC815.3C0010F2@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFCC815.3C0010F2@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 10:21:09AM -0800, Andrew Morton wrote:
> Octave wrote:
> > 
> > Hello Andrew,
> > 
> > I patched 2.4.20 with your patch found out on http://lwn.net/Articles/17447/
> > and I have a big problem with:
> > once server is booted on 2.4.20 with your patch, when I want to reboot
> > with /sbin/reboot, server makes a Segmentation fault and it crashs.
> 
> It works OK here.  Could you please check that the kernel was fully
> rebuilt?  Do a `make clean'?  If the kernel was not fully rebuilt
> then things will go wrong because a structure size was changed.

yes, since I took a new tar.gz
made dep && make clean && make bzImage
I did it 5 times (for differents servers).

Octave

> 
> There is a locking error in that patch, and it needs revision.  But
> that wouldn't explain this crash.
> 
> And there is an unrelated use-after-free bug which could cause problems
> if the fs runs out of space or inodes.
> 
> I'll get some fixes out later today.  It hasn't been a good week.
