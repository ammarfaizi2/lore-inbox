Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSK0Iai>; Wed, 27 Nov 2002 03:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSK0Iai>; Wed, 27 Nov 2002 03:30:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:14504 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261742AbSK0Iah>;
	Wed, 27 Nov 2002 03:30:37 -0500
Message-ID: <3DE4845D.65817070@digeo.com>
Date: Wed, 27 Nov 2002 00:37:49 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Srihari Vijayaraghavan <harisri@bigpond.com>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
References: <200211262203.20088.harisri@bigpond.com> <3DE3D1D1.BE5B30ED@digeo.com> <15843.54741.609413.371274@notabene.cse.unsw.edu.au> <200211271912.05131.harisri@bigpond.com> <20021127082931.GD19903@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2002 08:37:50.0125 (UTC) FILETIME=[44F2D5D0:01C295F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Wed, Nov 27 2002, Srihari Vijayaraghavan wrote:
> > Hello Neil,
> >
> > On Wednesday 27 November 2002 07:13, Neil Brown wrote:
> > > Srihari, could you possibly try with the following patch please to see
> > > if it gives more useful information.
> >
> > No worries. That did the trick.
> >
> > The following message appears just before the first oops:
> > Nov 27 18:56:32 localhost kernel: bio_add_page: want to add 4096 at 17658 but
> > only allowed 3072 - prepare to oops...
> 
> Neil, this is the problem. Currently a driver _must_ be able to accept a
> page worth of data at any location...

Even if pages are 64kbytes?
