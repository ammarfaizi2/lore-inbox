Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTK3Rbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264950AbTK3Rbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:31:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4523 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262331AbTK3Rbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:31:38 -0500
Date: Sun, 30 Nov 2003 18:31:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130173127.GB6454@suse.de>
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <200311301758.53885.bzolnier@elka.pw.edu.pl> <3FCA2380.1050902@pobox.com> <20031130171006.GA10679@suse.de> <3FCA275B.1080904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA275B.1080904@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >>Well, the constraint we must satisfy is
> >>
> >>	sector_count % 15 != 1
> >
> >
> >	(sector_count % 15 != 1) && (sector_count != 1)
> >
> >to be more precise :)
> 
> 
> Thanks for the clarification, I did not know that.
> 
> Avoiding sector_count==1 requires additional code :(  Valid requests 
> might be a single sector.  With page-based blkdevs requests smaller than 
> a page would certainly be infrequent, but are still possible, with bsg 
> for example...

You misread it... sector_count == 1 is fine, sector_count % 15 == 1 is
ok when sector_count is 1 (it would have to be, or sector_count == 1
would not be ok :)

-- 
Jens Axboe

