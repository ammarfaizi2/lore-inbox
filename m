Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSFRTaY>; Tue, 18 Jun 2002 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSFRT3y>; Tue, 18 Jun 2002 15:29:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10245 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317577AbSFRT3t>;
	Tue, 18 Jun 2002 15:29:49 -0400
Message-ID: <3D0F89D7.88F741E2@zip.com.au>
Date: Tue, 18 Jun 2002 12:28:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/19] stack space reduction (remove MAX_BUF_PER_PAGE)
References: <3D0DAD69.5C667D63@zip.com.au> <Pine.LNX.4.44.0206181006200.2347-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Jun 2002, Andrew Morton wrote:
> > Andrew Morton wrote:
> > >
> > > ..
> > > +               do {
> > > +                       if (buffer_async_read(bh))
> > > +                               submit_bh(READ, bh);
> > > +               } while ((bh = bh->b_this_page) != head);
> >
> > That's a bug.
> 
> I'm just not going to apply this patch.

Excellent idea.

There were some patches floating around a while back (Ben and Hugh,
I think) which gave x86 a 64k soft PAGE_CACHE_SIZE.  They will hit
this problem.  But they know about it now, and the fix is there.

-
