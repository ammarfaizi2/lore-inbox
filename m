Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUABN5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbUABN5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:57:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8835 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265578AbUABN4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:56:52 -0500
Date: Fri, 2 Jan 2004 14:56:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Christophe Saout <christophe@saout.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Move bv_offset/bv_len update after bio_endio in __end_that_request_first
Message-ID: <20040102135645.GA20572@suse.de>
References: <20040101173214.GA4496@leto.cs.pocnet.net> <20040102104637.GN5523@suse.de> <1073048438.4239.10.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073048438.4239.10.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Christophe Saout wrote:
> Am Fr, den 02.01.2004 schrieb Jens Axboe um 11:46:
> 
> > > That's why I need to know exactly how many and which  bvecs were completed
> > > in my bi_end_io function.
> > > 
> > > Or do you think it is safer to count backwards using bi_vcnt and bi_size?
> > 
> > I'm inclined to thinking that, indeed. Those two fields have a more well
> > established usage, so I think you'll be better off doing that in the
> > long run.
> 
> Ok, if you say so. This and the IDE multwrite thing are the only two
> places in the kernel preventing bi_idx to be usable this way. I just
> thought it was nicer.

It is nicer, I agree. I'm not adverse to including the ll_rw_blk change,
you'll have to deal with IDE yourself :)

-- 
Jens Axboe

