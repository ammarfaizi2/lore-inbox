Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282258AbRK2HGN>; Thu, 29 Nov 2001 02:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282376AbRK2HFy>; Thu, 29 Nov 2001 02:05:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3333 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282258AbRK2HFu>;
	Thu, 29 Nov 2001 02:05:50 -0500
Date: Thu, 29 Nov 2001 08:05:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: rwhron@earthlink.net, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
Message-ID: <20011129080522.C5788@suse.de>
In-Reply-To: <20011129004851.A113@earthlink.net> <Pine.GSO.4.21.0111290050250.9516-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111290050250.9516-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Alexander Viro wrote:
> 
> 
> On Thu, 29 Nov 2001 rwhron@earthlink.net wrote:
> 
> > On Thu, Nov 29, 2001 at 12:18:59AM -0500, rwhron@earthlink.net wrote:
> > > > 	c) 2.5.1-pre3 + fs/super.c from 2.5.1-pre2
> > > > (fs/super.c changes are independent from everything else).
> > > 
> > > I'll try option c and let you know what happens.
> > 
> > I ran the fsync02 test by itself, and that went fine.  When I started
> > the "runalltests", the system locked up when "tail -f" showed fsync02.
> > It's possible that one of the next tests, fsync03 or ftruncate01 are 
> > the actual triggers for the "can't write" lockup.
> 
> OK, so what we have is breakage in bio parts merged in -pre3 _or_ breakage
> going back to -pre2.  If you could rerun these tests for vanilla 2.5.1-pre2
> and see if they break...

-pre3 breakage is very possible, let me drink a cup of coffee and take a
closer look at this.

-- 
Jens Axboe

