Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSLAXm2>; Sun, 1 Dec 2002 18:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSLAXm2>; Sun, 1 Dec 2002 18:42:28 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63136 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262859AbSLAXm2>; Sun, 1 Dec 2002 18:42:28 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Mon, 2 Dec 2002 10:49:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15850.40983.669484.665564@notabene.cse.unsw.edu.au>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
In-Reply-To: message from Jens Axboe on Wednesday November 27
References: <200211262203.20088.harisri@bigpond.com>
	<3DE3D1D1.BE5B30ED@digeo.com>
	<15843.54741.609413.371274@notabene.cse.unsw.edu.au>
	<200211271912.05131.harisri@bigpond.com>
	<20021127082931.GD19903@suse.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 27, axboe@suse.de wrote:
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

so raid0 (and linear) need to be able to split a bio .... I think
we've been here before.  Did you say you have plans for some generic
helper code that could do this?

NeilBrown
