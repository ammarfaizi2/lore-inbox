Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270629AbTGZXmC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 19:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270633AbTGZXmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 19:42:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48358 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270629AbTGZXmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 19:42:00 -0400
Date: Sun, 27 Jul 2003 01:41:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, willy@w.ods.org,
       hch@lst.de, uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Make I/O schedulers optional (Was: Re: Kernel 2.6 size increase)
Message-ID: <20030726234118.GB1170@suse.de>
References: <200307232046.46990.bernie@develer.com> <200307261440.52002.bernie@develer.com> <20030726140745.GB518@suse.de> <200307270142.47602.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307270142.47602.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27 2003, Bernardo Innocenti wrote:
> On Saturday 26 July 2003 16:07, Jens Axboe wrote:
> 
> > >  /*
> > >   *  linux/drivers/block/as-iosched.c
> > >   *
> > > - *  Anticipatory & deadline i/o scheduler.
> > > + *  Anticipatory i/o scheduler.
> > >   *
> > >   *  Copyright (C) 2002 Jens Axboe <axboe@suse.de>
> > >   *                     Nick Piggin <piggin@cyberone.com.au>
> >
> > Huh? What is that about? AS is deadline + anticipation. Good rule is not
> > to make comment changes when you don't know your changes to be a fact.
> 
> Oops, I thought it was done by mistake :-)
> 
> By the way, this comment in as-iosched.c refers to a missing file:
> 
>  /*
>   * See Documentation/as-iosched.txt
>   */

Hmm odd, maybe it never got migrated from Andrews tree.

> Another issue: to make the I/O schedulers configurable, I had to
> fiddle with ll_rw_blk.c, makiing it slightly harder to understand.

Don't worry, the current addon of additional schedulers is crap already,
so your patch has to deal with that. The real modular schedulers will
change this, removing the nasty bits that are there know. It doesn't
even belong in ll_rw_blk.c

> > About making it selectable, I'm fine with it. Please send an updated
> > patch.
> 
> Here it is:

Thanks

-- 
Jens Axboe

