Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbSJ1Lfl>; Mon, 28 Oct 2002 06:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbSJ1Lfl>; Mon, 28 Oct 2002 06:35:41 -0500
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:388 "EHLO giantx.co.uk")
	by vger.kernel.org with ESMTP id <S263289AbSJ1Lfk>;
	Mon, 28 Oct 2002 06:35:40 -0500
Date: Mon, 28 Oct 2002 11:41:52 +0000
From: Nyk Tarr <nyk@giantx.co.uk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44-ac4 scsi CDROMEJECT problem
Message-ID: <20021028114152.GA20372@giantx.co.uk>
References: <20021027223138.GA601@giantx.co.uk> <20021028081507.GD30429@suse.de> <20021028105433.GA18585@giantx.co.uk> <20021028105754.GB844@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028105754.GB844@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:57:54AM +0100, Jens Axboe wrote:
> On Mon, Oct 28 2002, Nyk Tarr wrote:
> > On Mon, Oct 28, 2002 at 09:15:07AM +0100, Jens Axboe wrote:
> > > On Sun, Oct 27 2002, Nyk Tarr wrote:
> > > > Hi
> > > > 
> > > > This patch of Jens Axboe was missing from 2.5.44-ac4. Was this by design
> > > > or accidental?
> > > 
> > > Please check blk_do_rq(), it sets rq_dev and rq_disk. So it's indeed
> > > intentional. Since you ask, do you have problems ejecting?
> > 
> > Yup.
> > 
> > I can only see rq -> rq_dev being set in sg_io(), but then again, you
> > could write the amount of C I know on a small postage stamp. ^_^
> > 
> > recompiled with the two assignments in under CDROMEJECT it works fine.
> 
> I just checked the -ac4 patch, and bits are indeed missing. The
> recommended patch against -ac4 is:
> 
[snip]
> 
> I think Alan dropped this last bit (or maybe it didn't apply for him,
> dunno), at least I know it was sent.

Applies clean here. I'll try it later.

Thanks.
Nyk
-- 
/__
\_|\/
   /\
