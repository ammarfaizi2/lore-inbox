Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTK3RIU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTK3RIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:08:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:166 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264948AbTK3RIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:08:19 -0500
Date: Sun, 30 Nov 2003 18:08:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130170806.GZ10679@suse.de>
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311301758.53885.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Bartlomiej Zolnierkiewicz wrote:
> > Yes, it would be better to have a per-drive (or hwif) extra limiting
> > factor if it is needed. For this case it really isn't, so probably not
> > the best idea :)
> >
> > > Tangent:  My non-pessimistic fix will involve submitting a single sector
> > > DMA r/w taskfile manually, then proceeding with the remaining sectors in
> > > another r/w taskfile.  This doubles the interrupts on the affected
> > > chipset/drive combos, but still allows large requests.  I'm not terribly
> >
> > Or split the request 50/50.
> 
> We can't - hardware will lock up.

I know the problem. Then don't split 50/50 to the word, my point was to
split it closer to 50/50 than 1 sector + the rest.

-- 
Jens Axboe

