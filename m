Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSK0IZs>; Wed, 27 Nov 2002 03:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSK0IZs>; Wed, 27 Nov 2002 03:25:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25508 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261661AbSK0IZq>;
	Wed, 27 Nov 2002 03:25:46 -0500
Date: Wed, 27 Nov 2002 09:29:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
Message-ID: <20021127082931.GD19903@suse.de>
References: <200211262203.20088.harisri@bigpond.com> <3DE3D1D1.BE5B30ED@digeo.com> <15843.54741.609413.371274@notabene.cse.unsw.edu.au> <200211271912.05131.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211271912.05131.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27 2002, Srihari Vijayaraghavan wrote:
> Hello Neil,
> 
> On Wednesday 27 November 2002 07:13, Neil Brown wrote:
> > Srihari, could you possibly try with the following patch please to see
> > if it gives more useful information.
> 
> No worries. That did the trick.
> 
> The following message appears just before the first oops:
> Nov 27 18:56:32 localhost kernel: bio_add_page: want to add 4096 at 17658 but 
> only allowed 3072 - prepare to oops...

Neil, this is the problem. Currently a driver _must_ be able to accept a
page worth of data at any location...

-- 
Jens Axboe

