Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTHFT7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272141AbTHFT7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:59:03 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46516 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270763AbTHFT7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:59:00 -0400
Date: Wed, 6 Aug 2003 21:58:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Erik Andersen <andersen@codepoet.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
In-Reply-To: <20030806193058.GA27207@codepoet.org>
Message-ID: <Pine.SOL.4.30.0308062152530.10693-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Aug 2003, Erik Andersen wrote:

> On Wed Aug 06, 2003 at 08:32:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Wed, 6 Aug 2003, Erik Andersen wrote:
> >
> > > > Can you please resend me the patch once its accepted in 2.6 ?
> > > >
> > > > Maybe we want to test it a while in -ac, also?
> > >
> > > Ok.  Though it is being incorporated as part of a much larger
> > > patch in 2.6.  I suppose that will filter back into 2.4 when
> > > it is ready,
> >
> > Hi Erik,
> >
> > I made init_idedisk_capacity() cleanup.
> > Then I ported your patch and reworked it a bit.
> >
> > Could you take a look?
>
> I like your improvements.  The only concern I have is you
> retained my use of do_div() intact.  That needs to change since
> it turns out that do_div() directly modifies the numerator
> (violating the principle of least surprise).  See the recent
> thread on "do_div considered harmful".  In that thread, Andries
> mentions he has made a generic sectors_to_MB() function to
> consolidate such things.  which I think is a very good idea since
> then this only has to be correct once.  That would also let you
> eliminate the somewhat ugly and not particularly obvious division
> plus rounding (X - X/625 + 974)/1950 sequence from
> idedisk_check_hpa_lba28(),

Oh yes... I forgot about do_div() and sectors_to_MB().
I will correct this before submitting to Linus.

Thanks,
--
Bartlomiej

