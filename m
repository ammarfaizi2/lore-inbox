Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTK3R5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTK3R5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:57:18 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:20935 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262761AbTK3R5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:57:16 -0500
Date: Sun, 30 Nov 2003 18:56:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130175649.GA18670@ucw.cz>
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <3FCA2380.1050902@pobox.com> <20031130171006.GA10679@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130171006.GA10679@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 06:10:06PM +0100, Jens Axboe wrote:

> On Sun, Nov 30 2003, Jeff Garzik wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > >On Sunday 30 of November 2003 17:51, Jens Axboe wrote:
> > >>>Tangent:  My non-pessimistic fix will involve submitting a single sector
> > >>>DMA r/w taskfile manually, then proceeding with the remaining sectors in
> > >>>another r/w taskfile.  This doubles the interrupts on the affected
> > >>>chipset/drive combos, but still allows large requests.  I'm not terribly
> > >>
> > >>Or split the request 50/50.
> > >
> > >
> > >We can't - hardware will lock up.
> > 
> > Well, the constraint we must satisfy is
> > 
> > 	sector_count % 15 != 1
> 
> 	(sector_count % 15 != 1) && (sector_count != 1)
> 
> to be more precise :)

I think you wanted to say:

	(sector_count % 15 != 1) || (sector_count == 1)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
