Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSIWR7o>; Mon, 23 Sep 2002 13:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSIWR7o>; Mon, 23 Sep 2002 13:59:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55233 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261186AbSIWR7n>;
	Mon, 23 Sep 2002 13:59:43 -0400
Date: Mon, 23 Sep 2002 20:04:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Grega Fajdiga <Gregor.Fajdiga@telemach.net>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.38-mm2
Message-ID: <20020923180435.GF15479@suse.de>
References: <20020923153301.2c87768d.Gregor.Fajdiga@telemach.net> <3D8F48D9.1D8BE9D@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8F48D9.1D8BE9D@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23 2002, Andrew Morton wrote:
> Grega Fajdiga wrote:
> > 
> > Good day,
> > 
> > I get this oops at startup in 2.5.38-mm2. The oops
> 
> It's not an oops - it's just a warning.
> 
> > ..
> > Trace; c0117826 <__might_sleep+56/5d>
> > Trace; c0134386 <kmalloc+66/1f0>
> > Trace; c01d2e60 <ide_intr+0/1d0>
> 
> ide_intr() is calling sleeping functions inside ide_lock.

this is ludicris, why on earth would ide_intr() call kmalloc() from its
isr?! the trace is obviously bogus.

-- 
Jens Axboe

