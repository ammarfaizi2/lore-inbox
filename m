Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUHURPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUHURPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUHURPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:15:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50172 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266762AbUHURO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:14:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: serialize access to ide device
Date: Sat, 21 Aug 2004 19:13:47 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040802131150.GR10496@suse.de> <200408211643.55531.bzolnier@elka.pw.edu.pl> <20040821162155.GC7490@suse.de>
In-Reply-To: <20040821162155.GC7490@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211913.47982.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 August 2004 18:21, Jens Axboe wrote:
> On Sat, Aug 21 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 21 August 2004 12:32, Jens Axboe wrote:
> > > > What about adding new kind of REQ_SPECIAL request and converting
> > > > set_using_dma(), set_xfer_rate(), ..., to be callback functions for
> > > > this request?
> > > >
> > > > This should be a lot cleaner and will cover 100% cases.
> > >
> > > That will still only serialize per-channel. But yes, a lot cleaner.
> >
> > per hwgroup not per channel
> > (serializing per host device will be better but requires even more work)
>
> Sorry yes hwgroup, that's what I meant. The case I worried about in my
> patch (and noted) is that it doesn't cover per-hwif and neither would a
> special request.

I guess you meant 'per-host' because hwif == channel.

[ You are of course right for about 'per-host' case. ]
