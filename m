Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbUABN0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUABN0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:26:19 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:39635 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265566AbUABN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:26:15 -0500
Subject: Re: [RFC][PATCH] Move bv_offset/bv_len update after bio_endio in
	__end_that_request_first
From: Christophe Saout <christophe@saout.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1073048438.4239.10.camel@leto.cs.pocnet.net>
References: <20040101173214.GA4496@leto.cs.pocnet.net>
	 <20040102104637.GN5523@suse.de>
	 <1073048438.4239.10.camel@leto.cs.pocnet.net>
Content-Type: text/plain
Message-Id: <1073049978.4239.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 14:26:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 02.01.2004 schrieb Christophe Saout um 14:00:

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

... but I still need bv_offset and bv_len to be unchanged in the
bio_endio call. Can we please do this?


