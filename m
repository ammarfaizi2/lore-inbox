Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUCKVLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCKVLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:11:14 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:9577 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261716AbUCKVLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:11:11 -0500
Subject: Re: 2.6.4-mm1
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1079038721.5333.8.camel@redeeman.linux.dk>
References: <20040310233140.3ce99610.akpm@osdl.org>
	 <1079024816.5325.2.camel@redeeman.linux.dk>
	 <200403111453.20866.norberto+linux-kernel@bensa.ath.cx>
	 <20040311100957.00dd6e7f.akpm@osdl.org>
	 <1079028899.5327.4.camel@redeeman.linux.dk>
	 <20040311104650.009a8d3e.akpm@osdl.org>
	 <1079038721.5333.8.camel@redeeman.linux.dk>
Content-Type: text/plain
Message-Id: <1079039457.5248.2.camel@redeeman.linux.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 22:10:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yeah andrew it works! you are god!!
while i got you here, i have got a pray more for you.

its about amd64-agp. i never had it working (from 2.6.1 mm and vanilla)
but in 2.6.4-rc1-mm2 it worked! but sadly abit unstable :(

my big problem is that when using X, and having some windows opens, it
consumes ALL cpu if amd64-agp isnt in kernel, so i would REALLY
apreciate if you could look at it (sorry my bad english)

thanks!


On Thu, 2004-03-11 at 21:58, Redeeman wrote:
> gonna try now, already compiling... i will come back with details in a
> few minutes..
> 
> On Thu, 2004-03-11 at 19:46, Andrew Morton wrote:
> > Redeeman <lkml@metanurb.dk> wrote:
> > >
> > >  i didnt do anything more than patch with mm1, is there a patch for doing
> > >  that spin_unlock_irq()? :)
> > 
> > --- 25/fs/mpage.c~a	2004-03-11 10:46:29.000000000 -0800
> > +++ 25-akpm/fs/mpage.c	2004-03-11 10:46:31.000000000 -0800
> > @@ -672,7 +672,6 @@ mpage_writepages(struct address_space *m
> >  		}
> >  		pagevec_release(&pvec);
> >  	}
> > -	spin_unlock_irq(&mapping->tree_lock);
> >  	if (bio)
> >  		mpage_bio_submit(WRITE, bio);
> >  	return ret;
> > 
> > _
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards, Redeeman
redeeman@metanurb.dk

