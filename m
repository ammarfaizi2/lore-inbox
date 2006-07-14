Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWGNTw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWGNTw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWGNTw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:52:29 -0400
Received: from [212.76.86.155] ([212.76.86.155]:8967 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1422733AbWGNTw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:52:29 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCHSET] 0/15 IO scheduler improvements
Date: Fri, 14 Jul 2006 22:53:26 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607132350.47388.a1426z@gawab.com> <20060714071525.GP4151@suse.de>
In-Reply-To: <20060714071525.GP4151@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607142253.26372.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jul 13 2006, Al Boldi wrote:
> > Jens Axboe wrote:
> > > This is a continuation of the patches posted yesterday, I continued
> > > to build on them. The patch series does:
> > >
> > > - Move the hash backmerging into the elevator core.
> > > - Move the rbtree handling into the elevator core.
> > > - Abstract the FIFO handling into the elevator core.
> > > - Kill the io scheduler private requests, that require allocation/free
> > >   for each request passed through the system.
> > >
> > > The result is a faster elevator core (and faster IO schedulers), with
> > > a nice net reduction of kernel text and code as well.
> >
> > Thanks!
> >
> > Your efforts are much appreciated, as the current situation is a bit
> > awkward.
>
> It's a good step forward, at least.
>
> > > If you have time, please give this patch series a test spin just to
> > > verify that everything still works for you. Thanks!
> >
> > Do you have a combo-patch against 2.6.17?
>
> Not really, but git let me generate one pretty easily. It has a few
> select changes outside of the patchset as well, but should be ok. It's
> not tested though, should work but the rbtree changes needed to be done
> additionally. If it boots, it should work :-)

patch applies ok
compiles ok
panics on boot at elv_rb_del
patch -R succeeds with lot's of hunks

> I've gzip'ed the patch to avoid problems.

Thanks!

--
Al

