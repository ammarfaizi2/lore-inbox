Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264952AbTK3RMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTK3RMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:12:22 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35786 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264952AbTK3RMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:12:19 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sun, 30 Nov 2003 18:13:48 +0100
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
References: <3FC36057.40108@gmx.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <20031130170806.GZ10679@suse.de>
In-Reply-To: <20031130170806.GZ10679@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301813.48535.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 30 of November 2003 18:08, Jens Axboe wrote:
> On Sun, Nov 30 2003, Bartlomiej Zolnierkiewicz wrote:
> > > Yes, it would be better to have a per-drive (or hwif) extra limiting
> > > factor if it is needed. For this case it really isn't, so probably not
> > > the best idea :)
> > >
> > > > Tangent:  My non-pessimistic fix will involve submitting a single
> > > > sector DMA r/w taskfile manually, then proceeding with the remaining
> > > > sectors in another r/w taskfile.  This doubles the interrupts on the
> > > > affected chipset/drive combos, but still allows large requests.  I'm
> > > > not terribly
> > >
> > > Or split the request 50/50.
> >
> > We can't - hardware will lock up.
>
> I know the problem. Then don't split 50/50 to the word, my point was to
> split it closer to 50/50 than 1 sector + the rest.

Oh, I understand now and agree.

--bart

