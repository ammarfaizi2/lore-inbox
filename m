Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282391AbRK2Gua>; Thu, 29 Nov 2001 01:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282398AbRK2GuU>; Thu, 29 Nov 2001 01:50:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2178 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282378AbRK2GuH>;
	Thu, 29 Nov 2001 01:50:07 -0500
Date: Thu, 29 Nov 2001 01:04:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: rwhron@earthlink.net
cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
In-Reply-To: <20011129004851.A113@earthlink.net>
Message-ID: <Pine.GSO.4.21.0111290050250.9516-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Nov 2001 rwhron@earthlink.net wrote:

> On Thu, Nov 29, 2001 at 12:18:59AM -0500, rwhron@earthlink.net wrote:
> > > 	c) 2.5.1-pre3 + fs/super.c from 2.5.1-pre2
> > > (fs/super.c changes are independent from everything else).
> > 
> > I'll try option c and let you know what happens.
> 
> I ran the fsync02 test by itself, and that went fine.  When I started
> the "runalltests", the system locked up when "tail -f" showed fsync02.
> It's possible that one of the next tests, fsync03 or ftruncate01 are 
> the actual triggers for the "can't write" lockup.

OK, so what we have is breakage in bio parts merged in -pre3 _or_ breakage
going back to -pre2.  If you could rerun these tests for vanilla 2.5.1-pre2
and see if they break...

