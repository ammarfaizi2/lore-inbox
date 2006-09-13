Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWIMRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWIMRvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWIMRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:51:15 -0400
Received: from [212.33.187.119] ([212.33.187.119]:19328 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750841AbWIMRvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:51:14 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: What's in linux-2.6-block.git
Date: Wed, 13 Sep 2006 20:52:48 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200609131359.04972.a1426z@gawab.com> <200609131435.31390.a1426z@gawab.com> <20060913115615.GC4792@kernel.dk>
In-Reply-To: <20060913115615.GC4792@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200609132052.48721.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Sep 13 2006, Al Boldi wrote:
> > Jens Axboe wrote:
> > > On Wed, Sep 13 2006, Al Boldi wrote:
> > > > Jens Axboe  wrote:
> > > > > This lists the main features of the 'block' branch, which is bound
> > > > > for Linus when 2.6.19 opens:
> > > > >
> > > > > - Splitting of request->flags into two parts:
> > > > >         - cmd type
> > > > >         - modified flags
> > > > >   Right now it's a bit of a mess, splitting this up invites a
> > > > > cleaner usage and also enables us to implement generic "messages"
> > > > > passed on the regular queue for the device.
> > > > >
> > > > > - Abstract out the request back merging and put it into the core
> > > > > io scheduler layer. Cleans up all the io schedulers, and noop gets
> > > > > merging for "free".
> > > > >
> > > > > - Abstract out the rbtree sorting. Gets rid of duplicated code in
> > > > >   as/cfq/deadline.
> > > > >
> > > > > - General shrinkage of the request structure.
> > > > >
> > > > > - Killing dynamic rq private structures in deadline/as/cfq. This
> > > > > should speed up the io path somewhat, as we avoid allocating
> > > > > several structures (struct request + scheduler private request)
> > > > > for each io request.
> > > > >
> > > > > - meta data io logging for blktrace.
> > > > >
> > > > > - CFQ improvements.
> > > > >
> > > > > - Make the block layer configurable through Kconfig (David
> > > > > Howells).
> > > > >
> > > > > - Lots of cleanups.
> > > >
> > > > Does it also address the strange "max_sectors_kb<>192 causes a
> > > > 50%-slowdown" problem?
> > >
> > > (remember to cc me/others when replying, I can easily miss lkml
> > > messages for several days otherwise).
> > >
> > > It does not, the investigation of that is still pending I'm afraid.
> > > The data is really puzzling, I'm inclined to think it's drive related.
> > > Are you reproducing it just one box/drive, or on several?
> >
> > Several boxes, same drive.
>
> Have you / can you try and reproduce with another drive as well? It'd be
> an interesting data point.

Not really, as this drive is the only one supporting max_sectors_kb>128.


Thanks!

--
Al

