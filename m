Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbRGTIZD>; Fri, 20 Jul 2001 04:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbRGTIYy>; Fri, 20 Jul 2001 04:24:54 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:28430 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S266738AbRGTIYn>; Fri, 20 Jul 2001 04:24:43 -0400
Date: Fri, 20 Jul 2001 10:26:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
Message-ID: <20010720102614.A13354@suse.de>
In-Reply-To: <20010720092202.A9525@suse.de> <Pine.LNX.4.31.0107200111280.718-100000@p4.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0107200111280.718-100000@p4.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 20 2001, Linus Torvalds wrote:
> 
> 
> On Fri, 20 Jul 2001, Jens Axboe wrote:
> >
> > Attached are two patches -- one that should fix DAC960 for this new
> > completion scheme, and one that corrects the corrected comment in
> > blkdev.h :-)
> 
> No, the correction of the correction is worse.

?

> The paging stuff doesn't use any of this. The paging stuff use the page
> cache lock bit, and always has.

Paging still hits a request, I assumed that's what the (really really)
old comment meant to say.

> The only thing that uses request completion checking are special commands,
> like the initial SCSI spin-up etc (scsi_init_one()).

Sure, and IDE ide_wait etc.

-- 
Jens Axboe

