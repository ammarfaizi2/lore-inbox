Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSLBIRI>; Mon, 2 Dec 2002 03:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSLBIRI>; Mon, 2 Dec 2002 03:17:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265677AbSLBIRH>;
	Mon, 2 Dec 2002 03:17:07 -0500
Date: Mon, 2 Dec 2002 09:24:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
Message-ID: <20021202082416.GT16942@suse.de>
References: <200211262203.20088.harisri@bigpond.com> <3DE3D1D1.BE5B30ED@digeo.com> <15843.54741.609413.371274@notabene.cse.unsw.edu.au> <200211271912.05131.harisri@bigpond.com> <20021127082931.GD19903@suse.de> <15850.40983.669484.665564@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15850.40983.669484.665564@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02 2002, Neil Brown wrote:
> On Wednesday November 27, axboe@suse.de wrote:
> > On Wed, Nov 27 2002, Srihari Vijayaraghavan wrote:
> > > Hello Neil,
> > > 
> > > On Wednesday 27 November 2002 07:13, Neil Brown wrote:
> > > > Srihari, could you possibly try with the following patch please to see
> > > > if it gives more useful information.
> > > 
> > > No worries. That did the trick.
> > > 
> > > The following message appears just before the first oops:
> > > Nov 27 18:56:32 localhost kernel: bio_add_page: want to add 4096 at 17658 but 
> > > only allowed 3072 - prepare to oops...
> > 
> > Neil, this is the problem. Currently a driver _must_ be able to accept a
> > page worth of data at any location...
> 
> so raid0 (and linear) need to be able to split a bio .... I think
> we've been here before.  Did you say you have plans for some generic
> helper code that could do this?

I'm afraid so... I'll come up with a splitter helper today/tomorrow.

-- 
Jens Axboe

