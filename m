Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWC3GSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWC3GSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWC3GSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:18:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16462 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751122AbWC3GSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:18:45 -0500
Date: Thu, 30 Mar 2006 08:18:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330061852.GE13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org> <442B2EB2.4040401@garzik.org> <20060329172057.301a41ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329172057.301a41ff.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Andrew Morton wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
> >
> > Linus Torvalds wrote:
> > > The "destination first" convention is insane. It only makes sense for 
> > > assignments, and these aren't assignments.
> > 
> > I agree.
> > 
> > But alas, sendfile(2) is defined as destination first:
> > 
> > > ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
> > 
> > which begs the question, do we want to be different from sendfile(2), 
> > and confuse a segment of the programmer populace?  :)
> > 
> 
> strcpy, memcpy...
> 
> Obviously copy(from, to) is the sane way to do things, but yeah, I _think_
> a C programmer would expect copy(to, from).
> 
> I don't think it matters much at all, really.  If they get it backwards
> they'll notice pretty quickly ;)

Yeah, I've always thought that the sendfile() arguments are stupidly
transposed :-)

-- 
Jens Axboe

